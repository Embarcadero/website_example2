# website_example2
 FireMonkey xample to accompany demos of InterBase
 
YOU WILL NEED TO HAVE TChart installed before you open this project. The Embarcadero version works fine. *If* you get an error message when you try to compile, double-click on the chart, select "marks" and uncheck "OnTop".

Look in the modules.dm1.pas and, if necessary, change the constants to match your InterBase settings.

It doesn't do much, just looks pretty.

You need to have TChart installed (the free version is fine but it will probably work with the Pro version too).
When it launches it will check the database is present and try to connect to it.
When connected the screen will be blank. To fill it with the existing demo data hit either of the buttons labeled "1" in the screenshot below.
To make it blank the screen and recreate the test data hit either of the buttons labeled "2".

<p align="center">
<img src="https://github.com/Embarcadero/website_example2/blob/main/graphics/demo_usage.png" alt="demo" style="vertical-align:top;">  
</p>

That's all it does *right now* - none of the other buttons do anything.

The demo uses no code for the UI and no additional 3rd party controls - it's all FireMonkey and built-in components. It was designed to fit 1920 x 1080 and 2k monitors by default. The full example will obviously do the whole thing and work completely!

This is being developed into a full working demo for CodeRage in December along with several other new ones.

  Written by **Ian Barker**
            
* [https://github.com/checkdigits](https://github.com/checkdigits)
* [https://about.me/IanBarker](https://about.me/IanBarker)
* [ian.barker@embarcadero.com](mailto:ian.barker@embarcadero.com)
