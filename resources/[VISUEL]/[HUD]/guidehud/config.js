var config = {
  'title': 'AMAZING V',
  'welcomeMessage': 'REJOIGNEZ NOUS SUR LE DISCORD AMAZING V',
  // Add images for the loading screen background.
  images: [
  'https://levels.io/content/images/2015/08/GTAV-PC-4K.7.jpg', 'https://i.pinimg.com/originals/6f/3a/4f/6f3a4ffae6068867c8f4dfb099cb9c81.jpg','https://wallpaper.dog/large/17119513.jpg',
  ],
  // Turn on/off music
  enableMusic: true,
  // Music list. (Youtube video IDs). Last one should not have a comma at the end.
  music: [
    'RoYGKrkNWLg','OEnnu1y1Zl0','JobIqoMnI2w'
  ],
  // Change music volume 0-100.
  musicVolume: 05,
  // Change Discord settings and link.
  'discord': {
    'show': true,
    'discordLink': 'https://discord.gg/kVY2UJS',
  },
  // Change which key you have set in guidehud/client/client.lua
  'menuHotkey': 'F10',
  // Turn on/off rule tabs. true/false
  'rules': {
    'generalconduct': true,
    'roleplaying': true,
    'rdmvdm': true,
    'metagaming': true,
    'newlife': true,
    'abuse': true,
  },
}

// Home page annountments.
var announcements = [
  'Bienvenu sur Amazing V, lisez les règles et amusez-vous!',
]


// Add/Modify rules below.
var guidelines = [
  'Enfreindre l’une de ces règles peut entraîner des mesures administratives.',
  'Ne pas connaître les règles ne rend pas les joueurs exemptés de sanction.',
  'Si un autre joueur enfreint les règles, cela ne vous donne pas le droit d enfreindre une règle vous-même.',
  'Essayer de contourner une règle évidente peut entraîner un WARN ou un BAN',
  'Le personnel se réserve le droit de sanctionner les joueurs qui, à leur avis, sont toxiques, perturbateurs ou ne jouent pas par l esprit du mode de jeu.',
  'Toutes les règles ne peuvent pas être répertoriées, faites donc preuve de bon sens lorsque vous jouez.',
]

var generalconduct = [
  'Le racisme, le fanatisme, l antisémitisme et toute autre forme de harcèlement ne sont pas tolérés.',
  'Les joueurs ne peuvent pas simuler d agression sexuelle, de viol ou quoi que ce soit qui puisse être considéré comme un comportement intense et inapproprié.',
]

var roleplaying = [
  'Les joueurs doivent jouer un rôle dans toutes les situations.',
  '- Exemple: "J ai franchi le feu rouge à cause d un décalage du serveur" ou de situations similaires sont non autorisées.',
  '- Exception: les joueurs ne peuvent sortir du personnage que lorsqu un membre du staff vous demande d expliquer une situation et / ou vous autorise à devenir OOC.',
  'Les joueurs doivent valoriser leur vie.',
  '- Exemple: si un joueur a une arme sur la tête, il doit agir en conséquence.',
  'Les joueurs ne sont pas des super héros sans peur.',
  'Les joueurs doivent simuler correctement les blessures médicales à tout moment.',
  'Les joueurs ne peuvent pas voler de véhicules de service publique (ems,lspd).',
  'Les joueurs ne peuvent pas entrer dans un appartement pour éviter les conséquences d\'une scène en cours .',
  'Les joueurs ne peuvent pas intentionnellement respawn, se déconnecter, ni trouver un autre moyen d éviter une scène potentielle.',
]

var rdmvdm = [
  'Les joueurs ne peuvent pas tuer ou attaquer d autres joueurs sans raison valable.',
  'Les joueurs doivent avoir une raison ou un avantage pour leur personnage lorsqu\'ils tentent de tuer ou d attaquer un autre joueur.',
  '- Exemple: crier "les mains en l air ou tu meurs" sans raison n est pas une action valable.',
  'Les joueurs ne peuvent pas utiliser intentionnellement des véhicules pour entrer en collision avec d autres joueurs ou véhicules.',
]

