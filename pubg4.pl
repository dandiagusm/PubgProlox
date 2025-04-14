/* Fakta */
dynamic(playerPosition/2).
dynamic(weaponPosition/3).
dynamic(playerHealth/1).
dynamic(playerAttack/2).
dynamic(playerArmor/2).
dynamic(playerAmmo/1).
dynamic(playerInventory/2).
dynamic(playerEquip/2).
dynamic(luasmap/2).
dynamic(medicinePosition/3).
dynamic(armorPosition/3).
dynamic(ammoPosition/4).
dynamic(inventory/3).
dynamic(npcEquipment/2).
dynamic(npcPosition/2).
dynamic(object/1).
weapon(akm, 50, 0).
weapon(ump, 35, 0).
weapon(clurit,20, 0).
weapon(gearsepeda, 15, 0).
weapon(pistol, 10, 0).
ammo(ammo,5).
ammo(ammo,10).
armor(vest, 50).
armor(helmet, 20).
medicine(firstaid, 70).
medicine(bandage, 10).

/* RULES pokok */
start :- write(' _____    _    _   ____     _____ '),nl,
		 write('|  __ \\  | |  | | |  _ \\   / ____|'),nl,
		 write('| |__) | | |  | | | |_) | | |  __'),nl,
		 write('|  ___/  | |  | | |  _ <  | | |_ |'),nl,
		 write('| |      | |__| | | |_) | | |__| |'),nl,
		 write('|_|       \\____/  |____/   \\_____|  Jagonya Ayam'),nl,   
		 write('                                     '),nl,
		 write('Selamat datang di Pulau Champs.'), nl, 
		 write('Bersenang-senanglah di pulau ini!. Tapi ingat only one can survive and get the title "Jagonya Ayam"'), nl, 
		 write('Jika kamu menang, Kamu juga akan mendapatkan persediaan sosis selama 1 tahun penuh. So, let\'s the battle royale begin!'), nl, nl,
		 help,
		 generateNPCEasy,
		 generateNPCMedium,	
		 random(0,10,X),
		 random(0,10,Y),
		 assertz(playerPosition(2,2)),
		 assertz(weaponPosition(akm, 1, 1)),
		 assertz(weaponPosition(clurit, 2, 3)),
		 assertz(weaponPosition(gearsepeda, 3, 3)),
		 assertz(medicinePosition(firstaid,1,3)),
		 assertz(medicinePosition(bandage,2,2)),
		 assertz(armorPosition(vest,3,2)),
		 assertz(armorPosition(helmet,3,1)),
		 assertz(ammoPosition(ammo,5,1,3)),
		 assertz(ammoPosition(ammo,10,2,1)),
		 assertz(playerHealth(100)),
		 assertz(object([])),
		 assertz(playerArmor([],0)),
		 assertz(playerAmmo(0)),
		 assertz(playerInventory([],10)),
		 assertz(playerEquip(none, 0)),
		 assertz(luasmap(10, 10)).

help :- print('      =================================================================================='),nl,
		print('     |Available commands to help you survive the game and win the title  "Jagonya Ayam"|'),nl,
		print('     |=================================================================================|'),nl,
		print('     |start.            | Start the game.                                              |'),nl,
		print('     |help.             | Get some help to look over commands available.               |'),nl,
		print('     |quit.             | Farewell, quit the game.                                     |'),nl,
		print('     |look.             | Look around you.                                             |'),nl,
		print('     |map.              | Open map and see where on Earth are you.                     |'),nl,
		print('     |N. E. S. W.       | Move to the North, East, South, or West.                     |'),nl,
		print('     |take(Object).     | Pick up an object.                                           |'),nl,
		print('     |drop(Object).     | Drop an object.                                              |'),nl,
		print('     |use(Object).      | Use an object from your inventory.                           |'),nl,
		print('     |attack.           | Attack the enemy that crosses your path.                     |'),nl,
		print('     |status.           | Show your status.                                            |'),nl,
		print('     |save(FileName).   | Save your game.                                              |'),nl,
		print('     |load(FileName).   | Load your previously saved game.                             |'),nl,
		print('     |=================================================================================|'),nl,
		print('     |                            Information in the map                               |'),nl,
		print('     |=================================================================================|'),nl,
		print('     |         W        | Weapon                                                       |'),nl,
		print('     |         A        | Armor                                                        |'),nl,
		print('     |         M        | Medicine                                                     |'),nl,
		print('     |         O        | Ammo                                                         |'),nl,
		print('     |         P        | Player                                                       |'),nl,
		print('     |         E        | Enemy                                                        |'),nl,
		print('     |         -        | Accessible                                                   |'),nl,
		print('     |         X        | Inaccessible                                                 |'),nl,
		print('      =================================================================================='),nl.

