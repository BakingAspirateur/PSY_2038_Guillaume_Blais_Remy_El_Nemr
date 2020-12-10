function experience = Squelette(subName, trial)

%% Tâche visuelle de congruence de quantité
%Dans cette expérience, le PTB est utilisé pour afficher des images chargée
%d'un dossier suivie d'une suite de mot, adjectif-nom, qui seront
%congruents ou non avec la quantité de l'image. 

%Référence:Arcara, Giorgio et al. (2019). One can be some but some cannot be one: ERP correlates of numerosity incongruence are different for singular and plural. Cortex, 116:104-121.
%Frederic Gosselin

% L'expérience principale se trouve dans le fichier: 'PSY_2038_Guillaume_Blais_Remy_El_Nemr', 
% Les fonctions annexes sont à la fin du scripte

% Le scripte crée un dossier 'Squelette_Sujet_[Nom_du_participant]
%Le nom du participant doit impérativement être un string 'NOM'
% Le ficher MAT et un fichier excel sont sauvegardés dans ce dossier 
% Un array est transformé en tableau et sauvegardé;
%le tableau comporte les variables suivantes: Participant, les 4 mots, les TR, la
%touche appuyée, la congruence, la présence d'erreur
% La valeur de R et de P d'une corrélation entre la congruence et les TR
% est ressortie

