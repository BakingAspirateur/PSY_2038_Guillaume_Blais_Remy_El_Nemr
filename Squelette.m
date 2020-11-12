function experience = Squelette(subNum)

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
AssertOpenGL;
screens=Screen('Screens');
screenNumber=max(screens); % va toujours chercher l'�cran secondaire
%Beaucoup de choses ici ne sont pas importantes...
[width_in_mm, height_in_mm]=Screen('DisplaySize', screenNumber);
resolutions = Screen('Resolution', screenNumber);
pixel_in_mm = width_in_mm/resolutions.width;
hz=Screen('FrameRate', screenNumber);

UFS1 = ["Une", "pomme"];
UFS2 = ["Une", "banane"];
UFS3 = ["Une", "peche"];
UFS4 = ["Un", "melon"];
UFS5 = ["Une", "mangue"];
UFS6 = ["Une", "fraise"];

LFS1 = ["La", "pomme"];
LFS2 = ["La", "banane"];
LFS3 = ["La", "peche"];
LFS4 = ["Le", "melon"];
LFS5 = ["La", "mangue"];
LFS6 = ["La", "fraise"];

ULG1 = ["Une", "patate"];
ULG2 = ["Une", "banane"];
ULG3 = ["Une", "peche"];
ULG4 = ["Un", "melon"];
ULG5 = ["Une", "mangue"];
ULG6 = ["Une", "fraise"];

DFP1 = ["Des", "pommes"];
DFP2 = ["Des", "bananes"];
DFP3 = ["Des", "peches"];
DFP4 = ["Des", "melons"];
DFP5 = ["Des", "mangues"];
DFP6 = ["Des", "fraises"];

PFP1 = ["Plusieurs", "pommes"];
PFP2 = ["Plusieurs", "bananes"];
PFP3 = ["Plusieurs", "peches"];
PFP4 = ["Plusieurs", "melons"];
PFP5 = ["Plusieurs", "mangues"];
PFP6 = ["Plusieurs", "fraises"];

%Remy: Changer images, faire legumes, agrandir ArrStr

I1 = imread('Test.jpg');
I2 = imread('dune2020_large.jpg');
I3 = imread('image001.jpg');
I4 = imread('Test2.jpg');
I5 = imread('damier.png');
%C'est tres contre intuitif, mais ca fonctionne
ArrStr = {[UFS1]; [UFS2]; [UFS3] ; [UFS4]; [UFS5];[UFS1]; [UFS2]; [UFS3] ; [UFS4]; [UFS5],;[UFS1]; [UFS2]; [UFS3] ; [UFS4]; [UFS5];[UFS1]; [UFS2]; [UFS3] ; [UFS4]; [UFS5]; [UFS1]; [UFS2]; [UFS3] ; [UFS4]; [UFS5]}; %on les met dans un array
[~,idx] = sort(rand(size(ArrStr))) %Permet de faire une série de valeurs randomisés
idx=randperm(max(size(ArrStr)), max(size(ArrStr)));
rng='shuffle';
images = {I1 ; I2 ; I3; I4; I5};%Les images sont dans les arrays
[windowPtr,rect]=Screen('OpenWindow',screenNumber, [128 128 128]); %Le screen avec un fond de gris
resolutions = Screen('Resolution', screenNumber);
for z=1:size(ArrStr) %Ici le size fonctionne, donc de 1 à 5...
    Screen('DrawLine', windowPtr, [0 0 0], resolutions.width/2, resolutions.height*0.45, resolutions.width/2, resolutions.height*0.55, 5);
Screen('DrawLine', windowPtr, [0 0 0], resolutions.width*0.50+((resolutions.height*0.55-resolutions.height*0.45)/2), resolutions.height/2, resolutions.width*0.50-((resolutions.height*0.55-resolutions.height*0.45)/2), resolutions.height/2, 5);
Screen('Flip', windowPtr);
WaitSecs(0.5);

%remplacer la croix de fixation par une fonction
    montrer=idx(z); %montrer est ma valeur randomisée
    ending=max(size(ArrStr{montrer})); % Size ne fonctionne pas apres, so on trouve une fin à la phrase
      texturePtr(1)= Screen('MakeTexture', windowPtr, images{montrer}); %On crée une variable texture à chaque fois... c'est de la folie
   Screen('DrawTexture', windowPtr,texturePtr(1) );
    Screen('Flip', windowPtr)
    WaitSecs(1);
    for x=1:ending
        
  Screen('DrawText', windowPtr,num2str(ArrStr{montrer}(x)), (resolutions.width/2)-((max(size(num2str(ArrStr{montrer}(x))))*0.75)*(resolutions.width/250)), resolutions.height*0.48); 
  %Cette catastrophe tente de centrer les mots
  Screen('Flip', windowPtr);
  WaitSecs(0.3);
    end
 Screen('Flip', windowPtr);
WaitSecs(0.5); %Ici il faut attendre l'imput du participant
%=======
%Input

start = GetSecs;
ListenChar(2);
[secs, keyCode, deltaSecs] = KbWait([], 2);
temp = KbName(keyCode); %%lettre a save
ListenChar(0);
RT = secs - start; %% temps de reaction a save
mot=join(ArrStr{montrer});
%Ici on save le stuff
position=z;
mot=join(ArrStr{montrer});
save([file_name '_'  num2str(position)], 'mot', 'RT', 'temp' );
end

sca;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%Voici la fonction pour la croix de fixation
function croix_fixation = fabriquer_fixation(resolutions)
Screen('DrawLine', windowPtr, [0 0 0], resolutions.width/2, resolutions.height*0.45, resolutions.width/2, resolutions.height*0.55, 5);
Screen('DrawLine', windowPtr, [0 0 0], resolutions.width*0.50+((resolutions.height*0.55-resolutions.height*0.45)/2), resolutions.height/2, resolutions.width*0.50-((resolutions.height*0.55-resolutions.height*0.45)/2), resolutions.height/2, 5);
Screen('Flip', windowPtr);
WaitSecs(0.5);
end

%%
%Voici la fonction pour l'affichage de la commande
function commande=afficher_commande(resolutions)
[windowPtr,rect]=Screen('OpenWindow',screenNumber, [128 128 128]);
Screen('FillRect', windowPtr, [100 100 100], [resolutions.width*.37, resolutions.height*.58, resolutions.width*.45, resolutions.height*.65]);
Screen('FillRect', windowPtr, [100 100 100], [resolutions.width*.57, resolutions.height*.58, resolutions.width*.66, resolutions.height*.65]);
Screen('DrawText', windowPtr, 'Q=Congruent', resolutions.width*.37, resolutions.height*.60);
Screen('DrawText', windowPtr, 'W=Incongruent', resolutions.width*.57, resolutions.height*.60);
Screen('Flip', windowPtr);
WaitSecs(2);
sca;
end

end
function imput=entrer_imput
%%entrée du clavier: 
%ListenChar(2)
%[secs, keyCode, deltaSecs] = KbWait([], 2)
%temp = KbName(keyCode)
%ListenChar(0);
start = GetSecs;
ListenChar(2);
[secs, keyCode, deltaSecs] = KbWait([], 2);
temp = KbName(keyCode); %%lettre a save
while temp ~= 'q' || 'w'
    temp = KbName(keyCode);
end
ListenChar(0);
RT = start - secs; %% temps de reaction a save
end
