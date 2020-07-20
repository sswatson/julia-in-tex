# julia-in-tex

This repo explains my setup for producing PDF documents which include Julia code. There are a lot of specific choices described here, but you can mix-and-match according to your preferences.

## Instructions

1. Install TeX. I use [TinyTeX](https://yihui.org/tinytex/), but large installations like [MacTeX](https://tug.org/mactex/) and [MikTeX](https://miktex.org/howto/install-miktex) are easier.
1. (Optional) Install my [LaTeX class  and sty files](https://github.com/sswatson/latex-setup/) (to get the styling you see in the document in this repo).
2. (Optional) Install the Atom editor with nteract's Hydrogen package and the `atom-latex` package (maintained by *ashthespy*). Go into the settings set a mapping for the Julia kernel (Atom > Preferences > Packages > Hydrogen > Settings > paste `{ "julia": "latex" }` into the *Language Mapping* section). 
3. Clone this repo and open it in Atom. Compile `data1010.tex` for an example. 

## Things you can do 

1. Select some Julia code and in your editor do shift-enter to run the code directly in your TeX document.
2. Get syntax-highlighted code in your PDF output, thanks to the Pygments package. Inline Julia code uses `\jlverb{}`, while code blocks are obtained using the `juliablock` environment (`\begin{juliablock}...\end{juliablock}`). 
3. Incorporate Julia output into your document using `\jl{}` for inline stuff. If you want a block of Julia code to run for purposes of producing said output, use the environment `juliablockc` instead of `juliablock`. If you want code to run but not display, use the `juliahidden` environment. You'll need to run [pythontex](https://github.com/gpoore/pythontex) for this feature; this entails running (for example) `pythontex3 data1010.pytxcode` between TeX runs whenever you update code. Alternatively, you can try the `lua` option of the package `juliatex.sty`, which uses Julia's and Lua's foreign function interfaces to call Julia from Lua during the LuaTeX run. This might require some configuration, because you'll need to point Lua to your Julia installation in `juliatex.sty`. 
4. If you want to produce a standalone `.jl` or `.jmd` file to run from the command line with `julia` or [Weave](https://github.com/JunoLab/Weave.jl), you can run the script `makejmd.jl`. This script uses files which are written during the TeX run, so you do have to compile first.