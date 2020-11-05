%Squelette de travail

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
key1 = 'q'; %Touche pour Congruent
key2 = 'p'; % Touche pour incongruent
frequencies = 1; %Le nombre de stimuli total


y = [1,3,2,8];
for x = y
    disp(x)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Cette partie permet d'afficher arrays de strings de facon aléatoire
%Pour la stimulation finale, mettre le phrases dans des arrays
%Pour les images, des loops vont aider
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
%On peut probablement faire un loop ici...
ABC = {[A1]; [A2]; [A3] ; [A4]; [A5]}; %on les met dans un array
images = {I1 ; I2 ; I3; I4; I5};
[~,idx] = sort(rand(size(ABC)))% Array du texte
[~,idxIm] = sort(rand(size(images))); %Array random des images
%Boucle qui cherche à changer la valeur dans les arrays
for x = 1:size(ABC)  
    montrer=(idx(x)); 
    disp(ABC{montrer});
   figure, imshow(images{montrer}); % Permet d'apparier les images text
    %for y = 1:size(ABC{idx(x)}) %Cette boucle est un exemple de concaténation de texte à chaque mot dans les phrases
       % disp(ABC{montrer(y)}+("Hello"));
    %end
end
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