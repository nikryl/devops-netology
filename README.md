# Домашнее задание к занятию "7.5. Основы golang"
___
## Задача 3
___

1. Напишите программу для перевода метров в футы (1 фут = 0.3048 метр):

```go
package main

import "fmt"

func main() {
  fmt.Print("Введите расстрояние в метрах: ")
  var input float64
  fmt.Scanf("%f", &input)

  output := input / 0.3048

  fmt.Println(output)
}

```

2. Напишите программу, которая найдет наименьший элемент в любом заданном списке:

```go
package main

import "fmt"

func min_element(x []int) int {
  min := x[0]
  for i := 0; i < len(x); i++ {
    if x[i] < min {
      min = x[i]
    }
  }
  return min
}

func main() {
  x := []int{48, 96, 86, 68, 57, 82, 63, 70, 37, 34, 83, 27, 19, 97, 9, -22}
  fmt.Println("Наименьший элемент равен", min_element(x))
}

```

3. Напишите программу, которая выводит числа от 1 до 100, которые делятся на 3:

```go
package main

import "fmt"

func main() {
  for i := 1; i < 101; i++ {
    if i%3 == 0 {
      fmt.Println(i)
    }
  }
}
```