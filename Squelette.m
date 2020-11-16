function experience = Squelette(subNum)
%KbName(‘UnifyKeyNames’)

%Squelette de travail
% Checks if file name already exists
file_name = sprintf('Squelette_sujet%d', subNum);
if fopen([file_name,'.mat'])>0
	warning('This filename already exists.')
    reenter = input('Overwrite (y/n)? ', 's');
    if strcmp(reenter, 'n')
    	subNum = str2double(input('Enter new subject number: ', 's'));
        
    end
end
save(file_name);
%Les elements sont psudo randomisés
Screen('Preference', 'SkipSyncTests', 1);    % put 1 if the sync test fails
KbName('UnifyKeyNames'); 
AssertOpenGL;
screens=Screen('Screens');
screenNumber=max(screens); % va toujours chercher l'�cran secondaire
%Beaucoup de choses ici ne sont pas importantes...
[width_in_mm, height_in_mm]=Screen('DisplaySize', screenNumber);
resolutions = Screen('Resolution', screenNumber);
pixel_in_mm = width_in_mm/resolutions.width;
hz=Screen('FrameRate', screenNumber);

%Ici on load les images
i_pommeS = imread('apple.png');
i_bananeS = imread('banana.png');
i_mangueS = imread('mango.png');
i_pecheS = imread('peach.png');
i_fraiseS = imread('strawberry.png');
i_melonS = imread('watermelon.png');
i_pommeP = imread('Many_apple.png');
i_bananeP = imread('Many_banana.png');
i_mangueP = imread('Many_mango.png');
i_pecheP = imread('Many_peach.png');
i_fraiseP = imread('Many_strawberry.png');
i_melonP = imread('Many_watermelon.png');
i_broccoliS = imread('broccoli.png');
i_carotteS = imread('carrot.png');
i_onionS = imread('onion.png');
i_patateS = imread('potato.png');
i_citrouilleS = imread('pumpkin.png');
i_tomateS = imread('tomato.png');
i_broccoliP = imread('Many_broccoli.png');
i_carotteP = imread('Many_carrot.png');
i_onionP = imread('Many_onion.png');
i_patateP = imread('Many_potato.png');
i_citrouilleP = imread('Many_pumpkin.png');
i_tomateP = imread('Many_tomato.png');
%C'est tres contre intuitif, mais ca fonctionne
%On utilise ma SUPER fonction pour loader les mots d'un .txt file
ArrStr = creer_array;
Array_pour_les_images=ArrStr;

ArrStr = randmise_des_mots(ArrStr,0); %Ici, on randomise 4 éléments à la fois
%[~,idx] = sort(rand(size(ArrStr))) %Permet de faire une série de valeurs randomisés, mais ca reste apparié aux images
idx=randperm(max(size(ArrStr)), max(size(ArrStr)));
rng='shuffle';
images = {i_pommeS;i_pommeS; i_pommeP;i_pommeP; i_bananeS;i_bananeS;i_bananeP;i_bananeP; i_mangueS;i_mangueS;i_mangueP;i_mangueP; i_pecheS;i_pecheS;i_pecheP;i_pecheP; i_fraiseS;i_fraiseS;i_fraiseP;i_fraiseP; i_melonS;i_melonS;i_melonP;i_melonP;
      i_broccoliS; i_broccoliS; i_broccoliP; i_broccoliP;
    i_carotteS; i_carotteS;i_carotteP; i_carotteP; i_onionS; i_onionS; i_onionP; i_onionP;
    i_patateS; i_patateS;i_patateP; i_patateP; i_citrouilleS; i_citrouilleS; i_citrouilleP; i_citrouilleP; i_tomateS; i_tomateS;i_tomateP;i_tomateP };%Les images sont en doubles 
images=changer_taille_image(images)%Cette fonction va resize les images
[windowPtr,rect]=Screen('OpenWindow',screenNumber, [128 128 128]); %Le screen avec un fond de gris
%resolutions = Screen('Resolution', screenNumber);

