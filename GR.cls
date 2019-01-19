% !TeX TS-program = lualatex
% !TeX encoding = UTF-8
% ===============================
%  Genome Research class by 
%  Jose Manuel Martí (I2SysBio)
% ===============================
%  Release: 19 Jan 2019
% ===============================
%  Front-end: luaLaTeX
% ===============================
\ProvidesClass{GR}[2019/01/19 GR]
\NeedsTeXFormat{LaTeX2e}

%%% CALL BASE CLASS
\LoadClass[11pt,oneside,letterpaper]{article}

%%% ENCODING AND LANGUAGE
\RequirePackage[english]{babel} 

%%% PAGE DIMENSIONS, LINE SPACING AND CAPTIONS
\RequirePackage[
	letterpaper,
	textwidth=16.25cm, % 15.25cm for single-space, 16.25cm for double-space
	textheight=22.5cm, % 22cm for single-space, 22.5cm for double-space
	]{geometry}
	
% Review layout with double-spacing
\RequirePackage{setspace} 
% Captions will be left justified
% Bold the 'Figure #' in the caption and separate it with a period
\RequirePackage[labelfont=bf,labelsep=period,font=small,tableposition=top]{caption} % font=doublespacing
%\DeclareCaptionFormat{empty}{}  % COMMENT THIS LINE AND THE NEXT FOR REACTIVATING CAPTIONS
%\captionsetup{format=empty,aboveskip=0pt,belowskip=0pt} %

