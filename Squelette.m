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
%Mettre les constantes ici/ les stimuli déja fait, s'ils ne sont pas fait
key1 = 'q'; %Touche pour Congruent %Utiliser seulement la main gauche!
key2 = 'e'; % Touche pour incongruent
frequencies = 1; %Le nombre de stimuli total

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Mise en mémoire des images - dossier en construction (fruits / outils) -
%fruits sont en png, a voir pour outils - conversion possible
%%
%Ceci est la boucle pour les images randomisées
%for Z = 1:size(images)  
   % montrerIm=(idxIm(Z)); 
   % figure, imshow(images{montrerIm});%Montre l'image à la valeur de l'array choisie
%end
%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Ceci est utile pour générer un rng
randi([1 30]) %serait randperm(30,30)?

%Ces fonctions d'enregistrement d'image seront importantes.
%pour clear le screen de ptb
%ctrl-0.

%randperm(5, 1) 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%Voici la partie du squelette qui fonctionne sur PTB
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

mot_pommeSU = ["Une", "pomme"];
mot_bananeSU = ["Une", "banane"];
mot_pecheSU = ["Une", "peche"];
mot_melonSU = ["Un", "melon"];
mot_mangueSU = ["Une", "mangue"];
mot_fraiseSU = ["Une", "fraise"];

mot_pommeSL = ["La", "pomme"];
mot_bananeSL = ["La", "banane"];
mot_pecheSL = ["La", "peche"];
mot_melonSL = ["Le", "melon"];
mot_mangueSL = ["La", "mangue"];
mot_fraiseSL = ["La", "fraise"];


mot_pommePD = ["Des", "pommes"];
mot_bananePD = ["Des", "bananes"];
mot_pechePD = ["Des", "peches"];
mot_melonPD = ["Des", "melons"];
mot_manguePD = ["Des", "mangues"];
mot_fraisePD = ["Des", "fraises"];

mot_pommePP = ["Plusieurs", "pommes"];
mot_bananePP = ["Plusieurs", "bananes"];
mot_pechePP = ["Plusieurs", "peches"];
mot_melonPP = ["Plusieurs", "melons"];
mot_manguePP = ["Plusieurs", "mangues"];
mot_fraisePP = ["Plusieurs", "fraises"];

mot_patateSU = ["Une", "patate"];
mot_carotteSU = ["Une", "carotte"];
mot_tomateSU = ["Une", "tomate"];
mot_oignonSU = ["Un", "oignon"];
mot_citrouilleSU = ["Une", "citrouille"];
mot_broccoliSU = ["Un", "broccoli"];

mot_patateSL = ["La", "patate"];
mot_carotteSL = ["La", "carotte"];
mot_tomateSL = ["La", "tomate"];
mot_oignonSL = ["L'", "oignon"];
mot_citrouilleSL = ["La", "citrouille"];
mot_broccoliSL = ["Le", "broccoli"];

mot_patatePD = ["Des", "patates"];
mot_carottePD = ["Des", "carottes"];
mot_tomatePD = ["Des", "tomates"];
mot_oignonPD = ["Des", "oignons"];
mot_citrouillePD = ["Des", "citrouilles"];
mot_broccoliPD = ["Des", "broccolis"];

mot_patatePP = ["Plusieurs", "patates"];
mot_carottePP = ["Plusieurs", "carottes"];
mot_tomatePP = ["Plusieurs", "tomates"];
mot_oignonPP = ["Plusieurs", "oignons"];
mot_citrouillePP = ["Plusieurs", "citrouilles"];
mot_broccoliPP = ["Plusieurs", "broccolis"];

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
ArrStr = {[mot_pommeSU]; [mot_pommeSL];[mot_pommePD]; [mot_pommePP];[mot_bananeSU]; [mot_bananeSL] ;[mot_bananePD]; [mot_bananePP]; [mot_mangueSU]; [mot_mangueSL]; 
    [mot_manguePD]; [mot_manguePP];[mot_pecheSU]; [mot_pecheSL];[mot_pechePD]; [mot_pechePP]; [mot_fraiseSU] ;[mot_fraiseSL];[mot_fraisePD]; [mot_fraisePP]; 
    [mot_melonSU]; [mot_melonSL];[mot_melonPD]; [mot_melonPP];
   [mot_broccoliSU]; [mot_broccoliSL];[mot_broccoliPD]; [mot_broccoliPP]; [mot_carotteSU]; [mot_carotteSL] ;[mot_carottePD]; [mot_carottePP];
   [mot_oignonSU]; [mot_oignonSL]; [mot_oignonPD]; [mot_oignonPP]
    [mot_patateSU]; [mot_patateSL]; [mot_patatePD]; [mot_patatePP]; [mot_citrouilleSU]; [mot_citrouilleSL];[mot_citrouillePD]; [mot_citrouillePP]; 
    [mot_tomateSU]; [mot_tomateSL];  [mot_tomatePD]; [mot_tomatePP]};%on les met dans un array