%%
%Main Loop
%Screen('BlendFunction', Cfg.win, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
%hidecursor;
for z=1:max(size(ArrStr)) %Ici le size fonctionne, donc de 1 à 5...
    fabriquer_fixation(resolutions,windowPtr);

%remplacer la croix de fixation par une fonction
    montrer=idx(z); %montrer est ma valeur randomisée
    ending=max(size(ArrStr{montrer})); % Size ne fonctionne pas apres, so on trouve une fin à la phrase
      texturePtr(1)= Screen('MakeTexture', windowPtr, images{montrer}); %On crée une variable texture à chaque fois... c'est de la folie
   Screen('DrawTexture', windowPtr,texturePtr(1) );
    Screen('Flip', windowPtr)
    WaitSecs(1);
    for x=1:ending
        Screen('TextSize', windowPtr, 100);
        Screen(windowPtr,'TextFont', 'Garamond');

  Screen('DrawText', windowPtr,char(ArrStr{montrer}(x)), (resolutions.width/2)-((max(size(ArrStr{montrer}(x)))*2)*(resolutions.width/250))-resolutions.width*.05, resolutions.height*0.465); 
  %Cette catastrophe tente de centrer les mots
  Screen('Flip', windowPtr);
  WaitSecs(0.3);
    end
 Screen('Flip', windowPtr);
%Input
RT=entrer_imput(resolutions,windowPtr); %Fonction des imput
%Ici on save le stuff
mot=ArrStr{montrer};
image_mot=Array_pour_les_images{montrer};
congruence= strcmp(mot{2},image_mot{2});
Array_TR(z)=[RT{1}]; %permet de visualiser les TR
Array_congruence(z)=congruence;
Array_final(z)={[[file_name '_'  num2str(z)], mot,image_mot, RT{1}, RT{2}, congruence]};
end
%showcursor;
ListenChar(1);
sca;
Array_table=cell2table(Array_final.');
save([file_name '_' 'FINAL'], 'Array_table', 'Array_TR', 'Array_congruence');
writetable(Array_table, [file_name '.xlsx']);
%%
%Voici la fonction pour la croix de fixation
function croix_fixation = fabriquer_fixation(resolutions,windowPtr)
Screen('DrawLine', windowPtr, [0 0 0], resolutions.width/2, resolutions.height*0.45, resolutions.width/2, resolutions.height*0.55, 5);
Screen('DrawLine', windowPtr, [0 0 0], resolutions.width*0.50+((resolutions.height*0.55-resolutions.height*0.45)/2), resolutions.height/2, resolutions.width*0.50-((resolutions.height*0.55-resolutions.height*0.45)/2), resolutions.height/2, 5);
Screen('Flip', windowPtr);
WaitSecs(0.5);
end
%%
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
        if  strcmp(temp, exitKey)
            Screen('DrawText', windowPtr, 'Abortion de la présentation', resolutions.width*.24, resolutions.height*.465);   
            Screen('Flip', windowPtr);
            Array_table=cell2table(Array_final.');
            save([file_name '_' 'FINAL'], 'Array_table', 'Array_TR', 'Array_congruence');
            writetable(Array_table, [file_name '.xlsx']);
            WaitSecs(2);
            ListenChar(1);    
            sca;   
            break;
        end
        ListenChar(2);
        [secs, keyCode2, deltaSecs] = KbWait([],2);
        temp2 = KbName(keyCode2);
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
function images = changer_taille_image(images)

for taille_array = 1: max(size(images))
    
    images{taille_array}=imresize(images{taille_array}, [400,400]);
end
end
%%
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
end
%%
%La fonction qui va sauver beaucoup de place :^)
function ArrStr = creer_array
    ending1=0;
    fidd=fopen('Fruit.txt');
    notre_array=textscan(fidd,'%s','delimiter','\n');
    for fine = 1 : (max(size(notre_array{1}))/2)
        ArrStr{fine} = [notre_array{1}(ending1+1), notre_array{1}(ending1+2)];
        ending1=ending1+2;
    end   
end