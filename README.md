# YouML
Build UML diagrams quickly

```
Owner
- string name
+ getName()
+ IAnimal[1,*] pet

IAnimal
- int legs
- string name 
- Type type
+ getName()

Dog : IAnimal
+ bark()

Cat : IAnimal
+ meow()

Type
: HELLO
: WORLD
```
![Output UML](example.png)