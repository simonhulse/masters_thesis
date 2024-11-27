% oxchempartii-report.cls
% Simon Hulse
% simonhulse@protonmail.com
% Last Edited: Wed 27 Nov 2024 02:53:35 PM EST

\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\def\versionnumber{1.2b}
\ProvidesClass{oxchempartii-report}[2014/12/19 v\versionnumber\ Class for typesetting University of Oxford Chemistry Part II theses, Wojciech Kaluza]

%%% Class options, related warnings and conditionals %%%%%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass[a4paper,12pt,openright]{book}
%
\newif\if@draft\DeclareOption{draft}{\@drafttrue}\DeclareOption{final}{\@draftfalse}\@draftfalse
\newif\if@twoside\DeclareOption{twoside}{\@twosidetrue}\DeclareOption{oneside}{\@twosidefalse}\@twosidetrue
\newif\if@tightbibliography\DeclareOption{tightbibliography}{\@tightbibliographytrue}\DeclareOption{normalbibliography}{\@tightbibliographyfalse}\@tightbibliographyfalse
\newif\if@usefourier\DeclareOption{usefourier}{\@usefouriertrue}\DeclareOption{dontusefourier}{\@usefourierfalse}\@usefouriertrue
\newif\if@freezetoc\DeclareOption{freezetoc}{\@freezetoctrue}\DeclareOption{thawtoc}{\@freezetocfalse}\@freezetocfalse
\newif\if@doublespace\DeclareOption{doublespace}{\@doublespacetrue}\DeclareOption{normalspace}{\@doublespacefalse}\@doublespacefalse
%
\ProcessOptions*\relax
\providecommand*{\ifdraft}{\if@draft\expandafter\@firstoftwo\else\expandafter\@secondoftwo\fi}
%
\if@draft%
\else%
\fi
\if@freezetoc\ClassWarningNoLine{oxchempartii}{Option `freezetoc' enabled: ToC and Lists will not be updated}\fi%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Detect if we are using something other than pdfTeX
\RequirePackage{ifpdf, ifxetex, ifluatex}

\ifxetex
	% XeLaTeX specific packages
	\if@usefourier
	    % Carry on as normal
    \else
        \PackageError{oxchempartii}{XeLaTeX is not compatible with the upright greek letters}{}
    \fi
\else
    \ifluatex
        %LuaLaTeX specific packages
        	\if@usefourier
	        % Carry on as normal
        \else
            \PackageError{oxchempartii}{LuaLatex is not compatible with the upright greek letters}{}
        \fi
    \else
        %pdfLaTeX specific packages
        \RequirePackage[T1]{fontenc}
        \RequirePackage[utf8]{inputenc}
        \RequirePackage[english]{babel}
        \RequirePackage{csquotes}
    \fi
\fi

%%% Various packages %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage[table]{xcolor}

% Tables
\RequirePackage{booktabs}
\RequirePackage{array}

% Floats - graphicx provides \includegraphics
\RequirePackage{float}
\RequirePackage{graphicx}

\RequirePackage{etoolbox}
\RequirePackage{fancyhdr}
\RequirePackage{xpatch}
\RequirePackage{caption}
\RequirePackage{subcaption}
\RequirePackage{bookmark}
% Maths displayers - amsmath gives DeclareMathOperator, \text etc
% asmsymb gives lots of wacky symbols and loads amsfont
% eucal is twiddly letters, xfrac is x/y diagonal fractions
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage[mathscr]{eucal}
\RequirePackage{xfrac}
% Provides underlining
\RequirePackage[normalem]{ulem}
\RequirePackage[doublespacing]{setspace}
\RequirePackage{fancyvrb}
\RequirePackage{lscape}

\RequirePackage{ifthen}
\RequirePackage{siunitx}

\RequirePackage{physics}

% mhchem provides chemical equations in \ce
\RequirePackage[version=4]{mhchem}

% Turns references into hyperlins
\RequirePackage{hyperref}

\RequirePackage{environ}
\RequirePackage{pgfplots}
\RequirePackage{fp}
\RequirePackage{fancyvrb}
\RequirePackage{lipsum}
\RequirePackage{pdfpages}

\RequirePackage[defernumbers=true,style=chem-angew]{biblatex}
\RequirePackage{datetime}
\RequirePackage[a4paper,total={15cm,24cm},top=3cm,inner=1.46in, outer=0.8in, headheight=14.5pt]{geometry}

%Simon
\usepackage{tikz}

% Float configuration
\floatstyle{boxed}
\newfloat{program}{tbp}{los}[chapter]
\floatname{program}{Program}
\floatstyle{plain}


% Enables / disables comments for draft mode
\NewEnviron{ShownComment}
  {\if@draft
    \color{red}
    \itshape
  	\BODY\
   \else\fi}


% PGF configuration
\newcommand{\figurewidth}{0.90\textwidth}  % for TikZ pictures
\newcommand{\figureheight}{10cm}  % for TikZ pictures
\usepgfplotslibrary{external}
\usetikzlibrary{calc}
\usepackage{tikzducks}
\pgfplotsset{compat=1.14}
\tikzexternalize[prefix=./Figures/TemporaryGraphicsFiles/]
\newcommand{\includepgf}[2][1.0\figurewidth]{%
\ifdraft{%
    \fbox{%
        \vbox to \figureheight{%
            \vfil \hbox to \figurewidth{\texttt{\detokenize{#2}.tex}}%
        \vfil}%
        }%
    }%
{\input{#2}}}

%\makeatletter
\def\calcLength(#1,#2)#3{%
\pgfpointdiff{\pgfpointanchor{#1}{center}}%
             {\pgfpointanchor{#2}{center}}%
\pgf@xa=\pgf@x%
\pgf@ya=\pgf@y%
\FPeval\@temp@a{\pgfmath@tonumber{\pgf@xa}}%
\FPeval\@temp@b{\pgfmath@tonumber{\pgf@ya}}%
\FPeval\@temp@sum{(\@temp@a*\@temp@a+\@temp@b*\@temp@b)}%
\FProot{\FPMathLen}{\@temp@sum}{2}%
\FPround\FPMathLen\FPMathLen5\relax
\global\expandafter\edef\csname #3\endcsname{\FPMathLen}
}
%\makeatother

%%% Page layout and general formatting %%%%%%%%%%%%%%%%%%%%%
%%% Sectioning commands


\if@doublespace
    \renewcommand{\baselinestretch}{2}
\else
    % Do nothing
\fi

\newlength\chapteroverhead
\newlength\chapterheadtemp
\newlength\chapterheadtempp
\newlength\chapterheadtemppp
\newlength\chapterheadtempppp

\def\setchapteroverhead#1{%
\setlength{\chapteroverhead}{#1}%
\setlength{\chapterheadtemp}{\chapteroverhead}%
\setlength{\chapterheadtempp}{\chapterheadtemp}%
\setlength{\chapterheadtemppp}{\chapteroverhead}%
\setlength{\chapterheadtempppp}{\chapteroverhead}%
\addtolength{\chapterheadtemp}{0pt}%
\addtolength{\chapterheadtempp}{0pt}%
\addtolength{\chapterheadtemppp}{0pt}%
\addtolength{\chapterheadtempppp}{0pt}%
}
\setchapteroverhead{10pt}

\renewcommand{\@makechapterhead}[1]{\vspace*{\chapteroverhead}{\parindent\z@\centering\ifnum\c@secnumdepth>\m@ne\if@mainmatter\bfseries\@chapapp\space\thechapter\par\nobreak\vspace{0pt}\else\vspace{10pt}\fi\fi\interlinepenalty\@M\Large\bfseries#1\par\nobreak\if@mainmatter\vskip\chapterheadtemp\else\vskip\chapterheadtempp\fi}}
\renewcommand{\@makeschapterhead}[1]{\vspace*{\chapterheadtemppp}{\parindent\z@\centering\par\nobreak\interlinepenalty\@M\Large\bfseries#1\par\nobreak\vskip\chapterheadtempppp}}


\renewcommand\section{\@startsection{section}{1}{\z@}{-3.5ex \@plus -1ex \@minus -.2ex}{2.3ex \@plus.2ex}{\large\bfseries\upshape}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}{-3.25ex\@plus -1ex \@minus -.2ex}{1.5ex \@plus .2ex}{\normalsize\bfseries\upshape}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}{-3.25ex\@plus -1ex \@minus -.2ex}{1.5ex \@plus .2ex}{\normalsize\itshape\bfseries}}

\let\paragraph\textbf

\let\@chapterold\@chapter
\def\@chapter[#1]#2{\@chapterold[#1]{#2}\@mkboth{#2}{#2}}
\let\@schapterold\@schapter
\def\@schapter#1{\@schapterold{#1}\@mkboth{#1}{#1}}

\renewcommand\part{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \thispagestyle{empty}%
  \if@twocolumn
    \onecolumn
    \@tempswatrue
  \else
    \@tempswafalse
  \fi
  \null\vfil
  \secdef\@part\@spart}

\let\parttemp\part
\let\part\undefined
%%%

\setcounter{secnumdepth}{2}
\setcounter{tocdepth}{2}

\fancyhf{}
\if@twoside%
\fancypagestyle{headings}{
   \fancyhf{}
   \renewcommand{\headrulewidth}{0.5pt}\renewcommand{\footrulewidth}{0pt}
   \fancyhead[LE]{\slshape\nouppercase\leftmark}
   \fancyhead[RO]{\slshape\nouppercase\rightmark}
   \fancyfoot[RO,LE]{\thepage}
   \fancyfoot[C]{\if@draft\texttt{\tiny Draft \today}\fi}
}
\fancypagestyle{plain}{
   \fancyhf{}
   \renewcommand{\headrulewidth}{0pt}\renewcommand{\footrulewidth}{0pt}
   \fancyfoot[RO,LE]{\thepage}
   \fancyfoot[C]{\if@draft\texttt{\tiny Draft \today}\fi}
}
\else
\fancypagestyle{headings}{
   \fancyhf{}
   \renewcommand{\headrulewidth}{0.5pt}\renewcommand{\footrulewidth}{0pt}
   \fancyhead[R]{\slshape\nouppercase\rightmark}
   \fancyfoot[R]{\thepage}
   \fancyfoot[C]{\if@draft\texttt{\tiny Draft \today}\fi}
}
\fancypagestyle{plain}{
   \fancyhf{}
   \renewcommand{\headrulewidth}{0pt}\renewcommand{\footrulewidth}{0pt}
   \fancyfoot[R]{\thepage}
   \fancyfoot[C]{\if@draft\texttt{\tiny Draft \today}\fi}
}
\fi%
\fancypagestyle{empty}{
   \fancyhf{}
   \renewcommand{\headrulewidth}{0pt}\renewcommand{\footrulewidth}{0pt}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%% Empty pages %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\emptyversopage}{\clearpage\pagestyle{empty}\cleardoublepage\pagestyle{headings}}
\let\emptyversopageinclude\emptyversopage
\let\frontmatterold\frontmatter
\def\frontmatter{\frontmatterold\let\emptyversopageinclude\emptyversopage}
\let\tableofcontentsold\tableofcontents
\def\tableofcontents{\emptyversopageinclude\begingroup\onehalfspacing\tableofcontentsold\endgroup}
\let\listofold\listof
\def\listof#1#2{\emptyversopageinclude%
\addcontentsline{toc}{chapter}{#2}%
\begingroup\onehalfspacing\listofold{#1}{#2}\endgroup}
\let\mainmatterold\mainmatter
\def\mainmatter{\clearpage\pagestyle{empty}\mainmatterold\pagestyle{headings}\let\emptyversopageinclude\relax}
\let\appendixold\appendix
\def\appendix{\clearpage\pagestyle{empty}\cleardoublepage\appendixold%
\parttemp*{Appendices}\cleardoublepage\pagestyle{headings}\let\emptyversopageinclude\emptyversopage}
\let\includeold\include
\def\include#1{\emptyversopageinclude\includeold{#1}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Title page %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newlength\titlebaselineskip
\setlength{\titlebaselineskip}{35pt}
\newcommand{\makeoxtitle}[1]{{%
\setlength{\parindent}{0pt}%
\thispagestyle{empty}%
    \begin{center}
    \setlength{\baselineskip}{\titlebaselineskip}%
    {\Large\bfseries\rmfamily\@title}\par
    {\bfseries\rmfamily\@subtitle}\par
    \vfil
    {\bfseries\large\rmfamily\@author}\par
    \vspace{0.75em}
    \@college\par University of Oxford
\vfil
\includegraphics[draft=false,width=1.8in]{#1}\\
\begin{ShownComment}
\huge \textsc{
Draft Version} \\
\textsc{\today}
\end{ShownComment}
\vfil
     \@typeofdocument
     \vfil
     \@institution\par
     Oxford, \@date%
     \end{center}
   \let\maketitle\relax}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Greek letters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\if@usefourier
	\RequirePackage[sloped,widespace]{fourier}
	%%% Lowercase upright
	\let\alphaupold\otheralpha
	\def\alphaup{\ensuremath{\alphaupold}}
	\let\betaupold\otherbeta
	\def\betaup{\ensuremath{\betaupold}}
	\let\gammaupold\othergamma
	\def\gammaup{\ensuremath{\gammaupold}}
	\let\deltaupold\otherdelta
	\def\deltaup{\ensuremath{\deltaupold}}
	\let\epsilonupold\otherepsilon
	\def\epsilonup{\ensuremath{\epsilonupold}}
	\let\zetaupold\otherzeta
	\def\zetaup{\ensuremath{\zetaupold}}
	\let\etaupold\othereta
	\def\etaup{\ensuremath{\etaupold}}
	\let\thetaupold\othertheta
	\def\thetaup{\ensuremath{\thetaupold}}
	\let\iotaupold\otheriota
	\def\iotaup{\ensuremath{\iotaupold}}
	\let\kappaupold\otherkappa
	\def\kappaup{\ensuremath{\kappaupold}}
	\let\lambdaupold\otherlambda
	\def\lambdaup{\ensuremath{\lambdaupold}}
	\let\muupold\othermu
	\def\muup{\ensuremath{\muupold}}
	\let\nuupold\othernu
	\def\nuup{\ensuremath{\nuupold}}
	\let\xiupold\otherxi
	\def\xiup{\ensuremath{\xiupold}}
	\let\piupold\otherpi
	\def\piup{\ensuremath{\piupold}}
	\let\rhoupold\otherrho
	\def\rhoup{\ensuremath{\rhoupold}}
	\let\sigmaupold\othersigma
	\def\sigmaup{\ensuremath{\sigmaupold}}
	\let\tauupold\othertau
	\def\tauup{\ensuremath{\tauupold}}
	\let\upsilonupold\otherupsilon
	\def\upsilonup{\ensuremath{\upsilonupold}}
	\let\phiupold\otherphi
	\def\phiup{\ensuremath{\phiupold}}
	\let\chiupold\otherchi
	\def\chiup{\ensuremath{\chiupold}}
	\let\psiupold\otherpsi
	\def\psiup{\ensuremath{\psiupold}}
	\let\omegaupold\otheromega
	\def\omegaup{\ensuremath{\omegaupold}}
	%%% Uppercase upright
	\let\Gammaupold\Gamma
	\def\Gammaup{\ensuremath{\Gammaupold}}
	\let\Deltaupold\Delta
	\def\Deltaup{\ensuremath{\Deltaupold}}
	\let\Thetaupold\Theta
	\def\Thetaup{\ensuremath{\Thetaupold}}
	\let\Lambdaupold\Lambda
	\def\Lambdaup{\ensuremath{\Lambdaupold}}
	\let\Xiupold\Xi
	\def\Xiup{\ensuremath{\Xiupold}}
	\let\Piupold\Pi
	\def\Piup{\ensuremath{\Piupold}}
	\let\Sigmaupold\Sigma
	\def\Sigmaup{\ensuremath{\Sigmaupold}}
	\let\Upsilonupold\Upsilon
	\def\Upsilonup{\ensuremath{\Upsilonupold}}
	\let\Phiupold\Phi
	\def\Phiup{\ensuremath{\Phiupold}}
	\let\Psiupold\Psi
	\def\Psiup{\ensuremath{\Psiupold}}
	\let\Omegaupold\Omega
	\def\Omegaup{\ensuremath{\Omegaupold}}
	%%% Variant Greek letters (upright)
	\let\varepsilonupold\othervarepsilon
	\def\varepsilonup{\ensuremath{\varepsilonupold}}
	\let\varthetaupold\othervartheta
	\def\varthetaup{\ensuremath{\varthetaupold}}
	\let\varpiupold\othervarpi
	\def\varpiup{\ensuremath{\varpiupold}}
	\let\varrhoupold\othervarrho
	\def\varrhoup{\ensuremath{\varrhoupold}}
	\let\varsigmaupold\othervarsigma
	\def\varsigmaup{\ensuremath{\varsigmaupold}}
	\let\varphiupold\othervarphi
	\def\varphiup{\ensuremath{\varphiupold}}
\else

    % Computer Modern doesn't come with upright Greek letters by itself, but they're correct for writing
    % phases e.g. \alphaup-phase or for coordination e.g. \etaup-5. Fourier does come with them, but otherwise
    % we need to unslant them ourselves using pdf trickery.
	\newsavebox{\foobox}

	\newcommand{\slantbox}[2][0]{\mbox{%
	\sbox{\foobox}{#2}%
	\hskip\wd\foobox
	\pdfsave
	\pdfsetmatrix{1 0 #1 1}%
	\llap{\usebox{\foobox}}%
	\pdfrestore
	}}
	\newcommand{\unslant}[2][-.25]{\slantbox[#1]{\ensuremath{#2}}}
    \newcommand{\alphaup}{\unslant{\alpha}}
    \newcommand{\Alphaup}{A}
    \newcommand{\betaup}{\unslant{\beta}}
    \newcommand{\Betaup}{B}
    \newcommand{\gammaup}{\unslant{\gamma}}
    \newcommand{\Gammaup}{\unslant[0.00]{\Gamma}}
    \newcommand{\deltaup}{\unslant{\delta}}
    \newcommand{\Deltaup}{\unslant[0.00]{\Delta}}
    \newcommand{\epsilonup}{\unslant{\epsilon}}
    \newcommand{\Epsilonup}{E}
    \newcommand{\zetaup}{\unslant[-.15]{\zeta}}
    \newcommand{\Zetaup}{Z}
    \newcommand{\etaup}{\unslant{\eta}}
    \newcommand{\Etaup}{H}
    \newcommand{\thetaup}{\unslant{\theta}}
    \newcommand{\Thetaup}{\unslant[0.00]{\Theta}}
    \newcommand{\iotaup}{\unslant{\iota}}
    \newcommand{\Iotaup}{I}
    \newcommand{\kappaup}{\unslant{\kappa}}
    \newcommand{\Kappaup}{K}
    \newcommand{\lambdaup}{\unslant{\lambda}}
    \newcommand{\Lambdaup}{\unslant[0.00]{\Lambda}}
    \newcommand{\muup}{\unslant{\mu}}
    \newcommand{\Muup}{M}
    \newcommand{\nuup}{\unslant{\nu}}
    \newcommand{\Nuup}{N}
    \newcommand{\xiup}{\unslant[-0.15]{\xi}}
    \newcommand{\Xiup}{\unslant[0.00]{\Xi}}
    \newcommand{\omicronup}{o}
    \newcommand{\Omicronup}{O}
    \newcommand{\piup}{\unslant{\pi}}
    \newcommand{\Piup}{\unslant[0.00]{\Pi}}
    \newcommand{\rhoup}{\unslant{\rho}}
    \newcommand{\Rhoup}{R}
    \newcommand{\sigmaup}{\unslant{\sigma}}
    \newcommand{\Sigmaup}{\unslant[0.00]{\Sigma}}
    \newcommand{\tauup}{\unslant{\tau}}
    \newcommand{\Tauup}{T}
    \newcommand{\upsilonup}{\unslant{\upsilon}}
    \newcommand{\Upsilonup}{\unslant[0.00]{\Upsilon}}
    \newcommand{\phiup}{\unslant{\phi}}
    \newcommand{\Phiup}{\unslant[0.00]{\Phi}}
    \newcommand{\chiup}{\unslant{\chi}}
    \newcommand{\Chiup}{X}
    \newcommand{\psiup}{\unslant{\psi}}
    \newcommand{\Psiup}{\unslant[0.00]{\Psi}}
    \newcommand{\omegaup}{\unslant{\omega}}
    \newcommand{\Omegaup}{\unslant[0.00]{\Omega}}

\fi




%%% Sub- and superscripts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newdimen\scriptlengthtempone\newdimen\scriptlengthtemptwo

\newlength\scriptdepthtemp
\newlength\gstandard
\newlength\Astandard
\newlength\astandard
\newlength\shiftbyhand
\setlength{\shiftbyhand}{0.10em}
\DeclareRobustCommand{\@bothscript@before}[2]{%
    \def\scripttempone{#1}%
    \def\scripttemptwo{#2}%
    \settowidth{\scriptlengthtempone}{\m@th\ensuremath{{}^{\mbox{\fontsize\sf@size\z@\selectfont\scripttempone}}}}%
    \settowidth{\scriptlengthtemptwo}{\m@th\ensuremath{{}_{\mbox{\fontsize\sf@size\z@\selectfont\scripttemptwo}}}}%
    \addtolength{\scriptlengthtempone}{-\scriptlengthtemptwo}%
    {%
        \ifdim\scriptlengthtempone>0pt%
            \m@th\ensuremath{%
                {}^{%
                \mbox{%
                        \fontsize\sf@size\z@\selectfont%
                        {\scripttempone}%
                    }%
                }_{%
                    \hspace{\scriptlengthtempone}%
                    \settoheight{\Astandard}{A}\addtolength{\Astandard}{-0.1pt}%
                    \settoheight{\astandard}{a}\addtolength{\astandard}{-0.1pt}%
                    \settodepth{\gstandard}{g}\addtolength{\gstandard}{-0.1pt}%
                    \settodepth{\scriptdepthtemp}{%
                    \mbox{%
                        \fontsize\sf@size\z@\selectfont%
                        {\scripttemptwo}%
                    }}%
                \mbox{%
                        \fontsize\sf@size\z@\selectfont%
                        {\scripttemptwo}%
                    }%
                }%
            }%
        \else%
            \m@th\ensuremath{%
                {}^{%
                    \hspace{-\scriptlengthtempone}%
\mbox{%
                        \fontsize\sf@size\z@\selectfont%
                        {\scripttempone}%
                    }%
                }_{%
                    \settoheight{\Astandard}{A}\addtolength{\Astandard}{-0.1pt}%
                    \settoheight{\astandard}{a}\addtolength{\astandard}{-0.1pt}%
                    \settodepth{\gstandard}{g}\addtolength{\gstandard}{-0.1pt}%
                    \settodepth{\scriptdepthtemp}{%
                    \mbox{%
                        \fontsize\sf@size\z@\selectfont%
                        {\scripttemptwo}%
                    }}%
                    \mbox{%
                        \fontsize\sf@size\z@\selectfont%
                        {\scripttemptwo}%
                    }%
                }%
            }%
        \fi%
    }%
}

\DeclareRobustCommand{\@bothscript@after}[2]{%
    \def\scripttempone{#1}%
    \def\scripttemptwo{#2}%
        {%
        \m@th\ensuremath{%
            {}^{%
                \mbox{\fontsize\sf@size\z@\selectfont%
                {\scripttempone}%
                }%
            }_{%
                \settoheight{\Astandard}{A}\addtolength{\Astandard}{-0.1pt}%
                \settoheight{\Astandard}{a}\addtolength{\astandard}{-0.1pt}%
                \settodepth{\gstandard}{g}\addtolength{\gstandard}{-0.1pt}%
                \settodepth{\scriptdepthtemp}{%
                \mbox{\fontsize\sf@size\z@\selectfont%
                {\scripttemptwo}%
            }}%
                \mbox{\fontsize\sf@size\z@\selectfont%
                {\scripttemptwo}%
            }%
        }%
    }%
}%
}

\def\vertphantomsuper{}%
\def\vertphantomsub{}%
\DeclareRobustCommand{\superscript@@oldplain}[1]{\def\tempsuper{#1}\@bothscript@after{{\tempsuper}\vertphantomsuper}{\vertphantomsub}}
\DeclareRobustCommand{\subscript@@oldplain}[1]{\def\tempsub{#1}\@bothscript@after{\vertphantomsuper}{{\tempsub}\vertphantomsub}}
\DeclareRobustCommand{\bothscript@beforeplain}[2]{\def\tempbothscript@beforeone{#1}\def\tempbothscript@beforetwo{#2}\@bothscript@before{{\tempbothscript@beforeone}\vertphantomsuper}{{\tempbothscript@beforetwo}\vertphantomsub}}
\DeclareRobustCommand{\bothscript@afterplain}[2]{\def\tempbothscript@afterone{#1}\def\tempbothscript@aftertwo{#2}\@bothscript@after{{\tempbothscript@afterone}\vertphantomsuper}{{\tempbothscript@aftertwo}\vertphantomsub}}

\DeclareRobustCommand{\superscript@@old}[1]{\superscript@@oldplain{\text{#1}}}
\DeclareRobustCommand{\subscript@@old}[1]{\subscript@@oldplain{\text{#1}}}
\DeclareRobustCommand{\bothscript@before}[2]{\bothscript@beforeplain{\text{#1}}{\text{#2}}}
\DeclareRobustCommand{\bothscript@after}[2]{\bothscript@afterplain{\text{#1}}{\text{#2}}}

\DeclareRobustCommand{\superscript@@oldlow}[1]{{\def\tempsupery{#1}\let\vertphantom\relax{}\superscript@@oldplain{\tempsupery}}}
\DeclareRobustCommand{\subscript@@oldlow}[1]{{\def\tempsub{#1}\let\vertphantom\relax{}\@bothscript@after{\vertphantom}{\tempsub\vertphantom}}}
\DeclareRobustCommand{\bothscript@beforelow}[2]{{\def\tempbothscript@beforelowone{#1}\def\tempbothscript@beforelowtwo{#2}\let\vertphantom\relax{}\@bothscript@before{\tempbothscript@beforelowone\vertphantom}{\tempbothscript@beforelowtwo\vertphantom}}}
\DeclareRobustCommand{\bothscript@afterlow}[2]{{\def\tempbothscript@afterlowone{#1}\def\tempbothscript@afterlowtwo{#2}\let\vertphantom\relax{}\@bothscript@after{\tempbothscript@afterlowone\vertphantom}{\tempbothscript@afterlowtwo\vertphantom}}}

\DeclareRobustCommand{\superscript@@oldmath}[1]{\superscript@@oldplain{\ensuremath{#1}}}
\DeclareRobustCommand{\subscript@@oldmath}[1]{\subscript@@oldplain{\ensuremath{#1}}}
\DeclareRobustCommand{\bothscript@beforemath}[2]{\bothscript@beforeplain{\ensuremath{#1}}{\ensuremath{#2}}}
\DeclareRobustCommand{\bothscript@aftermath}[2]{\bothscript@afterplain{\ensuremath{#1}}{\ensuremath{#2}}}

\let\bothscript@after\bothscript@afterplain
\let\bothscript@before\bothscript@beforeplain

\DeclareRobustCommand{\fourindices}[5]{%
    \def\fourindicesmiddletemp{#1}%
    \def\fourindicesonetemp{#2}%
    \def\fourindicestwotemp{#3}%
    \def\fourindicesthreetemp{#4}%
    \def\fourindicesfourtemp{#5}%
\smash{\mbox{\ifmmode%
    \def\fourindicesvertphantom{\vphantom{\ensuremath{\left(\fourindicesmiddletemp\right)}}}%
    {\m@th\vphantom{\fourindicesmiddletemp}}%
\else%
    \def\fourindicesvertphantom{\vphantom{\fourindicesmiddletemp()}}%
    \vphantom{\fourindicesmiddletemp}%
\fi%
    \bothscript@before{\fourindicesvertphantom\vphantom{\fourindicesonetemp}\fourindicesfourtemp}{\fourindicesvertphantom\vphantom{\fourindicestwotemp}\fourindicesthreetemp}%
\ifmmode%
        {\m@th\ensuremath{\fourindicesmiddletemp}}%
\else%
        \fourindicesmiddletemp%
\fi%
    \bothscript@after{\fourindicesvertphantom\vphantom{\fourindicesfourtemp}\fourindicesonetemp}{\fourindicesvertphantom\vphantom{\fourindicesthreetemp}\fourindicestwotemp}%
}}}

\DeclareRobustCommand{\fourindicesmath}[5]{%
    \def\fourindicesmathmiddletemp{#1}%
    \def\fourindicesmathonetemp{#2}%
    \def\fourindicesmathtwotemp{#3}%
    \def\fourindicesmaththreetemp{#4}%
    \def\fourindicesmathfourtemp{#5}%
\fourindices{\ensuremath{\fourindicesmathmiddletemp}}{\unskip\ensuremath{\unskip\fourindicesmathonetemp}}{\unskip\ensuremath{\unskip\fourindicesmathtwotemp}}{\ensuremath{\fourindicesmaththreetemp}}{\ensuremath{\fourindicesmathfourtemp}}}


\DeclareRobustCommand{\superscript}[3][]{\fourindices{#2}{#3}{}{}{#1}}
\DeclareRobustCommand{\subscript}[3][]{\fourindices{#2}{}{#3}{#1}{}}
\DeclareRobustCommand{\doublescript}[1][]{\gdef\doublescripttempone{#1}\doublescriptrelayone}
\DeclareRobustCommand{\doublescriptrelayone}[4][]{\fourindices{#2}{#3}{#4}{#1}{\doublescripttempone}}

\DeclareRobustCommand{\superscriptmath}[3][]{\fourindicesmath{#2}{#3}{}{}{#1}}
\DeclareRobustCommand{\subscriptmath}[3][]{\fourindicesmath{#2}{}{#3}{#1}{}}
\DeclareRobustCommand{\doublescriptmath}[1][]{\gdef\doublescripttemponemath{#1}\doublescriptrelayonemath}
\DeclareRobustCommand{\doublescriptrelayonemath}[4][]{\fourindicesmath{#2}{#3}{#4}{#1}{\doublescripttemponemath}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Symbols %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\plus}{\ensuremath{\!{}+{}\!}}
\newcommand{\minus}{\ensuremath{\!{}-{}\!}}

\newcommand{\chemicalshiftsymbol}{\deltait}
\def\lambdamaxsymbol{\text{\subscript{\wavelengthsymbol}{\textup{max}}}}
\def\wavenumbersymbol{\ensuremath{\tilde{\nuit}}}
\def\wavelengthsymbol{\lambdait}
\newcommand{\specificrotation}[2][\text{\textup{D}}]{\def\specrotwavelengthtemp{#1}\def\specrottemperaturetemp{#2}\text{\textup{[\alphait]}}\bothscript@after{\specrottemperaturetemp}{\specrotwavelengthtemp}}
\let\molarextinctioncoefficient\varepsilonit

\newcommand{\couplingconstantsymbol}[1][]{\def\couplingconstantsymbolbondcounttemp{#1}\couplingconstantsymbolrelayone}
\newcommand{\couplingconstantsymbolrelayone}[1][]{\def\couplingconstantatomstemp{#1}%
\fourindices{\textit{J}}{}{\text{\ifx\couplingconstantatomstemp\@empty \else\couplingconstantatomstemp\fi}}{}{\ifx\couplingconstantsymbolbondcounttemp\@empty\else\couplingconstantsymbolbondcounttemp\fi}}

\newcommand{\retentionfactorsymbol}{\text{\subscript{R}{\textup{f}}}}
\def\halflifesymbol{\subscript{\textit{t}}{\text{\textup{1/2}}}}

\def\betaplus{\betaup\cation}
\def\eminus{\text{\textrm{e}}\anion}

\newcommand{\standard}{\superscript@@oldmath{\minuso}}

%%% Units %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is only for backwards compatibility pruposes - please use
% siunitx commands for new ones!
\def\unitspace{~}
\def\suppressunitspace#1{{\let\unitspace\relax #1}}

\def\prefixmicro{\text{\textmu}}

\let\@superscrpt\superscript
\def\unitsuperscript#1#2{{%
    \/\@superscrpt{#1}{%
        \IfBeginWith{#2}{-}%
            {\def\unitsuperscripttemp{\StrBehind{#2}{-}}\ensuremath{{-}}}%
            {\def\unitsuperscripttemp{#2}}%
        \unitsuperscripttemp%
    }\kern-0.05em%
}}

\newcommand{\newunitofmeasure}[2]{{%
\edef\newunitofmeasuretemp{#1}%
\expandafter\@ifdefinable\csname\newunitofmeasuretemp\endcsname{%
\expandafter\gdef\csname\newunitofmeasuretemp\endcsname{\unitspace\mbox{\suppressunitspace{%
\let\superscript\unitsuperscript%
\let\superscriptmath\unitsuperscript%
\text{#2}}}}}}}

% Atomic units
\newcommand{\au}{\text{a.u.}}




%%% Various abbreviations %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\invivo{\text{\textit{in vivo}}}
\def\invacuo{\text{\textit{in vacuo}}}
\def\insitu{\text{\textit{in situ}}}
%
\def\etal{\text{\textit{et al.}}}
\def\ie{\text{\textit{i.e.}}}
%
\newcommand{\masstochargeratio}{\textit{m/z}}
%
\newcommand{\R}{\superscript@@old{\textregistered}}
%


\def\operatorprime{\ensuremath{\if@usefourier\!\fi\!\superscriptmath{\vphantom{\sum\nolimits}}{\primeold}}}

%
\let\timesold\times
\def\times{\ensuremath{\timesold}}%

\let\primeold\prime
\def\prime{\superscript@@old{\ensuremath{\primeold}}}

\let\cdotold\cdot
\def\cdot{\ensuremath{\cdotold}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%% Chemical formulae and systematic names %%%%%%%%%%%%%%%%%
\def\formula#1{\mbox{#1}}

%
\newcommand{\anion}[1][]{\def\anionchargetemp{#1}{}\superscript@@old{\ifx\anionchargetemp\@empty\else\anionchargetemp\fi\ensuremath{-}}}
\newcommand{\cation}[1][]{\def\cationchargetemp{#1}{}\superscript@@old{\ifx\cationchargetemp\@empty\else\cationchargetemp\fi\ensuremath{+}}}

%%% Tables, schemes, floats and captions %%%%%%%%%%%%%%%%%%%

\renewcommand{\captionlabelfont}{\bfseries}
\renewcommand{\captionfont}{\sffamily\small\onehalfspacing}
\setlength{\captionmargin}{20pt}

\setlength{\extrarowheight}{2.8pt}
\def\tablefont{\sffamily\small}


\captionsetup{skip=5pt,position=below}%
\captionsetup[table]{skip=5pt,position=above}
\captionsetup[Table]{skip=5pt,position=above}
\captionsetup[tableold]{skip=5pt,position=above}

\newcommand{\tablefootnotetext}[2]{\tnote[{\mdseries\sffamily\upshape[#1]}]{\mdseries\sffamily\upshape#2}}%
\newcommand{\tablefootnotemark}[1]{\tmark[{\mdseries\sffamily\upshape[#1]}]}%


%%% Float placement parameters
    %All pages
    \renewcommand{\topfraction}{0.9}
    \renewcommand{\bottomfraction}{0.8}
    %Text pages
    \setcounter{topnumber}{2}
    \setcounter{bottomnumber}{2}
    \setcounter{totalnumber}{2}
    \renewcommand{\textfraction}{0.15}
    %Float pages
    \renewcommand{\floatpagefraction}{0.7}%must be less than \topfraction
    \renewcommand{\dblfloatpagefraction}{0.7}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%% Graphics and project directory structure %%%%%%%%%%%%%%%
\def\setupgraphicsandepstopdf{%
\def\pdfshellescape{1}%
\usepackage[verbose=true,outdir=./Figures/TemporaryGraphicsFiles/,prepend,update,prefersuffix=true]{epstopdf}%
\epstopdfsetup{suffix=-converted-from-\SourceExt}%
\graphicspath{{./Figures/}{./Figures/Other/}{./Figures/TemporaryGraphicsFiles/}}}%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%% Document data and date %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newdateformat{dMYdate}{\THEDAY\ \monthname[\THEMONTH] \THEYEAR}
\let\todayold\today
\def\today{\dMYdate\todayold}
%
\def\title#1{\def\@title{#1}\let\@titleofpdf\@title}
\def\subtitle#1{\def\@subtitle{#1}}
\def\author#1{\def\@author{#1}\let\@authorofpdf\@author}
\def\college#1{\def\@college{#1}}
\def\typeofdocument#1{\def\@typeofdocument{#1}}
\def\institution#1{\def\@institution{#1}}
\def\date#1{\def\datetemp{#1}\ifx\datetemp\@empty \let\@date\today \else\let\@date\datetemp \fi}%Date defaults to \today if left empty
%
\title{}% Initialise title page `variables'
\subtitle{}
\author{}
\college{}
%\typeofdocument{A Thesis Submitted for the\\Honour School of Chemistry:\\Chemistry Part II, \number\year}
\typeofdocument{}
\institution{}
\date{}
%
\def\authorofpdf#1{\def\@authorofpdf{#1}}
\def\titleofpdf#1{\def\@titleofpdf{#1}}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% References (BibLaTeX) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\addbibresource{Report-MainReferences.bib}
\addbibresource{Report-SummaryReferences.bib}
\addbibresource{Report-AppendixReferences.bib}
\defbibheading{summarybib}{}
\defbibheading{mainbib}{}
\defbibheading{appendixbib}{}

\let\bigcite\cite
\let\citeold\cite
\let\cite\supercite

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Hooks %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\AtBeginDocument{%
\renewcommand{\contentsname}{Table of Contents}
\renewcommand{\bibname}{References}
\pagestyle{headings}
}

\AtEndPreamble{%
\hypersetup{pdfauthor={\@authorofpdf},
            pdftitle={\@titleofpdf}}
\setupgraphicsandepstopdf%
%
\if@usefourier
% Credit for this fix (incorrect delimiter sizes with the fourier package) goes to user egreg on tex.stackexchange.com. URL: http://tex.stackexchange.com/questions/61023/delimiter-size-big-not-working-with-fourier-mathtools-packages-and-11pt-option
\def\resetMathstrut@{%
  \setbox\z@\hbox{%
    \mathchardef\@tempa\mathcode`\(\relax
    \def\@tempb##1"##2##3{\the\textfont"##3\char"}%
    \expandafter\@tempb\meaning\@tempa \relax
  }%
  \ht\Mathstrutbox@1.2\ht\z@ \dp\Mathstrutbox@1.2\dp\z@
}
\fi
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%%% Miscellaneous %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcounter{inlineenumi}
\newcommand{\newinlinelist}[1][\alph]{\setcounter{inlineenumi}{1}\gdef\dispinline{#1}}
\newcommand{\inlineitem}{(\dispinline{inlineenumi})\addtocounter{inlineenumi}{1}}


\DeclareSymbolFont{stmry}{U}{stmry}{m}{n}
\def\stmry@if#1#2{\let#2=\@undefined\iftrue#1#2}
\stmry@if\DeclareMathSymbol\minuso\mathbin{stmry}{"0A}\fi

\let\boldsymbolold\boldsymbol
\def\boldsymbol#1{\ensuremath{\boldsymbolold{#1}}}%


\newlength\concealandcoverlengthtemp
\newcommand{\toccontinuedfix}[2][0pt]{\settowidth{\concealandcoverlengthtemp}{#2}\addtolength{\concealandcoverlengthtemp}{#1}\llap{\textcolor{white}{\raisebox{-5pt}{\rule{\concealandcoverlengthtemp}{1.5em}}}}\llap{#2}}



\newenvironment{summarytext}{\begin{refsection}}{\end{refsection}}
\newcommand{\printsummarybibliography}{\printbibliography[section=1,heading=summarybib]}

\newenvironment{appendixtext}{\begin{refsection}}{\end{refsection}}
\newcommand{\printappendixbibliography}{\printbibliography[section=1,heading=appendixbib]}

\makeatletter
\def\@starttoc#1{%
  \begingroup
    \makeatletter
    \@input{\jobname.#1}%
    \if@freezetoc\else
    \if@filesw
      \expandafter\newwrite\csname tf@#1\endcsname
      \immediate\openout \csname tf@#1\endcsname \jobname.#1\relax
    \fi
    \fi
    \@nobreakfalse
  \endgroup}
\makeatother

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\let\mathscroldd\mathscr
\let\mathscr\mathcal
\let\mathcal\mathscroldd

\def\imaginaryunit{\ensuremath{\mathrm{i}}}
\def\diff{\ensuremath{\text{\textup{d}}\!}}
\def\diffbar{\ensuremath{\text{\textup{\dj}}\!}}
\def\euler{\ensuremath{\text{\textup{e}}}}
\def\numberpi{\piup}

\newcommand\transpose[1]{{#1}^{\Ttemp}}
\newcommand\Ttemp{{\mathpalette\raiseTtemp\intercal}}
\newcommand\raiseTtemp[2]{\raisebox{0.25ex}{$#1#2$}}

\newcommand\conjtranspose[1]{{#1}^{\dagtemp}}
\newcommand\dagtemp{{\mathpalette\raisedagtemp\dag}}
\newcommand\raisedagtemp[2]{\raisebox{0.25ex}{$#1#2$}}

\newcommand\conj[1]{{#1}^{\asttemp}}
\newcommand\asttemp{{\mathpalette\raiseasttemp\ast}}
\newcommand\raiseasttemp[2]{\raisebox{0.25ex}{$#1#2$}}

%\let\vecold\vec
%\def\vec#1{\ensuremath{\mathit{\boldsymbol{#1}}}}

\def\mat#1{\ensuremath{\mathbf{\mathrm{#1}}}}

\def\Re{\mathop{\mathrm{Re}}}
\def\Im{\mathop{\mathrm{Im}}}


% Other mathematical shorthands
\newcommand{\absln}[1]{\ensuremath{\mathrm{ln}\lvert #1 \rvert}}
\newcommand{\timestentothe}[1]{\ensuremath{\times 10^{#1}}}
\newcommand{\boltz}{\ensuremath{k_\textup{B}}}

% Styled referencing
\newcommand{\figref}[1]{\textbf{Figure \ref{fig:#1}}}
\newcommand{\equationref}[1]{\textbf{Equation \ref{eq:#1}}}
\newcommand{\tableref}[1]{\textbf{Table \ref{table:#1}}}
\newcommand{\sectionref}[1]{\textbf{Section \ref{sec:#1}}}

%% Floats
\let\figureold\figure
\let\endfigureold\endfigure
\let\schemeold\scheme
\let\endschemeold\endscheme
\let\sidewaystableold\sidewaystable
\let\endsidewaystableold\endsidewaystable

% My thanks for the ExpEnvOptiion fix goes
% to cgnieder from latex-community:
% http://www.latex-community.org/forum/viewtopic.php?f=45&t=23547
\makeatletter
    \def\ExpEnvOption#1#2[#3]{%
      \expandafter\@expenvopt\expandafter{#3}{#1}{#2}}
    \def\@expenvopt#1#2#3{#2{#3}[#1]}

\let\originput\@@input

\let\Figure\figure
\let\endFigure\endfigure
\let\figure\figureold
\let\endfigure\endfigureold

\let\Scheme\scheme
\let\endScheme\endscheme
\let\scheme\schemeold
\let\endscheme\endschemeold