var metagaming = [
  'Les joueurs ne peuvent pas utiliser les informations recueillies en dehors du jeu de rôle pour influencer leurs actions dans le jeu.',
  'Les joueurs peuvent retirer les dispositifs de communication d un autre joueur en jouant des rôles.',
  'Les joueurs dont les dispositifs de communication ont été retirés doivent mettre en sourdine leur logiciel de communication tiers.',
  'Les joueurs ne peuvent retirer le périphérique de communication d un autre joueur que lorsque cela est logique dans le jeu de rôle.',
  'Les connaissances et les expériences doivent être apprises et découvertes par le personnage actuel du joueur.',
  '- Exemple: Il n est pas question de trouver un point illégal juste parce qu il y a le même ailleurs',
  'Les joueurs ne peuvent pas forcer un autre joueur dans une situation dans laquelle ils ne peuvent pas jouer de rôle. Ceci est connu comme "Power-Gaming".',
  'Les joueurs doivent faire preuve de bon sens lorsqu ils rencontrent des situations potentielles de Power Gaming.',
]

var newlife = [
  'Les joueurs abattus puis stabilisés doivent continuer le jeu de rôle en conséquence.',
  'Les joueurs qui sont coma, doivent "oublier" les conditions de leur coma et peuvent petit à petit se rappeller de certains détails mais pas tout.',
  'Les joueurs qui sont mort RP ne peuvent pas continuer avec leur personnage actuel. (Les joueurs doivent faire une nouveau personnage et commencer une nouvelle histoire).',
  'La demande de mort rp doit passer par un dossier envoyé en message privé à tous les staffs (sauf si le dossier concerne l un des staff, alors l envoyer uniquement aux autres staffs).',
]

var abuse = [
  'Les joueurs ne doivent pas abuser ou exploiter des bugs.',
  'Les joueurs ne doivent  pas pirater des scripts. (en utilisant un logiciel tiers, des injecteurs, etc...)',
]

// Modify hotkeys below.
var generalhotkeys = [
  'Appuyez <kbd>F1</kbd> POUR OUVRIR SON TELEPHONE ',
  'Appuyez <kbd>F2</kbd> POUR OUVRIR SA RADIO',
  'Appuyez <kbd>F3</kbd> MENU CINEMATIQUE POUR LES SCREENSHOTS',
  'Appuyez <kbd>F5</kbd> POUR OUVRIR SON MENU PERSONNEL',
  'Appuyez <kbd>F8</kbd> POUR OUVRIR LA CONSOLE FIVEM',
  'Appuyez <kbd>F10</kbd> REGLES + TOUCHES EN JEU',
  'Appuyez <kbd>ALT</kbd> GESTION TENUE',
  'Appuyez <kbd>= ou - </kbd> INVENTAIRE',
]

var rphotkeys = [
  'Appuyez <kbd>²</kbd> POUR LEVER LES BRAS ',
  'Appuyez <kbd>B</kbd> POUR POINTER DU DOIGT ',
  'Appuyez <kbd>X</kbd> POUR ANNULER L ANNIMATION ',
  'Tapez <code>/fish</code> pour pêcher (requiert leurre et canne a pêche)',
  'Tapez <code>/th</code> pour prendre en otage',
  'Tapez <code>/me</code> pour décrire une action que vous faites',

]

var vehiclehotkeys = [
  'Appuyez <kbd>U</kbd> verrouiller / déverrouiller votre véhicule.',
  'Appuyez <kbd>H</kbd> pour régler vos phares',
  'Appuyez <kbd>E</kbd> pour klaxonner',
  'Tapez <code>/siege</code> pour passer en conducteur.',
  'Tapez <code>/passager</code> pour passer en passager.',
  'Tapez <code>/arg</code> pour passer en passager arrière gauche',
  'Tapez <code>/ard</code> pour passer en passager arrière droit',
]

var jobshotkeys = [
  'Appuyez <kbd>F9</kbd> POUR OUVRIR SON MENU GANG',
   'Appuyez <kbd>F6</kbd> POUR OUVRIR SON MENU JOB',
]