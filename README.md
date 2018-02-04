# Sem2Algorithms

Лабораторна №1: Ідеальне хешування.

Ідеальне хешування - це хешування статичних даних (тобто після ініціалізації хеш-таблиці данних до неї додати чи виделити з неї вже не можна, тільки пошук за ключем).
Це дозволяє більш еффективно використати памьять.

В моїй реалізації використано алгоритм дворівневого хешування (тобто хеш-таблиця (PerfectHashTable) з хеш-таблиць (Bucket)) з відкритою адресацією (на другому рівні дані зберігаются у самих комірках таблиці, не в списках чи деревах). Гарно представлена у Кормені : 
![alt text] (PerfectHashTableCormen.jpg)

Хеш функція виберається з універсального класса хеш-функцій: 
$H_{pm} = \{h_{ab} : a \in Z^*_p, b \in Z^*_p\} $
$ h_{ab}(k) = ((ak+n) mod p) mod m $
