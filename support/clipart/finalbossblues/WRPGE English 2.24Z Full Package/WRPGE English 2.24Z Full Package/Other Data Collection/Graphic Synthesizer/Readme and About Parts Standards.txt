――――――――――――――――――――――――――――――――――
         Graphic Synthesizer Readme
――――――――――――――――――――――――――――――――――

|What Is This Tool?|

It's a tool to create new single images by combining together image parts.
By default, it's able to assemble 8-directional graphics for WOLF RPG Editor.
The files you make with the data included with the Graphic Synthesizer
can be used for any purpose, not only for games.
(Example: Site icons, videos or Flash movies, etc.)


|If Program Won't Start Because of Gdiplus.dll|

This occurs if you do not have Gdiplus.dll installed on your computer.
Either copy the "Gdiplus.dll" file from WOLF RPG Editor to the Graphic Synthesizer folder,
or put Gdiplus.dll in the Windows System32 folder.


|About Data Settings|

By editing the Setting.txt file in each data folder,
you can set the size of the images being created, and the layer order of the parts.
For examples of settings, consult the Setting.txt in "Graphics/Default Standard."


|How to Make Parts|

If the image has the size stated in Setting.txt,
and it's a PNG with a transparent color or alpha channels,
anything can be used. Translucent images can also be put together.

――――――――――――――――――――――――――――――――――
|Supplemental "Default Standard Base"|
The "DefaultStandardBase" images (created by pochi) in the "Supplemental" folder
are unclothed graphics for the Default Standard.
When you're creating your own parts, drawing them onto this image
should make it easier to get the right positioning and size.
――――――――――――――――――――――――――――――――――
[Character Chip Parts Assistance] (From WOLF RPG Editor Resource Submission Thread)
 pochi (8-direction-ification of all images, size adjustment, refinement, and much more)
 Suu (Helped to make base 4-directional images)
 Maabe, Karekusa, mel, Ruifu Fujita, MAT, Sato,
 Yoshiyuki, Fiku, Urocchi, Wako, CEO, Hatsuya, Oha,
 Nisena, Kukurihime, and Yuno: Other basic parts
 Tatsuki: Skin parts; Rikugame: Countless other parts
――――――――――――――――――――――――――――――――――
[Face Graphic Parts Assistance] (From Face Graphic Synthesis Project Page)
 Kitakarai (Created all the base images for all types - an incredible help)
 korcs, Umino, haji, kk, Tateha, Takezou, van, Zefi, Akira,
 Amania, Yukihyou, Minmin, Keika, Maarin, Morimoru, Kei Saki
――――――――――――――――――――――――――――――――――
[Update Log] (Parts from resource submission thread will be periodically added)
06/18/2010 - Increased part count from 8 to 12, manual display setting for $ parts, added hue/saturation link function, added Half Size save function
05/14/2010 - Fixed layering of images with layer 0 behaving strangely
05/11/2010 - Full support for alpha channel images (thanks to Rikka)
           - Added hue/saturation change function (thanks to Rikka)
09/14/2009 - Added 2x/3x display function
10/29/2008 - Enlarged all images and refined parts
           - Added Randomize function
09/06/2008 - Initial release
――――――――――――――――――――――――――――――――――

Developer: SmokingWOLF [http://www.silversecond.net/](Japanese)
    Rikka