%%% IMPORTANCE & KEYWORDS: Importance environment and keywords command (just the latter used in GR)
\newcommand\importancename{Importance}
\newcommand{\importance}[1]{
	{
		\small
		\begin{center}
			{\bfseries \importancename\vspace{-.5em}\vspace{0pt}}
		\end{center}
		\begin{quote}
			#1
		\end{quote}
	}
}
\providecommand{\keywords}[1]{\footnotesize\textbf{\textit{Keywords---}} #1}


%%%%%%%%%%
% Colors %
%%%%%%%%%%
\RequirePackage[usenames,dvipsnames,table]{xcolor}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Graphics & floating stuff %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%\RequirePackage{tikz}
\RequirePackage{graphicx}

% helps to keep figures from being orphaned on a page by themselves
\renewcommand{\topfraction}{0.85}
\renewcommand{\textfraction}{0.1}

%\RequirePackage{floatrow}
%\floatsetup[table]{capposition=top}


%%%%%%%%%
% Fonts %
%%%%%%%%%

% Comment the lines or change the font names to your preferred fonts
\RequirePackage{luaotfload}
\RequirePackage{fontspec}
\defaultfontfeatures{Scale = MatchLowercase, Numbers=OldStyle, Ligatures=TeX}
\defaultfontfeatures[\rmfamily]{Scale = 1}
\newfontfamily\titlefont{Adelon Regular}[Scale=1.2]
\newfontfamily\rtitlefont{Adelon Semibold}[Scale=MatchUppercase]
\newfontfamily\authorfont{Myriad Pro}[Scale=MatchUppercase]
\setmainfont{Minion Pro}
\setsansfont{Adelon}[
BoldFont = * Semibold
]
\setmonofont{Source Code Pro}[
Scale = MatchLowercase,
UprightFont = * Light,
BoldFont = * Regular,
]

%%%%%%%%%%
% Others %
%%%%%%%%%%

%%% MATH AND UNITS
%\RequirePackage{moreverb} % for verbatim output
\RequirePackage{amsmath}  % math notation
\RequirePackage{amssymb}  % math notation
\RequirePackage[binary-units]{siunitx}  % SI units notation
%\RequirePackage[mathscr]{eucal}  % Euler script characters

%%% LINE NUMBERING
\RequirePackage[running,mathlines]{lineno}
\renewcommand\thelinenumber{\color{red}\arabic{linenumber}}
\linenumbers

%%% AUTHORS/AFFILIATIONS
\RequirePackage{authblk}
\renewcommand\Authands{ \& }
\renewcommand\Authfont{\normalsize \bf}
\renewcommand\Affilfont{\small \normalfont}
%% Roman footnote numbering style to not collide with bibliographic cites: 
\renewcommand{\thefootnote}{\Roman{footnote}}


%%%%%%%%%%%%%%
% Hyperlinks %
%%%%%%%%%%%%%%

\RequirePackage{xr-hyper}
\RequirePackage[
pdfencoding=auto,
pdftitle={Your title},
pdfauthor={Your name},
pdfsubject={Genome Research},
pdfkeywords={GR},
bookmarksopen,
colorlinks=false,
urlcolor={blue},
bookmarks=true
]{hyperref} % hiperlinks support

\makeatletter
\Hy@AtBeginDocument{%
	\def\@pdfborder{0 0 1}% Overrides border definition set with colorlinks=true
	\def\@pdfborderstyle{/S/U/W 1}% Overrides border style set with colorlinks=true
	% Hyperlink border style will be underline of width 1pt
}
\makeatother


%%%%%%%%%%%%%%%%
% Bibliography %
%%%%%%%%%%%%%%%%

\RequirePackage[
	backend=biber,
	style=authoryear,
	sorting=nyt,
	sortlocale=auto,
	maxcitenames=2,
	maxbibnames=10,
%	uniquelist=false,  % Avoid disambiguation adding a 2n surname
	uniquename=init,
	maxitems=2,
	giveninits=true,
	terseinits=true,
	dashed=false,
	doi=false,
	isbn=false,
	url=false
]{biblatex}
	
\RequirePackage{csquotes}

% General customizations

\DeclareNameAlias{sortname}{family-given}  % Last-1st name order in the bibliography
\renewcommand*{\revsdnamepunct}{}  % Remove remove commas between last and first names in bibliography
\DeclareFieldFormat*{title}{#1}  % Remove "" enclosing the title

\renewbibmacro*{date+extradate}{ % Avoid year inside parenthesis
	\iffieldundef{labelyear}
	{}
	{\printtext[]{\printlabeldateextra}
		\newunit}
}%


\DeclareBibliographyDriver{book}{%
	\printnames{author}%
\finentry}

% Customization for article

\DeclareBibliographyDriver{article}{%
	\printnames{author}%
	\newunit%
	\usebibmacro{date+extradate}%
	\printfield{title}\printfield{titleaddon}%
	\newunit%
	\printfield{journaltitle}%
	\newunit%
	\printfield{volume}%
	\printfield{pages}%
	\usebibmacro{doi}
\usebibmacro{finentry}}

\DeclareFieldFormat[article]{journaltitle}{\mkbibemph{#1}} % italic journal title
\DeclareFieldFormat[article]{volume}{\mkbibbold{#1}\addcolon\addspace} % italic journal title
\DeclareFieldFormat[article]{pages}{#1}

\newbibmacro*{doi}{%
	\iffieldequalstr{journaltitle}{BioRxiv}{ % Check if the journal is "BioRxiv"
		\newunit
		\printfield{doi}}{}
}

% Customization for book

\DeclareBibliographyDriver{book}{%
	\printnames{author}%
	\newunit%
	\usebibmacro{date+extradate}%
	\usebibmacro{chaptertitle+booktitle}%
	\newunit
	\ifnameundef{editor}{}{\printtext[parens]{\usebibmacro{byeditor+others}}}  % Print (editors)
	\newunit
	\usebibmacro{chapter+pages}%
	\newunit
	\usebibmacro{publisher+location}%
\usebibmacro{finentry}}

\DeclareFieldFormat[book]{booktitle}{\mkbibemph{#1}} % italic journal title
\newbibmacro{chaptertitle+booktitle}{%
	\iffieldundef{title}
	{\printfield{booktitle}}
	{\printfield{title}\newunit\bibstring{in}\addspace\printfield{booktitle}}
}

\newbibmacro*{publisher+location}{%
	\printlist{publisher}
	\iflistundef{location}
	{}
	{\addcomma\newunit\printlist{location}}
	\newunit
}

% Alias inbook -> book

\DeclareBibliographyAlias{inbook}{book}
