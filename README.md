# Sem2Algorithms

Лабораторна №1: Ідеальне хешування.

Ідеальне хешування - це хешування статичних даних (тобто після ініціалізації хеш-таблиці данних до неї додати чи виделити з неї вже не можна, тільки пошук за ключем).
Це дозволяє більш еффективно використати памьять.

В моїй реалізації використано алгоритм дворівневого хешування (тобто хеш-таблиця (PerfectHashTable) з хеш-таблиць (Bucket)) з відкритою адресацією (на другому рівні дані зберігаются у самих комірках таблиці, не в списках чи деревах). Гарно представлена у Кормені : 
![alt text](https://github.com/BBJayy/Sem2Algorithms/blob/Z%231/ReadmeImages/PerfectHashTableCormen.png)

Хеш функція виберається з універсального класса хеш-функцій: 
![alt text](CodeCogsEqn.gif)
![alt text](ReadmeImages/CodeCogsEqn.gif)
![alt text](https://github.com/BBJayy/Sem2Algorithms/blob/Z%231/ReadmeImages/PerfectHashTableCormen.png)
![alt text](https://github.com/BBJayy/Sem2Algorithms/blob/Z%231/ReadmeImages/PerfectHashTableCormen.png)