ArrStr = randmise_des_mots(ArrStr,0); %Ici, on randomise 4 éléments à la fois
[~,idx] = sort(rand(size(ArrStr))) %Permet de faire une série de valeurs randomisés, mais ca reste apparié aux images
idx=randperm(max(size(ArrStr)), max(size(ArrStr)));
rng='shuffle';
images = {i_pommeS;i_pommeS; i_pommeP;i_pommeP; i_bananeS;i_bananeS;i_bananeP;i_bananeP; i_mangueS;i_mangueS;i_mangueP;i_mangueP; i_pecheS;i_pecheS;i_pecheP;i_pecheP; i_fraiseS;i_fraiseS;i_fraiseP;i_fraiseP; i_melonS;i_melonS;i_melonP;i_melonP;
      i_broccoliS; i_broccoliS; i_broccoliP; i_broccoliP;
    i_carotteS; i_carotteS;i_carotteP; i_carotteP; i_onionS; i_onionS; i_onionP; i_onionP;
    i_patateS; i_patateS;i_patateP; i_patateP; i_citrouilleS; i_citrouilleS; i_citrouilleP; i_citrouilleP; i_tomateS; i_tomateS;i_tomateP;i_tomateP };%Les images sont en doubles 
images=changer_taille_image(images)%Cette fonction va resize les images
[windowPtr,rect]=Screen('OpenWindow',screenNumber, [128 128 128]); %Le screen avec un fond de gris
resolutions = Screen('Resolution', screenNumber);

%%
%Main Loop
%Screen('BlendFunction', Cfg.win, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
%hidecursor;
for z=1:size(ArrStr) %Ici le size fonctionne, donc de 1 à 5...
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
  Screen('DrawText', windowPtr,num2str(ArrStr{montrer}(x)), (resolutions.width/2)-((max(size(num2str(ArrStr{montrer}(x))))*2)*(resolutions.width/250)), resolutions.height*0.465); 
  %Cette catastrophe tente de centrer les mots
  Screen('Flip', windowPtr);
  WaitSecs(0.3);
    end
 Screen('Flip', windowPtr);
 %Ici il faut attendre l'imput du participant
%=======
%Input

RT=entrer_imput(resolutions,windowPtr); %Fonction des imput

%Ici on save le stuff
position=z;
mot=join(ArrStr{montrer});
Reaction=RT{1};
Touche=RT{2};
%Au lien de faire save, faire un giga array. on savera en excel le gros
%array apres
%save([file_name '_'  num2str(position)], 'mot','RT', 'Reaction', 'Touche');
%Cette partie permet de sauvegarder
end
%showcursor;
ListenChar(1);
sca;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%Voici la fonction pour la croix de fixation
function croix_fixation = fabriquer_fixation(resolutions,windowPtr)
Screen('DrawLine', windowPtr, [0 0 0], resolutions.width/2, resolutions.height*0.45, resolutions.width/2, resolutions.height*0.55, 5);
Screen('DrawLine', windowPtr, [0 0 0], resolutions.width*0.50+((resolutions.height*0.55-resolutions.height*0.45)/2), resolutions.height/2, resolutions.width*0.50-((resolutions.height*0.55-resolutions.height*0.45)/2), resolutions.height/2, 5);
Screen('Flip', windowPtr);
WaitSecs(0.5);
end

%%
%Voici la fonction pour l'affichage de la commande
function commande=afficher_commande(resolutions, windowPtr)
%[windowPtr,rect]=Screen('OpenWindow',screenNumber, [128 128 128]);
Screen('FillRect', windowPtr, [100 100 100], [resolutions.width*.37, resolutions.height*.58, resolutions.width*.45, resolutions.height*.65]);
Screen('FillRect', windowPtr, [100 100 100], [resolutions.width*.57, resolutions.height*.58, resolutions.width*.66, resolutions.height*.65]);
Screen('DrawText', windowPtr, 'Q=Congruent', resolutions.width*.37, resolutions.height*.60);
Screen('DrawText', windowPtr, 'W=Incongruent', resolutions.width*.57, resolutions.height*.60);
Screen('Flip', windowPtr);
WaitSecs(2);
sca;
end

%end
%%
function RT=entrer_imput(resolutions,windowPtr)
start = GetSecs;
exitKey = 'l';
ListenChar(2);
ListenChar(2);
[secs, keyCode, deltaSecs] = KbWait([], 2);

temp = KbName(keyCode); %%lettre a save
while ~strcmp(temp, 'q') %TROUVER FACON DE METTRE 2E LETTRE
[secs, keyCode, deltaSecs] = KbWait([], 2);
temp = KbName(keyCode); %%lettre a save
    if  strcmp(temp, exitKey)
    %Screen('FillRect', windowPtr, [100 100 100], [resolutions.width*.37, resolutions.height*.58, resolutions.width*.45, resolutions.height*.65]);
    Screen('DrawText', windowPtr, 'Abortion de la présentation', resolutions.width*.28, resolutions.height*.465);   
    Screen('Flip', windowPtr);
    WaitSecs(2);
    ListenChar(1);
    sca;   
    break
end
    [secs, keyCode, deltaSecs] = KbWait([], 2);
   % RT = secs - start;
temp = KbName(keyCode); %%lettre a save
end
RT = secs - start;
RT = {RT, temp};

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
            %disp(['bb(y)', num2str(bb(y))]);
            %disp(['y=', num2str(y)]);
            %disp(['x=', num2str(x)]);
            %disp(['ending=', num2str(ending)]);
        end
        ending=ending+4;
    end
end