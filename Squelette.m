%Squelette de travail

% écran paramètres

screens=Screen('Screens');
screenNumber=max(screens);
[width_in_mm, height_in_mm]=Screen('DisplaySize', screenNumber);
resolutions = Screen('Resolution', screenNumber);
pixel_in_mm = width_in_mm/resolutions.width;
%feedback auditif vs visuel?

% Checks if file name already exists
file_name = sprintf('TRAVAIL_CSF_sub%d_block%d', subNum, nBlock);
if fopen([file_name,'.mat'])>0
	warning('This filename already exists.')
    reenter = input('Overwrite (y/n)? ', 's');
    if strcmp(reenter, 'n')
    	subNum = str2double(input('Enter new subject number: ', 's'));
        nBlock = str2double(input('Enter new block number: ', 's'));
    end
end

%Mettre les constantes ici/ les stimuli déja fait, s'ils ne sont pas fait
key1 = 'q'; %Touche pour Congruent %Utiliser seulement la main gauche!
key2 = 'p'; % Touche pour incongruent
frequencies = 1; %Le nombre de stimuli total


y = [1,3,2,8];
for x = y
    disp(x)
end
%waitsecs(0.5);
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Cette partie permet d'afficher arrays de strings de facon aléatoire
%Pour la stimulation finale, mettre le phrases dans des arrays
%Pour les images, des loops vont aider
A1= ["Good", "Meme"]; %Variables
A2= ["Dune" "le"];
A3= ["Figure", "Mathématique"];
A4= ["I", "Will", "Be", "Your", "Hero"];
A5=["Damier" "Exercice"];
%Mise en mémoire des images - dossier en construction (fruits / outils) -
%fruits sont en png, a voir pour outils - conversion possible
I1=imread('Test.jpg');
I2 = imread('dune2020_large.jpg');
I3 = imread('image001.jpg');
I4 = imread('Test2.jpg');
I5 = imread('damier.png');
%On peut probablement faire un loop ici...
ABC = {[A1]; [A2]; [A3] ; [A4]; [A5]}; %on les met dans un array
images = {I1 ; I2 ; I3; I4; I5};
[~,idx] = sort(rand(size(ABC)))% Array du texte
[~,idxIm] = sort(rand(size(images))); %Array random des images
%Boucle qui cherche à changer la valeur dans les arrays
for x = 1:size(ABC)  
    montrer=(idx(x)); 
    disp(ABC{montrer});
    disp(size(ABC));
  % figure, imshow(images{montrer}); % Permet d'apparier les images text
   %WaitSecs(.05);
    for y = 1:size(ABC{idx(x)}) %Cette boucle est un exemple de concaténation de texte à chaque mot dans les phrases
        disp(ABC{montrer(y)}+("Hello"));
    end
end
%%
%Ceci est la boucle pour les images randomisées
%for Z = 1:size(images)  
   % montrerIm=(idxIm(Z)); 
   % figure, imshow(images{montrerIm});%Montre l'image à la valeur de l'array choisie
%end
%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Ceci est utile pour générer un rng
randi([1 30])

%Ces fonctions d'enregistrement d'image seront importantes.
im = imread('Test.jpg');
imshow(im)
figure, imshow(grand_damier2);
%pour clear le screen de ptb
%ctrl-0.

%randperm(64, 1) 

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

A1= ["Good", "Meme"]; %Variables
A2= ["Dune" "le"];
A3= ["Figure", "Mathématique"];
A4= ["I", "Will", "Be", "Your", "Hero"];
A5=["Damier" "Exercice"];
I1=imread('Test.jpg');
I2 = imread('dune2020_large.jpg');
I3 = imread('image001.jpg');
I4 = imread('Test2.jpg');
I5 = imread('damier.png');
%C'est tres contre intuitif, mais ca fonctionne
ABC = {[A1]; [A2]; [A3] ; [A4]; [A5]}; %on les met dans un array
[~,idx] = sort(rand(size(ABC))) %Permet de faire une série de valeurs randomisés
images = {I1 ; I2 ; I3; I4; I5};%Les images sont dans les arrays
[windowPtr,rect]=Screen('OpenWindow',screenNumber, [128 128 128]); %Le screen avec un fond de gris
resolutions = Screen('Resolution', screenNumber);
for z=1:size(ABC) %Ici le size fonctionne, donc de 1 à 5...
    Screen('DrawLine', windowPtr, [0 0 0], resolutions.width/2, resolutions.height*0.45, resolutions.width/2, resolutions.height*0.55, 5);
Screen('DrawLine', windowPtr, [0 0 0], resolutions.width*0.50+((resolutions.height*0.55-resolutions.height*0.45)/2), resolutions.height/2, resolutions.width*0.50-((resolutions.height*0.55-resolutions.height*0.45)/2), resolutions.height/2, 5);
Screen('Flip', windowPtr);
WaitSecs(0.5);
%remplacer la croix de fixation par une fonction
    montrer=idx(z); %montrer est ma valeur randomisée
    ending=max(size(ABC{montrer})); % Size ne fonctionne pas apres, so on trouve une fin à la phrase
      texturePtr(1)= Screen('MakeTexture', windowPtr, images{montrer}); %On crée une variable texture à chaque fois... c'est de la folie
   Screen('DrawTexture', windowPtr,texturePtr(1) );
    Screen('Flip', windowPtr)
    WaitSecs(1);
    for x=1:ending
        
  Screen('DrawText', windowPtr,num2str(ABC{montrer}(x)), (resolutions.width/2)-((max(size(num2str(ABC{montrer}(x))))*0.75)*(resolutions.width/250)), resolutions.height*0.48); 
  %Cette catastrophe tente de centrer les mots
  Screen('Flip', windowPtr);
  WaitSecs(0.3);
  Screen('Flip', windowPtr);
  WaitSecs(0.2);
    end
 Screen('Flip', windowPtr);
WaitSecs(0.5); %Ici il faut attendre l'imput du participant
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
