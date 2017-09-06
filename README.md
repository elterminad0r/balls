# balls
Simple, slightly buggy implementation of balls that can bounce off both each other and walls. It ends up looking pretty dynamic. It uses an equation for circle collision from wikipedia. The problem is that sometimes a ball will clip into another ball and start a weird orbit/mating dance. Especially happens when there's disparity between ball radii. It looks like this:

![screenshot](https://github.com/elterminad0r/balls/blob/master/screenshot.png)
