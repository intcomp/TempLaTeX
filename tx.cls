\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tx}[2025/06/12 Article with colored abstract]

\newif\iftx@zh
\DeclareOption{zh}{\tx@zhtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\LoadClass{article}

\RequirePackage[top=2.25cm, bottom=2.5cm, left=1.7cm, right=1.7cm, columnsep=0.65cm]{geometry}
\RequirePackage{xcolor}
\RequirePackage{etoolbox}
\RequirePackage{graphicx,overpic}
\RequirePackage{amsmath,amssymb}
\RequirePackage{orcidlink}

\newcommand{\tx@abstractname}{Abstract}
\newcommand{\tx@appendixname}{Appendix}
\newcommand{\tx@keywordsname}{Keywords}

% cref
\RequirePackage{cleveref}
\crefname{figure}{Figure}{Figures}
\crefname{section}{Section}{Sections}
\crefname{table}{Table}{Tables}
\crefname{equation}{Equation}{Equations}
\crefname{appendix}{Appendix}{Appendices}
\crefname{theorem}{Theorem}{Theorems}
\crefname{lemma}{Lemma}{Lemmas}
\crefname{definition}{Definition}{Definitions}
\crefname{corollary}{Corollary}{Corollaries}
\crefname{proposition}{Proposition}{Propositions}
\crefname{example}{Example}{Examples}

\iftx@zh
    \RequirePackage{fontspec}
    \RequirePackage{xeCJK}
    \setCJKmainfont[Path = fonts/,]{SimSun.ttf}
    \newCJKfontfamily\songti[Path = fonts/,]{SimSun.ttf}
    \newCJKfontfamily\kaiti[Path = fonts/,]{Kaiti.ttf}
    % 参考文献
    \renewcommand{\tx@abstractname}{摘要}
    \renewcommand{\tx@appendixname}{附录}
    \renewcommand{\tx@keywordsname}{关键词}
    % xxxname
    \renewcommand{\tablename}{表}
    \renewcommand{\refname}{参考文献}
    \renewcommand{\figurename}{图}
    % cref
    \crefname{figure}{图}{图}
    \crefname{section}{章}{章}
    \crefname{table}{表}{表}
    \crefname{equation}{公式}{公式}
    \crefname{appendix}{附录}{附录}
    \crefname{theorem}{Theorem}{Theorems}
    \crefname{lemma}{Lemma}{Lemmas}
    \crefname{definition}{定义}{定义}
    \crefname{corollary}{Corollary}{Corollaries}
    \crefname{proposition}{Proposition}{Propositions}
    \crefname{example}{例}{例}
\fi

% hyper links
\RequirePackage{hyperref}
\hypersetup{
  colorlinks=true,
  linkcolor=blue,
  citecolor=blue,
  urlcolor=blue,
}


\RequirePackage[most]{tcolorbox}
\usetikzlibrary{calc,shadows.blur}
\tcbuselibrary{skins}
\definecolor{absbg}{HTML}{F1F4F7}
\definecolor{absshadow}{HTML}{B8BABD}
\tcbset{
    abstractbox/.style={
        enhanced jigsaw,
        colback=absbg,%
        colframe=gray!80!black,
        size=small,
        boxrule=1pt,
        title=\textbf{\textit{\tx@abstractname}},
        halign title=flush center,
        coltitle=black,
        breakable,
        fuzzy shadow={2mm}{-2mm}{2pt}{1pt}{absshadow},
        attach boxed title to top left={xshift=1cm,yshift=-\tcboxedtitleheight/2,yshifttext=-\tcboxedtitleheight/2},
        minipage boxed title=3cm,
        boxed title style={%
            colback=white,
            size=fbox,
            boxrule=1pt,
            boxsep=2pt,
            underlay={%
                \coordinate (dotA) at ($(interior.west) + (-0.5pt,0)$);
                \coordinate (dotB) at ($(interior.east) + (0.5pt,0)$);
                \begin{scope}[gray!80!black]
                    \fill (dotA) circle (2pt);
                    \fill (dotB) circle (2pt);
                \end{scope}
            },
        },
    }
}


\newcommand{\authors}{} % define empty default
\newcommand{\affiliations}{} % define empty default
\newcommand{\emails}{}

\renewcommand{\author}[1]{\gdef\authors{#1}\gdef\@author{#1}} % also set \@author for \thanks support
\newcommand{\affiliation}[1]{\gdef\affiliations{#1}}
\newcommand{\email}[1]{\gdef\emails{#1}}

\newcommand{\authorformat}{\large}


% keywords capture
\newcommand\tx@keywords{}
\newenvironment{keywords}{\Collect@Body\tx@savekeys}{}
\newcommand\tx@savekeys[1]{\gdef\tx@keywords{#1}}


% section title formatting
\RequirePackage{titlesec}
\titleformat*{\section}{\Large\sffamily\bfseries}
\titleformat*{\subsection}{\large\sffamily\bfseries}
\titleformat*{\subsubsection}{\normalsize\sffamily\bfseries}
\titleformat*{\paragraph}{\itshape}




\let\oldappendix\appendix
\renewcommand{\appendix}{%
  \oldappendix
  \vspace{1em}
  \begin{center}
    {\Huge\sffamily\bfseries \tx@appendixname}
  \end{center}
  \vspace{1em}
  \addcontentsline{toc}{section}{\tx@appendixname}
}

\RequirePackage{marvosym}
\newcommand{\cor}{$^{\text{\Letter}}$}

\newcommand{\eg}{\textit{e.g.} }
\newcommand{\ie}{\textit{i.e.} }
\newcommand{\etc}{\textit{etc.} }
\newcommand{\etal}{\textit{et al.} }

% --- Capture abstract text so \maketitle can print it full-width ---
\newcommand\tx@abstract{}
\renewenvironment{abstract}{\Collect@Body\tx@saveabs}{}
\newcommand\tx@saveabs[1]{\gdef\tx@abstract{#1}}


\makeatletter
\newcommand{\tx@titleblock}{%
  \begingroup
  \setlength{\parindent}{0pt}%
  \begin{center}
    {\LARGE\bfseries \@title\par}\vspace{1.6em}
    {\authorformat \authors\par}\vspace{1em}
    \ifx\affiliations\@empty\else{\normalsize\affiliations\par}\vspace{0.4em}\fi
    \ifx\emails\@empty\else{\normalsize\texttt\emails\par}\fi
  \end{center}
  \ifx\tx@abstract\@empty\else
    \vspace{0.5em}
    \begin{tcolorbox}[abstractbox]
      \small \tx@abstract\par\normalsize
    \end{tcolorbox}
  \fi
  \ifx\tx@keywords\@empty\else
  \vspace{0.125em}  
  {\small\textbf{\tx@keywordsname}: \tx@keywords\par}
    \vspace{1.5em}
  \fi
  \endgroup
}

\renewcommand{\maketitle}{%
  \twocolumn[{%
    \begin{@twocolumnfalse}
      \tx@titleblock
    \end{@twocolumnfalse}
  }]%
  \thispagestyle{empty}% optional: hide page number on page 1
  \sloppy
}
\makeatother
