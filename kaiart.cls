\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{kaiart}[2025/06/12 Article with colored abstract]

\LoadClass{article}

\RequirePackage[top=2.25cm, bottom=2.5cm, left=2.5cm, right=2.5cm, columnsep=0.65cm]{geometry}
\RequirePackage{xcolor}
\RequirePackage{etoolbox}
\RequirePackage{graphicx,overpic}
\RequirePackage{amsmath,amssymb}
\RequirePackage{orcidlink}

% hyper links
\RequirePackage{hyperref}
\hypersetup{
  colorlinks=true,
  linkcolor=blue,
  citecolor=blue,
  urlcolor=blue,
}

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
        title=\textbf{\textit{Abstract}},
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

\newcommand{\authorformat}{\large \ttfamily \bfseries}


% keywords capture
\newcommand\kai@keywords{}
\newenvironment{keywords}{\Collect@Body\kai@savekeys}{}
\newcommand\kai@savekeys[1]{\gdef\kai@keywords{#1}}


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
    {\Huge\sffamily\bfseries Appendix}
  \end{center}
  \vspace{1em}
  \addcontentsline{toc}{section}{Appendix}
}

\RequirePackage{marvosym}
\newcommand{\cor}{$^{\text{\Letter}}$}

\newcommand{\eg}{\textit{e.g.} }
\newcommand{\ie}{\textit{i.e.} }
\newcommand{\etc}{\textit{etc.} }
\newcommand{\etal}{\textit{et al.} }

% --- Capture abstract text so \maketitle can print it full-width ---
\newcommand\kai@abstract{}
\renewenvironment{abstract}{\Collect@Body\kai@saveabs}{}
\newcommand\kai@saveabs[1]{\gdef\kai@abstract{#1}}


\makeatletter
\newcommand{\kai@titleblock}{%
  \begingroup
  \setlength{\parindent}{0pt}%
  \begin{center}
    {\LARGE\bfseries \@title\par}\vspace{1.6em}
    {\authorformat \authors\par}\vspace{0.4em}
    \ifx\affiliations\@empty\else{\normalsize\affiliations\par}\vspace{0.2em}\fi
    \ifx\emails\@empty\else{\normalsize\texttt\emails\par}\fi
  \end{center}
  \ifx\kai@abstract\@empty\else
    \vspace{0.5em}
    \begin{tcolorbox}[abstractbox]
      \small \kai@abstract\par\normalsize
    \end{tcolorbox}
  \fi
  \ifx\kai@keywords\@empty\else
  \vspace{0.125em}  
  {\small\textbf{Keywords:} \kai@keywords\par}
    \vspace{1.5em}
  \fi
  \endgroup
}

\renewcommand{\maketitle}{%
  \twocolumn[{%
    \begin{@twocolumnfalse}
      \kai@titleblock
    \end{@twocolumnfalse}
  }]%
  \thispagestyle{empty}% optional: hide page number on page 1
}
\makeatother
