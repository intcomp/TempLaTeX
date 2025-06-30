\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{kaiart}[2025/06/12 Article with colored abstract]

\LoadClass{article}

\RequirePackage[top=2.25cm, bottom=2.5cm, left=2.5cm, right=2.5cm, columnsep=0.65cm]{geometry}
\RequirePackage{xcolor}
\definecolor{absbg}{HTML}{F1F4F7}

\RequirePackage{graphicx}
\RequirePackage{overpic}
\RequirePackage{amsmath}
\RequirePackage{amssymb}


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
\renewenvironment{abstract}{
  \begin{tcolorbox}[
    colback=absbg,
    colframe=white,
    boxrule=0pt,
    arc=6pt,
    left=6pt,
    right=6pt,
    top=6pt,
    bottom=6pt
  ]
  \noindent\textbf{Abstract.}
}{
  \end{tcolorbox}
}


\newcommand{\authors}{} % define empty default
\newcommand{\affiliations}{} % define empty default
\newcommand{\emails}{}

\renewcommand{\author}[1]{\def\authors{#1}} % use \def to assign contents
\newcommand{\affiliation}[1]{\def\affiliations{#1}} % same here
\newcommand{\email}[1]{\def\emails{#1}}

\newcommand{\authorformat}{\large \ttfamily \bfseries}

\renewcommand{\maketitle}{
  \begin{center}
    {\linespread{1} \LARGE \bfseries \@title \par}
    \vspace{1.2em}
    {\authorformat \authors \par}
    \vspace{0.6em}
    {\normalsize \affiliations \par}
    \vspace{0.6em}
    {\normalsize \emails \par}
    \vspace{1.2em}
  \end{center}
}

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