quit :- halt.

n :- playerPosition(X, Y), Z is Y-1, retract(playerPosition(X,Y)), assertz(playerPosition(X,Z)).
w :- playerPosition(X, Y), Z is X-1, retract(playerPosition(X,Y)), assertz(playerPosition(Z,Y)).
e :- playerPosition(X, Y), Z is X+1, retract(playerPosition(X,Y)), assertz(playerPosition(Z,Y)).
s :- playerPosition(X, Y), Z is Y+1, retract(playerPosition(X,Y)), assertz(playerPosition(X,Z)).

status :- playerHealth(Health), playerArmor(Armor,Jumlah), playerEquip(Equipment, _), playerInventory(Inven,Sisa),
			write('Health : '), write(Health), nl,
			write('Armor : '), cetakArmor(Armor), 
			write('Weapon : '), write(Equipment), nl, 
			cekInventory, nl.
cetakArmor([]):-nl.	
cetakArmor([H|T]):-write(H),write(' '),cetakArmor(T).
		
look :- playerPosition(X,Y),object(L),retract(object(L)),assertz(object([])),
		A is X-1, B is Y-1, cek(A,B),
		C is X, D is Y-1,cek(C,D),
		E is X+1, F is Y-1,cek(E,F),nl,
		G is X-1, H is Y,cek(G,H),
		I is X, J is Y,cek(I,J),
		K is X+1, L1 is Y,cek(K,L1),nl,
		M is X-1, N is Y+1,cek(M,N),
		O is X, P is Y+1,cek(O,P),
		Q is X+1, R is Y+1,cek(Q,R),nl,object(L2),
		keterangan(L2).

attack :- playerHealth(X), npcEquipment(_,Y), Z is X-Y, retract(playerHealth(X)), asserta(playerHealth(Z)). 

/* Predikat Tambahan */
cek(X,Y):-npcPosition(X,Y), write('E'), !.
cek(X,Y):-object(L),medicinePosition(Benda,X,Y),!,write('M'),retract(object(L)),assertz(object([Benda|L])).
cek(X,Y):-object(L),weaponPosition(Benda,X,Y),!,write('W'),retract(object(L)),assertz(object([Benda|L])).
cek(X,Y):-object(L),armorPosition(Benda,X,Y),!,write('A'),retract(object(L)),assertz(object([Benda|L])).
cek(X,Y):-object(L),ammoPosition(Benda,N,X,Y),!,write('O'),retract(object(L)),assertz(object([Benda|L])).
cek(X,Y):-write('-').
keterangan([H]):-write('You see the '),write(H),write('.').
keterangan([H|T]):-write('You see the '),write(H),write('.'),keterangan(T).