% Vous aurez besoin de Psychtoolbox (http://psychtoolbox.org).
% Vous aurez besion du fichier .txt 'Frtuit.txt' et le dossier
% 'Immages_load'

% Script fait par Guillaume Blais & Rémy El-Nemr(2020)
% guillaume.blais@umontreal.ca & remy.el-nemr@umontreal.ca 
%Script présenté à Simon Faghel-Soubeyra dans le cadre du cours PSY2038,
%Programmation en neuroscience cognitive
%%
% On vérifie si le document existe seulement dans les vraies stimulations
if trial ~=0
file_name=['Squelette_sujet_',char(subName)];
if exist(file_name,'dir')
	warning('Ce numéro de participant existe déja. Entrez en un autre')
    reenter = input('Écraser le dossier ou non (n)? ', 's');
    if strcmp(reenter, 'n')
        subName=input('Entrez un autre nom');
        file_name=['Squelette_sujet_',char(subName)];              
    end
    
end
end
%%
%Les paramètres de l'écran
Screen('Preference','VisualDebugLevel', 0);
Screen('Preference', 'SkipSyncTests', 1);    % put 1 if the sync test fails
KbName('UnifyKeyNames'); 
AssertOpenGL;
screens=Screen('Screens');
screenNumber=max(screens); % va toujours chercher l'écran secondaire
%screenNumber=1;
[width_in_mm, height_in_mm]=Screen('DisplaySize', screenNumber);
resolutions = Screen('Resolution', screenNumber);
pixel_in_mm = width_in_mm/resolutions.width;
width_in_mm=width_in_mm/pixel_in_mm;
height_in_mm=height_in_mm/pixel_in_mm;
hz=Screen('FrameRate', screenNumber);
%%
%%
%Les propriétés du son
Fe = 44100;     
duree = 0.4;      
freq = 2000;    
etendue = (0:duree*Fe-1) / (Fe-1);
min(etendue)
max(etendue)
un_son = sin(2 * pi * freq * etendue);
%%
rng='shuffle';
counter = 0;
%On utilise la fonction pour loader les mots d'un .txt file
ArrStr = creer_array;
Array_pour_les_images=ArrStr;%On dédouble l'array pour les résultats
ArrStr = randmise_des_mots(ArrStr,0); %Ici, on randomise 4 éléments à la fois
idx=randperm(max(size(ArrStr)), max(size(ArrStr)));%La suite de nombres random
images = load_les_images; %Load les images
images=changer_taille_image(images);%Cette fonction va resize les images
[windowPtr,rect]=Screen('OpenWindow',screenNumber, [128 128 128]); %Le screen avec un fond de gris
%%
%Affichage des consignes
%Screen('BlendFunction', Cfg.win, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
HideCursor;
Screen(windowPtr,'TextFont', 'Arial');
Screen('DrawText', windowPtr, 'Quand les mots affichés correspondent à l''image, appuyez sur Q.', (width_in_mm*0.315), height_in_mm*0.35);
Screen('DrawText', windowPtr, 'Quand les mots affichés ne correspondent pas à l''image, appuyez sur E.', (width_in_mm*0.30), height_in_mm*0.50);
Screen('DrawText', windowPtr, 'Appuyez sur la touche Espace pour commencer.', (width_in_mm*0.365), height_in_mm*0.65);
%%Faudra juste aligner les textes, il est 2h20am sorry
Screen('Flip', windowPtr);
ListenChar(1);
[secs, keyCodeI, deltaSecs] = KbWait([],2);
tempI = KbName(keyCodeI); 
while ~strcmp(tempI, 'space')
     [secs, keyCodeI2, deltaSecs] = KbWait([],2);
     tempI2 = KbName(keyCodeI2);
     tempI = tempI2;
end
ListenChar(0);
%%
%Main loop
for z=1:max(size(ArrStr))
    counter = counter + 1;
    fabriquer_fixation(resolutions,windowPtr); %Fait la croix de fixation
    montrer=idx(z); %montrer est ma valeur randomisée
    texturePtr(1)= Screen('MakeTexture', windowPtr, images{montrer}); %On crée une variable texture à chaque fois
    Screen('DrawTexture', windowPtr,texturePtr(1) );
    Screen('Flip', windowPtr)
    WaitSecs(1);
    for x=1:2 %Chaque suite de mots est composée de 2 mots
        Screen('TextSize', windowPtr, 100);
        Screen('DrawText', windowPtr,char(ArrStr{montrer}(x)), (width_in_mm/2)-((max(size(ArrStr{montrer}(x)))*2)*(width_in_mm/250))-width_in_mm*.05, height_in_mm*0.465); 
        %Screen('DrawText', windowPtr,char(ArrStr{montrer}(x)), width_in_mm*.45, height_in_mm*0.465);
        Screen('Flip', windowPtr);
        WaitSecs(0.3);
    end
    Screen('Flip', windowPtr);
    RT=entrer_imput(resolutions,windowPtr); %Fonction des imput
    
    %Sauvegarde des données dans 3 arrays
    mot=ArrStr{montrer}; 
    image_mot=Array_pour_les_images{montrer};
    congruence= strcmp(mot{2},image_mot{2});
    Array_TR(z)=[RT{1}]; %permet de visualiser les TR
    erreur=0;
    %On essaie de faire du feedback
    if (congruence == true && strcmp(RT{2},'e'))
        sound(un_son, Fe);
        erreur='ERREUR';
        WaitSecs(0.4);
    end
     if (congruence == false && strcmp(RT{2},'q'))
            sound(un_son, Fe);
            erreur='ERREUR';
            WaitSecs(0.4);
     end
    
     if trial == 0 && counter == 4
         sca;
         return;
     end
     if trial ~=0
    Array_congruence(z)=congruence; %donne un boolean pour la congruence
    Array_final(z)={[[file_name '_'  num2str(z)], mot,image_mot, RT{1}, RT{2}, congruence, erreur]}; %On save les résultats dans un array
     end
end
Screen('DrawText', windowPtr, 'Fin de la stimulation', width_in_mm*.20, height_in_mm*.465);
Screen('Flip', windowPtr);
WaitSecs(2.0);
sauvegarde;
%%
%Voici la fonction pour la croix de fixation
function fabriquer_fixation(resolutions,windowPtr)
%Screen('DrawLine', windowPtr, [0 0 0], width_in_mm/2, height_in_mm*0.45, width_in_mm/2, height_in_mm*0.55, 5);
%Screen('DrawLine', windowPtr, [0 0 0], width_in_mm*0.50+((height_in_mm*0.55-height_in_mm*0.45)/2), height_in_mm/2, width_in_mm*0.50-((height_in_mm*0.55-height_in_mm*0.45)/2), height_in_mm/2, 5);
Screen('DrawLine', windowPtr, [0 0 0], width_in_mm/2, height_in_mm*0.45, width_in_mm/2, height_in_mm*0.55, 5);
Screen('DrawLine', windowPtr, [0 0 0], width_in_mm*0.50+((height_in_mm*0.55-height_in_mm*0.45)/2), height_in_mm/2, width_in_mm*0.50-((height_in_mm*0.55-height_in_mm*0.45)/2), height_in_mm/2, 5);
Screen('Flip', windowPtr);
WaitSecs(0.5);
end
%
%La fonction qui permet de rentrer les imputs et de sortir de la
%stimulation, en sauvegardant les données en .xlsx
function RT=entrer_imput(resolutions,windowPtr)
start = GetSecs;
exitKey = 'l';
ListenChar(2);
[secs, keyCode, deltaSecs] = KbWait([], 2);
temp = KbName(keyCode); %%lettre a save
temp2 = temp;
if strcmp(temp, 'q') | strcmp(temp, 'e')
    ListenChar(0);
    RT = secs - start;
    RT = {RT, temp};
    return; %% correction - maintenant, l'utilisateur n'aura plus a presser 2 fois sur q ou l
end

ListenChar(2);
    while (~(strcmp(temp2, 'q')) | ~(strcmp(temp2, 'e')) )
        %Cette partie permet de sauvegarder meme si
        ListenChar(2);
        [secs, keyCode2, deltaSecs] = KbWait([],2);
        temp2 = KbName(keyCode2);
        if  strcmp(temp, exitKey)
            Screen('DrawText', windowPtr, 'Closure de la présentation', width_in_mm*.24,height_in_mm*.465);   
            Screen('Flip', windowPtr);
            sauvegarde;
            break;
        end
        %ListenChar(2);
       % [secs, keyCode2, deltaSecs] = KbWait([],2);
       % temp2 = KbName(keyCode2);
        if strcmp(temp2, 'q') | strcmp(temp2, 'e')
            ListenChar(0);
            break; 
        end
    end
RT = secs - start;
RT = {RT, temp2};
ListenChar(0);
end
%%
%La fonction qui permet de resize les images en 400x400
function images = changer_taille_image(images)
for taille_array = 1: max(size(images))   
    images{taille_array}=imresize(images{taille_array}, [400,400]);
end
end
%%
%La fonction qui randomise les mots en quatriades
function ArrStr = randmise_des_mots(ArrStr,ending)
    for x = 1 :max(size(ArrStr)/4)
        %ending=0;
        bb=randperm(4,4);
        Array_temp={ArrStr{ending+1},ArrStr{ending+2},ArrStr{ending+3},ArrStr{ending+4}};
        for y=1:4
            ArrStr{y+ending}=Array_temp{(bb(y))};          
        end
        ending=ending+4;
    end
end
%%
%La fonction qui load les mots d'un document .txt
function ArrStr = creer_array
    ending1=0;
    fidd=fopen('Fruit.txt'); %Le fichier est prédéfini
    notre_array=textscan(fidd,'%s','delimiter','\n');
    for fine = 1 : (max(size(notre_array{1}))/2)
        ArrStr{fine} = [notre_array{1}(ending1+1), notre_array{1}(ending1+2)];
        ending1=ending1+2;
    end   
end
%%
%la fonction qui load les images ET qui les double
function images = load_les_images   
    myFolder = ('Images_load');
    myFolder=what(myFolder);
    myFolder=myFolder.path;
    filePattern = fullfile(myFolder, '*.png');
    pngFiles = dir(filePattern);
    jj=0;%Ceci permet de ne pas briser l'élément 1
    for k = 1:length(pngFiles)
        baseFileName = pngFiles(k).name;
        fullFileName = fullfile(myFolder, baseFileName);
        imageArray{k} = imread(fullFileName);     
    end
    images=imageArray;
    for ii = 1 : max(size(imageArray))
        for kk = 0:1
        images{ii+kk+jj} = imageArray{ii};    
        end
    jj=ii; %Permet de garder l'élément 1
    end
end
%%
function sauvegarde
    %La fonction qui permet de sauvegarder le tout et de faire un tableau
    %Excel ET matlab
    %La fonction crée aussi le dossier dans lequel ca sera sauvegardé
    colname={'Stimulus', 'Déterminant_Mot', 'Nom_Mot', 'Déterminant_image', 'Nom_Image', 'TR','Lettre','Congruence', 'Erreur'};
    myFolder2 = ('PSY_2038_Guillaume_Blais_Remy_El_Nemr');
    myFolder2=what(myFolder2);
    myFolder2=myFolder2.path;
    myFolder3=[myFolder2 '\' file_name];
    mkdir(myFolder3); %Création du dossier
    Array_table=cell2table((Array_final.'));
    Array_table=table2array(Array_table);
    Array_table=cell2table(Array_table, 'VariableNames',colname);
    [R,P]=corrcoef(double(Array_congruence.'),Array_TR.');
    save([myFolder3 '\' file_name], 'Array_table', 'Array_TR', 'Array_congruence','R','P');
    writetable(Array_table, [myFolder3 '\' file_name '.xlsx']);
    plot(Array_TR);
    xlabel('Essai'),ylabel('TR'),title('Distribution des TR par les essais');           
    WaitSecs(2);
    ShowCursor;
    ListenChar(1);    
    sca;   
end

end