%%
%% This is file `csposter.cls'
%%
% Based on baposter.cls by 
% - Brian Amberg, 2007, 2008, 2009, 2010, 2011, http://www.brian-amberg.de/uni/poster/
% - Reinhold Kainhofer, 2011, http://reinhold.kainhofer.com/
%% Licence: GPL

\def\csposter@version{1.0}
\def\csposter@date{2019/04/29}
\def\csposter@msg{csposter: Corò Federico (based on baposter.cls by B. Amberg and R. Kainhofer 2011)}
\typeout{Package: \csposter@date. v.\csposter@version. \csposter@msg}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{csposter}[\csposter@date. v.\csposter@version. \csposter@msg]

\LoadClass{article}

%% Define lengths only once on inclusion, such that we can make multiple posters
\newlength{\csposter@basepaperwidth}
\newlength{\csposter@basepaperheight}
\newlength{\csposter@basemargin}
\newlength{\csposter@finalpaperwidth}
\newlength{\csposter@finalpaperheight}
\newlength{\csposter@finalmargin}
\newlength{\headerheight}%
\newlength{\colwidth}%
\newlength{\colheight}%
\newlength{\csposter@@colspacing}%
\newlength{\csposter@box@@cornerradius}%
\newlength{\csposter@box@@boxheaderheight}%
\newlength{\csposter@box@@boxpadding}%
\newlength{\boxstartx}%
\newlength{\boxstarty}%
\newlength{\boxwidth}%
\newlength{\boxheight}%
\newlength{\csposter@titleimage@left@width}%
\newlength{\csposter@titleimage@right@width}%
\newlength{\csposter@titleimage@textwidth}%
\newbox\csposter@box@content%
\newbox\csposter@titleimage@left%
\newbox\csposter@titleimage@title%
\newbox\csposter@titleimage@right%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Packages
%--------------------------------------------------------------
% The only ``weird'' dependency of this package is pgf. All the rest should be installed on any decent system.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\typeout{Use Packages}
\RequirePackage{xkeyval}
\RequirePackage{calc}
\RequirePackage{tikz}
% \RequirePackage{pgf}
\RequirePackage{ifthen}
\usetikzlibrary{decorations}
\usetikzlibrary{fadings}
\usetikzlibrary{calc}
\RequirePackage{enumitem}
\setlist{leftmargin=4mm}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Settings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Choose a smaller value for larger fonts
\newcommand{\csposter@fontscale}{0.31}

%% QR code
\newcommand{\qrcode}[3]{
  \begin{minipage}[c]{0.30\textwidth}
    \includegraphics[width=\textwidth]{#1}
  \end{minipage}
  \begin{minipage}[c]{0.12\textwidth}
    \hfill\includegraphics[height=0.85\textwidth]{#2}
  \end{minipage}
  \begin{minipage}[c]{0.50\textwidth}
    #3
  \end{minipage}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Zoom
%--------------------------------------------------------------
% We scale the page from fontscale * papersize up to papersize
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Paper sizes
\newif\if@landscape
\newif\if@geometryKnowsThisSize
\DeclareOptionX{landscape}{\@landscapetrue}
\DeclareOptionX{portrait}{}

\newcommand{\csposter@setfinalpapersize}[2]{
  \if@geometryKnowsThisSize
    \setlength{\csposter@finalpaperwidth}{#1}%
    \setlength{\csposter@finalpaperheight}{#2}%
  \else
    \if@landscape
      % Transpose length, if geometry does not handle the papersize based on the key
      \setlength{\csposter@finalpaperwidth}{#2}%
      \setlength{\csposter@finalpaperheight}{#1}%
      \else
      \setlength{\csposter@finalpaperwidth}{#1}%
      \setlength{\csposter@finalpaperheight}{#2}%
    \fi
  \fi
}

% Default paperwidth and paperheight = a0paper
\DeclareOptionX{paperwidth}[841mm]{
  \setlength{\csposter@finalpaperwidth}{#1}
}
\DeclareOptionX{paperheight}[1189mm]{
  \setlength{\csposter@finalpaperheight}{#1}
}
\DeclareOptionX{archA}{
  \csposter@setfinalpapersize{9in}{12in}
}
\DeclareOptionX{archB}{
  \csposter@setfinalpapersize{12in}{18in}
}
\DeclareOptionX{archC}{
  \csposter@setfinalpapersize{18in}{24in}
}
\DeclareOptionX{archD}{
  \csposter@setfinalpapersize{24in}{36in}
}
\DeclareOptionX{archE}{
  \csposter@setfinalpapersize{36in}{48in}
}
\DeclareOptionX{archE1}{
  \csposter@setfinalpapersize{30in}{42in}
}
\DeclareOptionX{archE2}{
  \csposter@setfinalpapersize{26in}{38in}
}
\DeclareOptionX{archE3}{
  \csposter@setfinalpapersize{27in}{39in}
}
\DeclareOptionX{a0paper}{
  \@geometryKnowsThisSizetrue\csposter@setfinalpapersize{841mm}{1189mm}
}
\DeclareOptionX{a1paper}{
  \@geometryKnowsThisSizetrue\csposter@setfinalpapersize{594mm}{841mm}
}
\DeclareOptionX{a2paper}{
  \@geometryKnowsThisSizetrue\csposter@setfinalpapersize{420mm}{594mm}
}
\DeclareOptionX{a3paper}{
  \@geometryKnowsThisSizetrue\csposter@setfinalpapersize{297mm}{420mm}
}
\DeclareOptionX{a4paper}{
  \@geometryKnowsThisSizetrue\csposter@setfinalpapersize{210mm}{297mm}
}
\DeclareOptionX{a5paper}{
  \@geometryKnowsThisSizetrue\csposter@setfinalpapersize{148mm}{210mm}
}
\DeclareOptionX{a6paper}{
  \@geometryKnowsThisSizetrue\csposter@setfinalpapersize{105mm}{148mm}
}
\DeclareOptionX{b0paper}{
  \@geometryKnowsThisSizetrue\csposter@setfinalpapersize{1000mm}{1414mm}
}
\DeclareOptionX{b1paper}{
  \@geometryKnowsThisSizetrue\csposter@setfinalpapersize{707mm}{1000mm}
}
\DeclareOptionX{b2paper}{
  \@geometryKnowsThisSizetrue\csposter@setfinalpapersize{500mm}{707mm}
}
\DeclareOptionX{b3paper}{
  \@geometryKnowsThisSizetrue\csposter@setfinalpapersize{353mm}{500mm}
}
\DeclareOptionX{b4paper}{
  \@geometryKnowsThisSizetrue\csposter@setfinalpapersize{250mm}{353mm}
}
\DeclareOptionX{b5paper}{
  \@geometryKnowsThisSizetrue\csposter@setfinalpapersize{176mm}{250mm}
}
\DeclareOptionX{b6paper}{
  \@geometryKnowsThisSizetrue\csposter@setfinalpapersize{125mm}{176mm}
}
\DeclareOptionX{ansiapaper}{
  \@geometryKnowsThisSizetrue\csposter@setfinalpapersize{8.5in}{11in}
}
\DeclareOptionX{ansibpaper}{
  \@geometryKnowsThisSizetrue\csposter@setfinalpapersize{11in}{17in}
}
\DeclareOptionX{ansicpaper}{
  \@geometryKnowsThisSizetrue\csposter@setfinalpapersize{17in}{22in}
}
\DeclareOptionX{ansidpaper}{
  \@geometryKnowsThisSizetrue\csposter@setfinalpapersize{22in}{34in}
}
\DeclareOptionX{ansiepaper}{
  \@geometryKnowsThisSizetrue\csposter@setfinalpapersize{34in}{44in}
}
\DeclareOptionX{letterpaper}{
  \@geometryKnowsThisSizetrue\csposter@setfinalpapersize{8.5in}{11in}
}
\DeclareOptionX{legalpaper}{
  \@geometryKnowsThisSizetrue\csposter@setfinalpapersize{8.5in}{14in}
}
\DeclareOptionX{executivepaper}{
  \@geometryKnowsThisSizetrue\csposter@setfinalpapersize{7.25in}{10.5in}
}
\DeclareOptionX{screen}{
  \@geometryKnowsThisSizetrue\csposter@setfinalpapersize{225mm}{180mm}
}

% Margin
\setlength{\csposter@finalmargin}{1.5cm}
\DeclareOptionX{fontscale}[0.292]{
  \renewcommand{\csposter@fontscale}{#1}
}
\DeclareOptionX{margin}[1.5cm]{
  \setlength{\csposter@finalmargin}{#1}
}

% move text/poster body to the right (or to the left if negative)
\newlength{\csposter@movebody}
\setlength{\csposter@movebody}{0cm}
\DeclareOptionX{movebody}[0cm]{
  \setlength{\csposter@movebody}{#1}
}


\newif\if@debug
\DeclareOptionX{debug}{\@debugtrue}
%% Will be passed on to other packages (xcolor and geometry), still we don't want unused warnings
\DeclareOptionX{table}{}
\DeclareOptionX{showframe}{}

\ProcessOptionsX

\if@debug
  \newcommand{\debug}[1]{\typeout{#1}}
\else
  \newcommand{\debug}[1]{}
\fi



\setlength{\csposter@basepaperwidth}{
    \csposter@fontscale\csposter@finalpaperwidth
}
\setlength{\csposter@basepaperheight}{
    \csposter@fontscale\csposter@finalpaperheight
}
\setlength{\csposter@basemargin}{
    \csposter@fontscale\csposter@finalmargin
}
\newlength{\csposter@basemarginright}
\setlength{\csposter@basemarginright}{
    \csposter@basemargin
}
\addtolength{\csposter@basemarginright}{
    -\csposter@fontscale\csposter@movebody
}
\newlength{\csposter@basemarginleft}
\setlength{\csposter@basemarginleft}{
    \csposter@basemargin
}
\addtolength{\csposter@basemarginleft}{
    \csposter@fontscale\csposter@movebody
}

\typeout{Paperwidth=\the\csposter@finalpaperwidth}
\typeout{Paperheight=\the\csposter@finalpaperheight}
\typeout{BasePaperwidth=\the\csposter@basepaperwidth}
\typeout{BasePaperheight=\the\csposter@basepaperheight}
\usepackage[
    paperwidth=\csposter@basepaperwidth,
    paperheight=\csposter@basepaperheight,
    tmargin=\csposter@basemargin,
    bmargin=\csposter@basemargin,
    lmargin=\csposter@basemarginleft,
    rmargin=\csposter@basemarginright,
]{geometry} 

\usepackage{pgfpages}
\if@landscape
    \if@geometryKnowsThisSize
        \pgfpagesuselayout{resize to}[physical paper width=\csposter@finalpaperheight,physical paper height=\csposter@finalpaperwidth]
    \else
        \pgfpagesuselayout{resize to}[physical paper width=\csposter@finalpaperwidth,physical paper height=\csposter@finalpaperheight]
    \fi
\else
    \pgfpagesuselayout{resize to}[physical paper width=\csposter@finalpaperwidth,physical paper height=\csposter@finalpaperheight]
\fi



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Default functions for borders/backgrounds
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% These functions will all be redefined from the actual option values. In
%% particular, they will be set to \csposter@optionname@optionvalue, which
%% should do the actual work / setting for that particular optionvalue.

\newcommand{\csposterPosterDrawBackground}[2]{} % Draw poster background
\newcommand{\csposterBoxGetShape}{}             % Returns path of text box shape
\newcommand{\csposterBoxDrawBackground}[2]{}    % Draw bg of boxes
\newcommand{\csposterBoxDrawBorder}[1]{}        % Draw border of individual boxes

\newcommand{\csposterHeaderGetShape}{}          % Returns path of text box shape
\newcommand{\csposterHeaderSetShade}[3]{}       % Set bg style for box headers
\newcommand{\csposterHeaderDrawBackground}[3]{} % Draw background of box header
\newcommand{\csposterHeaderDrawBorder}[1]{}     % Draw border of box header
\newcommand{\csposterHeaderDrawText}[1]{}       % Draw text inside box header

\newcommand{\@@previousbox}{notset}             % stores the previously processed box for below=auto

% Function to set a user-defined background
\newcommand{\csposter@backgroundCmd}{\error{No background command defined. Use \background{...} to define background}}
\newcommand{\background}[1]{\renewcommand{\csposter@backgroundCmd}{#1}}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Handle poster and box options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\debug{Handling keys}

%%
%% POSTER OPTIONS
%%
%% Store all poster options in variables of the form \csposter@option
%% choose-keys also store the index in \csposter@optionnr
%% choose-keys typically also assign a function
\definecolor{csposter@silver}{cmyk}{0,0,0,0.7}
\define@boolkey[cs]{poster}[csposter@]{grid}                 [false]       {}
\define@boolkey[cs]{poster}[csposter@]{eyecatcher}           [true]        {}
\define@cmdkey [cs]{poster}[csposter@]{headerheight}         [0.1\textheight]{}
\define@cmdkey [cs]{poster}[csposter@]{columns}              [{}]          {}
\define@cmdkey [cs]{poster}[csposter@]{colspacing}           [1em]         {}
\define@cmdkey [cs]{poster}[csposter@]{bgColorOne}           [csposter@silver]{}
\define@cmdkey [cs]{poster}[csposter@]{bgColorTwo}           [green]       {}

% background can be one of: shadeLR, shadeTB, plain, user, none
\define@choicekey*+[cs]{poster}{background}%
[\csposter@background\csposter@backgroundnr]%
{shadeLR, shadeTB, plain, user, none} [plain] {%
\debug{Poster background: \csposter@background}
\renewcommand{\csposterPosterDrawBackground}[2]{
\csname csposter@background@\csposter@background\endcsname{##1}{##2}}
}{
\PackageWarning{csposter}{Unknown background `\csposter@background' (use
shadeLR, shadeTB, plain, none, or user). If user is used, you also
have to define \background{...}.}
\renewcommand{\csposterPosterDrawBackground}[2]{\csposter@background@none{##1}{##2}}
}

%%
%%  BOX OPTIONS
%%
\define@cmdkey[cs]{posterbox}[csposter@box@]{cornerradius}[1em]{}
\define@cmdkey[cs]{posterbox}[csposter@box@]{boxheaderheight}[2em]{}
\define@cmdkey[cs]{posterbox}[csposter@box@]{boxpadding}[0.5em]{}


% textborder can be one of: none, bars, coils, triangles, rectangle, rounded,
% roundedleft, roundedsmall, faded; UNIMPLEMENTED: roundedright
\edef\csposter@box@textborder@validvalues{none,bars,coils,triangles,rectangle,rounded,roundedleft,roundedsmall,faded}
\define@choicekey*+[cs]{posterbox}{textborder}%
[\csposter@box@textborder\csposter@box@textbordernr]%
{none,bars,coils,triangles,rectangle,rounded,roundedleft,roundedright,roundedsmall,faded} [rectangle] {%
\debug{Text border: \csposter@box@textborder}
\renewcommand{\csposterBoxGetShape}{
\csname csposter@box@boxshape@\csposter@box@textborder\endcsname}
\renewcommand{\csposterBoxDrawBorder}[1]{
\csname csposter@box@drawborder@\csposter@box@textborder\endcsname{##1}}
}{
\PackageWarning{csposter}{Unknown text-border style `\csposter@box@textborder'.
Edit your file to choose a valid option (\csposter@box@textborder@validvalues).}
\renewcommand{\csposterBoxGetShape}{\csposter@boxshape@rectangle}
\renewcommand{\csposterBoxDrawBorder}[1]{\csposter@drawborder@rectangle{##1}}
}

% boxshade can be one of: shadeLR, shadeTB, plain, none
\define@choicekey*+[cs]{posterbox}{boxshade}%
[\csposter@box@boxshade\csposter@box@boxshadenr]%
{shadelr,shadetb,plain,none} [none] {%
\debug{Box shade: \csposter@box@boxshade}
\renewcommand{\csposterBoxDrawBackground}[2]{
\csname csposter@box@drawbackground@\csposter@box@boxshade\endcsname{##1}{##2}}
}{
\PackageWarning{csposter}{Unknown boxshade style `\csposter@boxshade'.
Edit your file to choose a valid option.}
\renewcommand{\csposterBoxDrawBackground}[2]{\csposter@box@drawbackground@none{##1}{##2}}
}

% headershade can be one of: shade-lr, shade-tb, shade-tb-inverse, plain
\define@choicekey*+[cs]{posterbox}{headershade}%
[\csposter@box@headershade\csposter@box@headershadenr]%
{shadelr,shadetb,shadetbinverse,plain} [shadelr] {%
\debug{Header shade: \csposter@box@headershade}
\renewcommand{\csposterHeaderSetShade}[3]{
\csname csposter@box@headershade@\csposter@box@headershade\endcsname{##1}{##2}{##3}}
}{
\PackageWarning{csposter}{Unknown headershade style `\csposter@box@headershade'.
Edit your file to choose a valid option.}
\renewcommand{\csposterHeaderSetShade}[3]{\csposter@box@headershade@none{##1}{##2}{##3}}
}

% headershape can be one of: rectangle, rounded, smallrounded, roundedleft, roundedright
\define@choicekey*+[cs]{posterbox}{headershape}%
[\csposter@box@headershape\csposter@box@headershapenr]%
{rectangle,rounded,smallrounded,roundedleft,roundedright} [roundedright] {%
\debug{Header shape: \csposter@box@headershape}
\renewcommand{\csposterHeaderGetShape}{
\csname csposter@box@headershape@\csposter@box@headershape\endcsname}
\renewcommand{\csposterHeaderDrawText}[1]{
\csname csposter@box@headerdrawtext@\csposter@box@headershape\endcsname{##1}}
\renewcommand{\csposterHeaderDrawBorder}[1]{
\csname csposter@box@headerdrawborder@\csposter@box@headershape\endcsname{##1}}
}{
\PackageWarning{csposter}{Unknown headershape style `\csposter@headershape'.
Edit your file to choose a valid option.}
\renewcommand{\csposterHeaderGetShape}{\csposter@box@headershape@rectangle}
\renewcommand{\csposterHeaderDrawText}[1]{\csposter@box@headerdrawtext@rectangle{##1}}
\renewcommand{\csposterHeaderDrawBorder}[1]{\csposter@box@headerdrawborder@rectangle{##1}}
}

% headerborder can be one of: open, closed, none
\define@choicekey*+[cs]{posterbox}{headerborder}%
[\csposter@box@headerborder\csposter@box@headerbordernr]%
{open,closed,none} [open] {%
\debug{Header border: \csposter@box@headerborder}
%   \renewcommand{\csposterHeaderBorder}{
%       \csname csposter@headerborder@\csposter@box@headerborder\endcsname}
}{
\PackageWarning{csposter}{Unknown headerborder style `\csposter@headerborder'.
Edit your file to choose a valid option.}
%   \renewcommand{\csposterHeaderBorder}{\csposter@box@headerborder@rectangle}
}


\define@cmdkey[cs]{posterbox}[csposter@box@]{borderColor}           [yellow]      {}
\define@cmdkey[cs]{posterbox}[csposter@box@]{headerColorOne}        [white]         {}
\define@cmdkey[cs]{posterbox}[csposter@box@]{headerColorTwo}        [white]       {}
\define@cmdkey[cs]{posterbox}[csposter@box@]{headerFontColor}       [black]       {}
\define@cmdkey[cs]{posterbox}[csposter@box@]{boxColorOne}           [white]     {}
\define@cmdkey[cs]{posterbox}[csposter@box@]{boxColorTwo}           [white]        {}
\define@cmdkey[cs]{posterbox}[csposter@box@]{headerfont}            [\scshape\Large]   {}
\define@cmdkey[cs]{posterbox}[csposter@box@]{textfont}              [{}]          {}

\define@cmdkey[cs]{posterbox}[csposter@box@]{linewidth}             [2pt]         {}

\define@cmdkey[cs]{posterbox}[csposter@box@]{below}  [notset]{}
\define@cmdkey[cs]{posterbox}[csposter@box@]{above}  [notset]{}
\define@cmdkey[cs]{posterbox}[csposter@box@]{aligned}[notset]{}
\define@cmdkey[cs]{posterbox}[csposter@box@]{bottomaligned}[notset]{}
\define@cmdkey[cs]{posterbox}[csposter@box@]{column} [0]     {}
\define@cmdkey[cs]{posterbox}[csposter@box@]{row}    [0]     {}
\define@cmdkey[cs]{posterbox}[csposter@box@]{span}   [1]     {}
\define@cmdkey[cs]{posterbox}[csposter@box@]{height} [auto]  {}
\define@cmdkey[cs]{posterbox}[csposter@box@]{name}   [noname]{}

% Set some default values, the poster and posterbox environments can override:
\setkeys[cs]{poster}{
    % Debug grid
    grid=false,
    % Is there an eyecatcher image
    eyecatcher=true,
    columns={},
    % Colours
    bgColorOne=white,
    bgColorTwo=white,
    %
    colspacing=1em,
    headerheight=0.1\textheight,
    background=plain,
}{}

\setkeys[cs]{posterbox}{
    % Position
    column=0,row=0,span=1,
    below=notset,above=notset,
    bottomaligned=notset,
    aligned=notset,
    height=auto,
    % Name
    name=noname,
    % Box design: border:
    linewidth=2pt,
    borderColor=black,
    cornerradius=1em,
    % text box:
    textfont={},
    boxshade=plain,
    boxColorOne=white,
    boxColorTwo=white,
    textborder=faded,
    boxpadding=0.5em,
    % header
    headerfont=\scshape\Large,% or headerfont=\color{white}\textsf\textbf
    headerFontColor=black,
    headerColorOne=white,
    headerColorTwo=white,
    headershape=rectangle,
    headershade=shadeLR,
    headerborder=none,
    boxheaderheight=2em,
}{}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Background options and functions (one function for each possible value)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\csposter@background@shadelr}[2]{
\debug{csposter: Using shade left right background.}
\begin{tikzpicture}[remember picture,overlay]%
\shade [shading=axis,left color=#1,right color=#2] (current page.north west)
rectangle(current page.south east);
\end{tikzpicture}%
}
\newcommand{\csposter@background@shadetb}[2]{
\debug{csposter: Using shade top to bottom background.}
\begin{tikzpicture}[remember picture,overlay]%
\shade [shading=axis,top color=#1,bottom color=#2] (current page.north west)
rectangle(current page.south east);
\end{tikzpicture}%
}
\newcommand{\csposter@background@plain}[2]{
\debug{csposter: Using plain background.}
\begin{tikzpicture}[remember picture,overlay]%
\fill [fill=#1] (current page.north west) rectangle(current page.south east);
\end{tikzpicture}%
}
\newcommand{\csposter@background@user}[2]{
\debug{csposter: Using user background.}
\csposter@backgroundCmd%
}
\newcommand{\csposter@background@none}[2]{
\debug{csposter: Using no background.}
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Return shape path of text box (depending on the box shape)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\csposter@box@boxshape@none}{\csposter@box@boxshape@rectangle}
\newcommand{\csposter@box@boxshape@bars}{
(\csposter@box@name tnw) -- (\csposter@box@name sw) %
(\csposter@box@name se) -- (\csposter@box@name tne)
}
\newcommand{\csposter@box@boxshape@coils}{\csposter@box@boxshape@bars}
\newcommand{\csposter@box@boxshape@triangles}{\csposter@box@boxshape@bars}
\newcommand{\csposter@box@boxshape@rectangle}{
(\csposter@box@name tnw) -- (\csposter@box@name sw) -- %
(\csposter@box@name se) -- (\csposter@box@name tne)%
}
\newcommand{\csposter@box@boxshape@faded}{
(\csposter@box@name tnw) -- (\csposter@box@name sw) %
(\csposter@box@name tne) -- (\csposter@box@name se)
}
\newcommand{\csposter@box@boxshape@rounded}{
[rc] \csposter@box@boxshape@rectangle%
}
\newcommand{\csposter@box@boxshape@roundedsmall}{
[src] \csposter@box@boxshape@rectangle
}
\newcommand{\csposter@box@boxshape@roundedleft}{
(\csposter@box@name tnw) {[rc]-- (\csposter@box@name sw)} -- %
(\csposter@box@name se) -- (\csposter@box@name tne)%
}
\newcommand{\csposter@box@boxshape@roundedright}{
(\csposter@box@name tnw) -- (\csposter@box@name sw) {[rc]-- %
(\csposter@box@name se)} -- (\csposter@box@name tne)%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Draw box background (one function for each possible value)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% These functions take no arguments
\newcommand{\csposter@box@drawbackground@none}[2]{
\tikzstyle{box colors}=[]
}
\newcommand{\csposter@box@drawbackground@plain}[2]{
\tikzstyle{box colors}=[fill=#1]
\fill[box colors] \csposterBoxGetShape;
}
\newcommand{\csposter@box@drawbackground@shadelr}[2]{
\tikzstyle{box colors}=[shading=axis, left color=#1, right color=#2]%
\fill[box colors] \csposterBoxGetShape;
}
\newcommand{\csposter@box@drawbackground@shadetb}[2]{
\tikzstyle{box colors}=[shading=axis, top color=#1, bottom color=#2]%
\fill[box colors] \csposterBoxGetShape;
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Draw box border
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% These functions take two arguments: borderColor
\newcommand{\csposter@box@drawborder@none}[1]{}
\newcommand{\csposter@box@drawborder@bars}[1]{
\draw[color=#1] \csposterBoxGetShape;%
}
\newcommand{\csposter@box@drawborder@coils}[1]{
\draw[color=#1,segment amplitude=0.35em,segment length=0.4em,snake=coil] \csposterBoxGetShape;%
}
\newcommand{\csposter@box@drawborder@triangles}[1]{
\draw[color=#1,segment amplitude=0.2em,segment length=0.4em,snake=triangles] \csposterBoxGetShape;%
}
\newcommand{\csposter@box@drawborder@rectangle}[1]{
\draw[color=#1] \csposterBoxGetShape;%
}
\newcommand{\csposter@box@drawborder@rounded}[1]{
\draw[color=#1] \csposterBoxGetShape;%
}
\newcommand{\csposter@box@drawborder@roundedleft}[1]{
\draw[color=#1] \csposterBoxGetShape;%
}
\newcommand{\csposter@box@drawborder@roundedright}[1]{
\draw[color=#1] \csposterBoxGetShape;%
}
\newcommand{\csposter@box@drawborder@faded}[1]{
\foreach \x in {0,1,...,99} { \draw[color=#1,opacity=\x/100] ($(\csposter@box@name tnw)!{(100-\x)/100}!(\csposter@box@name sw)$) -- ($(\csposter@box@name tnw)!{(100-(\x+1))/100}!(\csposter@box@name sw)$); }% 
\foreach \x in {0,1,...,99} { \draw[color=#1,opacity=\x/100] ($(\csposter@box@name tne)!{(100-\x)/100}!(\csposter@box@name se)$) -- ($(\csposter@box@name tne)!{(100-(\x+1))/100}!(\csposter@box@name se)$); }%
}
\newcommand{\csposter@box@drawborder@roundedsmall}[1]{
\draw[color=#1] \csposterBoxGetShape;%
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Return shape path of text box (depending on the box shape)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% These functions take no arguments
\newcommand{\csposter@box@headershape@rectangle}{%
(\csposter@box@name tnw) -- (\csposter@box@name nw) -- %
(\csposter@box@name ne) -- (\csposter@box@name tne)%
}
\newcommand{\csposter@box@headershape@smallrounded}{%
(\csposter@box@name tnw) {[src] -- (\csposter@box@name nw) -- %
(\csposter@box@name ne)} -- (\csposter@box@name tne)%
}
\newcommand{\csposter@box@headershape@roundedright}{%
(\csposter@box@name tnw) -- (\csposter@box@name nw) {[rc] -- %
(\csposter@box@name ne)} -- (\csposter@box@name tne)%
}
\newcommand{\csposter@box@headershape@roundedleft}{%
(\csposter@box@name tnw) {[rc]-- (\csposter@box@name nw)} -- %
(\csposter@box@name ne) -- (\csposter@box@name tne)%
}
\newcommand{\csposter@box@headershape@rounded}{%
(\csposter@box@name tnw) {[rc] -- (\csposter@box@name nw) -- %
(\csposter@box@name ne) } -- (\csposter@box@name tne)%
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Header text drawing (one function for each possible value of headershape)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% These functions take one argument: the header text
\newcommand{\csposter@box@headerdrawtext@rectangle}[1]{
\path (\csposter@box@name nw) +(0em,-0.5\csposter@box@@boxheaderheight) node[anchor=west,inner sep=0.4em] {#1};%
}
\newcommand{\csposter@box@headerdrawtext@smallrounded}[1]{
\path (\csposter@box@name nw) +(0.5\boxwidth,-0.5\csposter@box@@boxheaderheight) node[anchor=center] {#1};%
}
\newcommand{\csposter@box@headerdrawtext@roundedright}[1]{
\path (\csposter@box@name nw) +(0em,-0.5\csposter@box@@boxheaderheight)%
node[anchor=west,inner sep=0.4em,text depth=0.0em] {#1};%
}
\newcommand{\csposter@box@headerdrawtext@roundedleft}[1]{
\path (\csposter@box@name nw) +(0em,-0.5\csposter@box@@boxheaderheight)%
node[anchor=west,inner sep=0.4em] {#1};%
}
\newcommand{\csposter@box@headerdrawtext@rounded}[1]{
\path (\csposter@box@name nw) +(0.5\boxwidth,-0.5\csposter@box@@boxheaderheight) node[anchor=center] {#1};%
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Header shade options and functions (one function for each possible value)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% These functions take two arguments: headerColorOne, headerColorTwo and borderColor
\newcommand{\csposter@box@headershade@shadelr}[3]{
\debug{Header-Shade: Shade Left - Right}
\tikzstyle{header colors}=[%
color=#3,%
shading=axis,%
left color=#1,%
right color=#2%
]%
}
\newcommand{\csposter@box@headershade@shadetb}[3]{
\debug{Header-Shade: Shade Top - Bottom}
\tikzstyle{header colors}=[%
color=#3,%
shading=axis,%
top color=#1,%
bottom color=#2%
]%
}
\newcommand{\csposter@box@headershade@shadetbinverse}[3]{
\tikzstyle{header colors}=[%
top color=#1!75!#2,%
bottom color=#2!100!#1,%
shading angle=20%
]%
\colorlet{csposterHeaderFontColor}{white}%
}
\newcommand{\csposter@box@headershade@plain}[3]{
\debug{Header-Shade: Plain}
\tikzstyle{header colors}=[%
color=#3,%
fill=#1%
]%
}
\newcommand{\csposter@box@headershade@none}[3]{
\debug{Header-Shade: none}
\tikzstyle{header colors}=[]
}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% The main poster environment
%%% \begin{csposter}{settings}{Eye Catcher}{Title}{Author}{University Logo}
%%%-----------------------------------------------------------------------------
%%% The settings are
%%%   - grid=true,[false]:Show grid to help with alignment
%%%   - colspacing=0.7em: Column spacing
%%%   - columns=4:        number of columns (default 4 in landscape and 3 in portrait format) (maximum number is 6)
%%%   - color=[orange]:   xcolor color definition used as the main color of the poster
%%%   - colortwo=[white]: The other color for gradient based layouts
%%%   - textborder=none,bars,coils,triangles,rectangle,rounded,roundedsmall,roundedleft,roundedright,[faded]
%%%                       The style of the box around the text area
%%%   - headerborder=none,closed,open
%%%                       No extra border around box header, full border around box header or border that is open below.
%%%   - headershape=rectangle,rounded,roundedleft,roundedright
%%%                       Shape of the box-header region
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newenvironment{poster}[7]{%
\thispagestyle{empty}% Suppress Page Number
\debug{Poster Starts}%
% This setkeys call parses all provided options and depending on the option
% value, assigns different handler functions to the \csposter(Box|Header)*
% functions. Once that is done, we don't have to care about particular
% values for border, shading, etc. All we have to do is call the
% handler functions and let them do their job.
% This also allows the user to override the poster-wide defaults on a per-box
% basis.
\setkeys[cs]{posterbox,poster}{#1}%
%
% TODO: Move all those assignments to the key macros!
% Parse Keys%
\colorlet{bgColorOne}{\csposter@bgColorOne}
\colorlet{bgColorTwo}{\csposter@bgColorTwo}
%
%% Boxes%
\setlength{\headerheight}{\csposter@headerheight}%
\setlength{\colheight}{\textheight-\csposter@headerheight}%
\renewcommand{\@@previousbox}{notset}

\debug{Format}%
% Set default for columns if unset (4 for landscape, 3 for portrait)
\ifthenelse{\equal{\csposter@columns}{}}{%
\if@landscape
\renewcommand{\csposter@columns}{4}
\else
\renewcommand{\csposter@columns}{3}
\fi
%
}{}
%
\debug{Columns: \csposter@columns}%
\setlength{\csposter@@colspacing}{\csposter@colspacing}%
\setlength{\colwidth}{\textwidth}%
\addtolength{\colwidth}{\csposter@@colspacing*(1-\csposter@columns)}%
\ifcase\csposter@columns\relax
\error{You need to have at least one column!}
\or % 1
\setlength{\colwidth}{\colwidth}%
\or % 2
\setlength{\colwidth}{0.5\colwidth}%
\or % 3
\setlength{\colwidth}{0.3333333333333\colwidth}%
\or % 4
\setlength{\colwidth}{0.25\colwidth}%
\or % 5
\setlength{\colwidth}{0.2\colwidth}%
\or % 6
\setlength{\colwidth}{0.16666666666\colwidth}%
\else % >6
\error{You do not want so many columns}
\fi
%
\newcommand{\csposter@reference}{north west}%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A box with a header and some content. The basic unit of the poster%
%---------------------------------------------------------------------------%
% Each box has a name and can be placed absolutely or relatively.%
% The only inconvenience is that you can only specify a relative position %
% towards an already declared box. So if you have a box attached to the %
% bottom, one to the top and a third one which should be inbetween, you %
% have to specify the top and bottom boxes before you specify the middle %
% box.%
%%
% below=  name of other node%
% above=  name of other node%
% aligned=name of other node%
% bottomaligned=name of other node%
% column= [0]     %
% row=    [0]     %
% span=   [1]     %
% height= <size in percent of column height>,[auto]%
% name=   [noname]%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Backward-compatibility definition (\headerbox command uses posterbox env):
\newcommand{\headerbox}[3]{%
\begin{posterbox}[##2]{##1}
{\small
##3
}
\end{posterbox}
}

\newenvironment{posterbox}[2][]{%
\debug{Poster box options: ##1}%
% Override the poster-wide defaults on a per-box basis
\setkeys[cs]{posterbox}{##1}%
%
\def\csposter@box@title{##2}
%
\colorlet{borderColor}{\csposter@box@borderColor}
\colorlet{headerColorOne}{\csposter@box@headerColorOne}
\colorlet{headerColorTwo}{\csposter@box@headerColorTwo}
\colorlet{headerFontColor}{\csposter@box@headerFontColor}
\colorlet{boxColorOne}{\csposter@box@boxColorOne}
\colorlet{boxColorTwo}{\csposter@box@boxColorTwo}
%
\setlength{\csposter@box@@cornerradius}{\csposter@box@cornerradius}%
\ifthenelse{\equal{\csposter@box@title}{}}{% No header
\setlength{\csposter@box@@boxheaderheight}{0pt}%
}{ % With header
\setlength{\csposter@box@@boxheaderheight}{\csposter@box@boxheaderheight}%
}%
\setlength{\csposter@box@@boxpadding}{\csposter@box@boxpadding}%


%% The columns is always given absolute
% boxstartx = column * colwidth + column * colspacing
\setlength{\boxstartx}{(\colwidth+\csposter@@colspacing)*\csposter@box@column}%
%
%% The width is gvien absolute
% Box Width = span * colwidth + (span-1) * colspacing
\setlength{\boxwidth}{\csposter@box@span\colwidth} %
\addtolength{\boxwidth}{\csposter@@colspacing*(\csposter@box@span-1)}%
%
%% Measure the content of the box%
\setbox\csposter@box@content=\hbox\bgroup%
\begin{pgfinterruptpicture}%
\begin{minipage}[t]{\boxwidth-\csposter@box@@boxpadding*2}%
\csposter@box@textfont\bgroup%
}% End of posterbox preamble
%%% HERE COME THE ACTUAL CONTENTS OF THE HEADERBOX ENVIRONMENT
{% posterbox handling after contents (i.e. drawing everything)
\egroup%
\end{minipage}%
\end{pgfinterruptpicture}%
\egroup%
\setlength{\boxheight}{\ht\csposter@box@content}%
\addtolength{\boxheight}{\dp\csposter@box@content}%
\addtolength{\boxheight}{\csposter@box@@boxheaderheight} % Header%
\addtolength{\boxheight}{2\csposter@box@@boxpadding} % Inner Sep
%
\ifthenelse{\equal{\csposter@box@height}{bottom}}{%
}{\ifthenelse{\equal{\csposter@box@height}{auto}}{%
}{ % Neither auto nor bottom%
\setlength{\boxheight}{\csposter@box@height\colheight}%
}}%
%
%% Determine the box position%
\debug{Setting Coordinates}%
\debug{Upper Right}%
\debug{\csposter@box@name}%
%
%%% Upper Right Corner%
% if below=auto, set it to the previous box
% TODO: We should generalize this to the previous box of the used column,
%       currently we use the previous box, which might be in a different column
\ifthenelse{\equal{\csposter@box@below}{auto}}{%
\edef\csposter@box@below{\@@previousbox}
\debug{Box \csposter@box@name  has below=auto, placing it below box \csposter@box@below.}
}{}
\xdef\@@previousbox{\csposter@box@name}

\ifthenelse{\not\equal{\csposter@box@below}{notset} }{%
%% Below%
\debug{Below}%
\path[shape=coordinate] (\boxstartx,0pt |- \csposter@box@below se) ++(0pt,-\csposter@@colspacing) coordinate(\csposter@box@name nw);%
}{%
\ifthenelse{\not\equal{\csposter@box@aligned}{notset} }{%
%% Aligned%
\debug{Aligned: \csposter@box@aligned}%
\path[shape=coordinate] (\boxstartx,0pt |- \csposter@box@aligned nw)                           coordinate(\csposter@box@name nw);%
}{%
%% Fixed%
\debug{Fixed}%
\setlength{\boxstarty}{\csposter@box@row\colheight}%
\path[shape=coordinate] (\boxstartx,\colheight-\boxstarty)                                                  coordinate(\csposter@box@name nw);%
}}%
%
%% Lower Left Corner%
\debug{Lower Left}%
\ifthenelse{\equal{\csposter@box@above}{bottom}}{%
%% Above = Bottom%
\debug{Above bottom}%
\ifthenelse{\equal{\csposter@box@below}{notset} \and \equal{\csposter@box@aligned}{notset}}{%
\path[shape=coordinate] (\boxstartx,\boxheight)                                                              coordinate(\csposter@box@name nw);%
}{}%
\path[shape=coordinate] (\boxstartx+\boxwidth,0pt)                                                           coordinate(\csposter@box@name se);%
}{\ifthenelse{\not \equal{\csposter@box@bottomaligned}{notset}}{%
\path[shape=coordinate] (\boxstartx+\boxwidth,0pt |- \csposter@box@bottomaligned se)                       coordinate(\csposter@box@name se);%
}{{\ifthenelse{\not \equal{\csposter@box@above}{notset}}{%
%% Above = Node%
\path[shape=coordinate] (\boxstartx+\boxwidth,0pt |- \csposter@box@above nw)  +(0pt,\csposter@@colspacing) coordinate(\csposter@box@name se);%
}{%
%% Above = notset%
\debug{Above=not set}%
\ifthenelse{\equal{\csposter@box@height}{bottom}}{%
%% height=bottom%
\debug{height=bottom}%
\path[shape=coordinate] (\boxstartx+\boxwidth,0pt)                                                       coordinate(\csposter@box@name se);%
}{ %% height=auto or fixed%
\debug{height=auto or fixed}%
\path[shape=coordinate] (\csposter@box@name nw) ++(\boxwidth,-\boxheight)                                coordinate(\csposter@box@name se);%
}}}}}%
%
%
% Set coordinates relative to nw,se%
\debug{Fixing Coordinates}%
\path[shape=coordinate]%
(\csposter@box@name nw) +(0pt,-\csposter@box@@boxheaderheight)                coordinate(\csposter@box@name tnw)%
(\csposter@box@name nw |- \csposter@box@name se)   coordinate(\csposter@box@name sw)%
(\csposter@box@name se |- \csposter@box@name nw)   coordinate(\csposter@box@name ne)%
(\csposter@box@name ne) +(0pt,-\csposter@box@@boxheaderheight)                coordinate(\csposter@box@name tne)%
%
(\csposter@box@name nw)  +(-0.025em,0pt)           coordinate(\csposter@box@name outer nw)%
(\csposter@box@name tnw) +(-0.025em,0pt)           coordinate(\csposter@box@name outer tnw)%
(\csposter@box@name sw)  +(-0.025em,0pt)           coordinate(\csposter@box@name outer sw)%
%
(\csposter@box@name ne)  +( 0.025em,0pt)           coordinate(\csposter@box@name outer ne)%
(\csposter@box@name tne) +( 0.025em,0pt)           coordinate(\csposter@box@name outer tne)%
(\csposter@box@name se)  +( 0.025em,0pt)           coordinate(\csposter@box@name outer se);%
%
%% Setting the bg colors of the box header
\csposterHeaderSetShade{headerColorOne}{headerColorTwo}{borderColor}
%
\tikzstyle{rc}=[rounded corners=\csposter@box@@cornerradius];%
\tikzstyle{src}=[rounded corners=0.5em];%
%

%% Now that everything is set up, draw the actual box, with bg and header
\begin{scope}[line width=\csposter@box@linewidth]
%% Header%
\debug{Header}%
\debug{Header-Shape: \csposter@box@headershape, header-border: \csposter@box@headerborder (\csposter@box@headerbordernr)}%
% TODO: Also turn this last ifcase construct into a handler function
%       We only need to determine (fill|shade)(draw|)...
%       \csposterHeaderDrawBackground{bgColorOne}{bgColorTwo}{borderColor}
%       \csposterHeaderDrawBorder{borderColor}
\ifthenelse{\equal{\csposter@box@title}{}}{% No header
}{% With header
\ifcase\csposter@box@headerbordernr\relax%
% open
\ifthenelse{\equal{\csposter@box@headershade}{plain}}{
\filldraw  [style=header colors] \csposterHeaderGetShape;%
}{
\shadedraw [style=header colors] \csposterHeaderGetShape;%
}
\or
% closed
\ifthenelse{\equal{\csposter@box@headershade}{plain}}{
\filldraw  [style=header colors] \csposterHeaderGetShape -- cycle;%
}{
\shadedraw [style=header colors] \csposterHeaderGetShape -- cycle;%
}
\or
% none
\ifthenelse{\equal{\csposter@box@headershade}{plain}}{
\fill      [style=header colors] \csposterHeaderGetShape;%
}{
\shade     [style=header colors] \csposterHeaderGetShape;%
}
\fi
%
%% Draw the text inside the box header:
\csposterHeaderDrawText{\color{headerFontColor}\csposter@box@headerfont{\csposter@box@title}};%
}
%
%% Text borders (border around boxes)
\debug{Poster boxes}%
% First set box shade
\csposterBoxDrawBackground{boxColorOne}{boxColorTwo}
\csposterBoxDrawBorder{borderColor}
%%
%% Text Box%
\debug{Drawing Text}%
\path (\csposter@box@name tnw) node(text) [anchor=north west,
outer sep=-0.000em,text width=\boxwidth-2\csposter@box@@boxpadding,inner sep=\csposter@box@@boxpadding,
text justified] {\usebox{\csposter@box@content}};%
\end{scope}
%
% Finally store the box name as the previous box for the next call
%     \xdef\@@previousbox{\csposter@box@name}%
}% END of posterbox definition
%
%% Poster Background%
\csposterPosterDrawBackground{bgColorOne}{bgColorTwo}%
%% Poster header/title
\hspace{-1.5em}%
  \begin{tikzpicture}[inner sep=0pt,outer sep=0pt,line width=0.05em]%
  \useasboundingbox (0em,0em) rectangle(\textwidth,\textheight);%
  \path[shape=coordinate]%
  (0pt,\colheight) coordinate(north west) (\textwidth,\colheight) coordinate(north east)%
  (0pt,0pt) coordinate(south west)        (\textwidth,0pt) coordinate(south east);%

  %      % Draw Header%
  \draw (north west) +(0em,-1em+0.5\headerheight) node(image)[anchor=west]   { {\usebox{\csposter@titleimage@left }} };%
  \draw (north east) +(0em,-1em+0.5\headerheight) node(logo) [anchor=east]   { {\usebox{\csposter@titleimage@right}} };%
  %
  \draw (image.east) node(title)[anchor=west]{ 
  {
  \begin{minipage}[b]{1\linewidth}
  \begin{center}
  \Huge \textbf{#3}
  \\[0.4cm] 
  \Large \textbf{#4}
  \\[0.4cm]
  \large \textbf{#5}
  \\[0cm]
  \large \texttt{#6}
  \\[0.4cm]
  #7
  \end{center}
  \end{minipage}
  } 
  };%
  }% END poster begin
{ % The body
  % draw gridlines if necessary
    \ifcsposter@grid
      \newdimen{\gridpos}
      \typeout{\csposter@columns-1}
      \pgfmathsetmacro{\z}{\csposter@columns-1}
      \foreach \y in {0,...,\z}
      {
        \setlength{\gridpos}{\y\colwidth+\y\csposter@@colspacing}
        \draw[draw=green,draw opacity=0.7] (\gridpos,0pt)  -- (\gridpos,\colheight)
        (\gridpos+\colwidth,0pt)  -- (\gridpos+\colwidth,\colheight);%
      }
      % Horizontal lines, every 0.1:
      %% Explicitly list all percentages, because with {0.0, 0.1, ..., 1.0} we get rounding errors in the displayed numbers!
      \foreach \y in {0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0}
        \draw[draw=green,draw opacity=0.7] (0pt,\colheight-\y\colheight)  --
        (\textwidth,\colheight-\y\colheight) node[anchor=west] {\y};%
    \fi%
  \end{tikzpicture}%
  \par
}