take(Object):-playerPosition(X,Y),A is X, B is Y, medicinePosition(Object,A,B),playerInventory(I,N),M is N-1,retract(medicinePosition(Object,A,B)),retract(playerInventory(I,N)),assertz(playerInventory([Object|I],M)),write('You took the '),write(Object),!.
take(Object):-playerPosition(X,Y),A is X, B is Y, weaponPosition(Object,A,B),playerInventory(I,N),M is N-1,retract(weaponPosition(Object,X,Y)),retract(playerInventory(I,N)),assertz(playerInventory([Object|I],M)),write('You took the '),write(Object),!.
take(Object):-playerPosition(X,Y),A is X, B is Y, armorPosition(Object,A,B),playerInventory(I,N),M is N-1,retract(armorPosition(Object,X,Y)),retract(playerInventory(I,N)),assertz(playerInventory([Object|I],M)),write('You took the '),write(Object),!.
take(Object):-playerPosition(X,Y),A is X, B is Y, ammoPosition(Object,J,A,B),playerAmmo(N),M is N+J,retract(playerAmmo(N)),retract(ammoPosition(Object,J,A,B)),assertz(playerAmmo(M)),write('You took the '),write(Object),!.

cekInventory:-playerInventory(L,N),write('Inventory:'),nl,cetakInventory(L).
cetakInventory([]):-nl.
cetakInventory([H]):-write(H),nl.
cetakInventory([H|T]):-write(H),nl,cetakInventory(T).

generateNPCHard :- random(1,10,X), random(1,10,Y), assertz(npcEquipment(akm,50)), assertz(npcPosition(1,1)).
generateNPCMedium :- random(1,10,X), random(1,10,Y), assertz(npcEquipment(ump,35)), assertz(npcPosition(1,2)).
generateNPCEasy :- random(1,10,X), random(1,10,Y), assertz(npcEquipment(pistol,10)), assertz(npcPosition(1,3)).

drop(Object):-weapon(Object,F,G),playerPosition(X,Y),playerInventory(L,N), M is N+1, delete(L,Object,L2),retract(playerInventory(L,N)),assertz(playerInventory(L2,M)),assertz(weaponPosition(Object,X,Y)),write('You drop the '),write(Object),!.
drop(Object):-armor(Object,F),playerPosition(X,Y),playerInventory(L,N), M is N+1, delete(L,Object,L2),retract(playerInventory(L,N)),assertz(playerInventory(L2,M)),assertz(armorPosition(Object,X,Y)),write('You drop the '),write(Object),!.
drop(Object):-medicine(Object,F),playerPosition(X,Y),playerInventory(L,N), M is N+1, delete(L,Object,L2),retract(playerInventory(L,N)),assertz(playerInventory(L2,M)),assertz(medicinePosition(Object,X,Y)),write('You drop the '),write(Object),!.
drop(Object):-ammo(Object,F),playerAmmo(J),playerPosition(X,Y),playerInventory(L,N), M is N+1, delete(L,Object,L2),retract(playerInventory(L,N)),assertz(playerInventory(L2,M)),assertz(ammoPosition(Object,J,X,Y)),write('You drop the '),write(Object),!.

use(Object):-weapon(Object,Attack,G),playerInventory(L,N),playerEquip(I,U), M is N+1, delete(L,Object,L2),retract(playerInventory(L,N)),retract(playerEquip(I,U)),assertz(playerInventory(L2,M)),assertz(playerEquip(Object,Attack)),write('You use the '),write(Object),!.
use(Object):-armor(Object,F),playerInventory(L,N),playerArmor(I,U), M is N+1, delete(L,Object,L2),retract(playerInventory(L,N)),retract(playerArmor(I,U)),assertz(playerInventory(L2,M)),JumlahArmor is U+F,assertz(playerArmor([Object|I],JumlahArmor)),write('You use the '),write(Object),!.
use(Object):-medicine(Object,F),playerInventory(L,N),playerHealth(X), M is N+1, Y is X + F, Y<100, delete(L,Object,L2),retract(playerInventory(L,N)),retract(playerHealth(X)),assertz(playerInventory(L2,M)), assertz(playerHealth(Y)),write('You use the '),write(Object),nl,write('Now your health is '),write(Y),!.
use(Object):-medicine(Object,F),playerInventory(L,N),playerHealth(X), M is N+1,  Y = 100, delete(L,Object,L2),retract(playerInventory(L,N)),retract(playerHealth(X)),assertz(playerInventory(L2,M)),assertz(playerHealth(Y)),write('You use the '),write(Object),nl,write('Now your health is '),write(Y).

