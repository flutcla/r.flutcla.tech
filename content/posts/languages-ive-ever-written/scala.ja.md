+++
draft = false
date = 2000-01-01T00:00:00+09:00
title = "Scala"
description = ""
slug = ""
authors = []
tags = ["Scala"]
categories = ["Programming"]
externalLink = ""
series = ["languages-ive-ever-written"]
+++

## Hello World
### 通常の記法
```scala
object HelloWorld {
  def main(args:Array[String]):Unit = {
    println("Hello, Scala!")
  }
}
```
```shell
> Hello, Scala!
```
- この記法はほとんどJavaと同じ。
- やたら冗長なのであまり好きではない。

### Appトレイトを用いる記法
```scala
object HelloWorld extends App {
  println("Hello, App!")
}
```
```shell
> Hello, App!
```
- 簡潔に書けるのでこちらの方が好き。

