Dans ce dernier travail pratique et projet, nous allons “coder une voix”. Non pas n’importe laquelle mais celle de la RATP: le fameux “Des pickpockets peuvent être présents en station ou à bord des trains…” .Ce codage qui correspond en réalité à plusieurs modifications de la voix sera réalisé en trois étapes indépendantes:

La modification de la vitesse
Nous modifierons la vitesse de la voix, et pour que cette voix ne semble pas plus aiguë en accéléré ou plus grave en ralenti, nous tâcherons de garder la fréquence intacte.

La modification du pitch
C’est ici que nous rendrons la voix masculine de la société de transports parisiens plus grave, plus aiguë. Nous l’enverrons dans les altos, sopranos… pour essayer d’en faire un “featuring” avec cette même voix.
 
La robotisation de la voix
Comme son nom l’indique, nous allons rendre cette voix un peu robotisée comme utilisé dans le monde du cinéma pour donner cette voix aux personnages robotiques.

Modification du pitch, Modification de la vitesse : « PVOC.M »
	Dans cette première partie nous allons agir sur la vitesse de prononciation des mots et ensuite sur le pitch, la fréquence fondamentale de cette voix

Modification de la vitesse 
	Dans un premier temps, intéressons-nous à la vitesse d'énonciation. Nous allons modifier cette vitesse: l'accélérer au trois demies de sa vitesse de base “Son x1.5”et ensuite la ralentir de moitié  “Son x0.5”. 
Essayons de voir ce que cela donne graphiquement:






Au niveau du signal temporel, on remarque bien sûr que sur l’audio accéléré, le temps diminue de 8 pour atteindre 5 secondes et augmente pour aller à 12 secondes après le ralentissement.
Les pics de fréquence sur le spectre diminuent légèrement eux aussi sur les audio aux durées modifiées et exceptés ces petits détails, nous ne remarquons pas de grands changements sur le spectrogramme.
 
Modification du pitch
	On va passer à la modification de la tonalité de la voix à l’aide de la deuxième partie de la fonction PVOC.m.  La rendre plus grave et plus aiguë et celà, sans modifier la vitesse de la diction.
Essayons de voir ce que cela donne graphiquement:



	En comparant les graphes temporels, spectraux et les spectrogrammes, on remarque comme on s’y attendait que déjà, au niveaux des spectres, on a d’une part une concentration des raies de basses fréquences quant à la voix plus grave et celle plus aiguë, des raies moins concentrées à ce même niveau fréquentiel.
Par ailleurs, on observe une plus grande traînée de “bleu” sur le spectrogramme de “Diminution” et de “jaune” sur l’autre, ce qui nous confirme respectivement une voix plus grave et une autre bien plus aiguë.


Robotisation de la voix :<<ROB.m>>
	La fonction ROB.m nous permettra de donner un timbre robotique à la voix de la RATP. Pour cela on multiplie le signal audio d’entrée par une fonction exponentielle comprenant un paramètre Fc qui précisera le dégré de robotisation de la voix :                exp(– j2πFc.t).

Pour cette voix précisément, en recherchant les degrés parfaits, c’est-à-dire la valeur de Fc qui nous donneront une voix parfaitement robotique, on trouve que Fc=2000Hz. Autrement la voix est soit trop robotique, soit ne l’est pas du tout et on entend presque rien. Ainsi on trouve:



Ce qui est frappant ici, c’est que les spectrogrammes des deux audios sont presque semblables, comme si la voix robotisée était pareille que la voix normale.

Le “Parler en Coeur”
	Dans cette partie, nous décidons de nous amuser en “effrayant” les passagers d’un train. Pour cela on fait parler les trois tonalités de voix: La voix normale, l’aiguë et la grave en même temps.
On utilise alors les voix préalablement modifiées, ensuite on rogne les trois signaux au nombre d’échantillons minimal des trois afin de pouvoir les additionner et les faire écouter.
Cette partie est écrite dans le scripte à la toute fin du “vocodeur.m”

