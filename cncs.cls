\ProvidesClass{cncs}[2026/01/01 v1.2 CNCS Document Class]

% 1. Option Processing
\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=cncs, prefix=cncs@}
\DeclareStringOption[blue]{theme}
\DeclareBoolOption[true]{thai}
\DeclareBoolOption[false]{twoside}
\DeclareBoolOption[true]{codenumbers}
\ProcessKeyvalOptions*

% Load Base Class
\LoadClass[10pt, a4paper]{extarticle}

% 2. Geometry & Page Layout
\RequirePackage[margin=2cm, top=1.0cm, bottom=1.5cm]{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{graphicx}
\RequirePackage{xcolor}

% 3. Global Variables
\def\subject#1{\gdef\@subject{#1}}
\def\semester#1{\gdef\@semester{#1}}
\def\academicyear#1{\gdef\@academicyear{#1}}
\def\school#1{\gdef\@school{#1}}

% Defaults
\subject{วิทยาการคำนวณ}
\semester{1}
\academicyear{2569}
\school{โรงเรียนชลกันยานุกูล}

% 4. Load CNCS Modules
\RequirePackage{cncs-colors}
\RequirePackage{cncs-boxes}

% 4b. Thai font loading (bound to the `thai` option; previously declared but never used)
\ifcncs@thai
  \RequirePackage{fontspec}
  \newif\ifcncs@fontfound \cncs@fontfoundfalse
  \IfFontExistsTF{TH Sarabun New}
    {\setmainfont{TH Sarabun New}\cncs@fontfoundtrue}
    {\IfFontExistsTF{Loma}
      {\setmainfont{Loma}\cncs@fontfoundtrue}
      {\IfFontExistsTF{Noto Sans Thai}
        {\setmainfont{Noto Sans Thai}\cncs@fontfoundtrue}
        {}
      }
    }
  \ifcncs@fontfound\else
    \ClassWarning{cncs}{No Thai font found (tried TH Sarabun New, Loma, Noto Sans Thai). Thai glyphs will not render. Install one of these fonts.}
  \fi
\fi

% 5. Header / Footer Setup
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0.5pt}

\lfoot{\small \@subject \quad ภาคเรียนที่ \@semester \quad ปีการศึกษา \@academicyear \quad \@school}
\rfoot{\small หน้า \thepage}

% 6. Basic Commands
% \worksheet prints the colored title (no rule here — the rule belongs after \studentinfo,
% matching the original document's visual order: title -> student info -> rule -> content)
\newcommand{\worksheet}[1]{%
  \begin{center}
    {\Large \bfseries \color{cncsprimary} #1}
  \end{center}
  \vspace{0.5em}
}

\newcommand{\studentinfo}{%
  \noindent
  \begin{tabular}{@{}p{0.55\textwidth} p{0.25\textwidth} p{0.15\textwidth}@{}}
    \textbf{ชื่อ-สกุล:} \dotfill & \textbf{ห้อง:} \dotfill & \textbf{เลขที่:} \dotfill
  \end{tabular}
  \vspace{0.5em}
  \par\noindent\hrule
  \vspace{1em}
}

\newcommand{\activitysection}[1]{%
  \vspace{1em}\noindent{\large \bfseries \color{cncsprimary} #1}\par\vspace{0.5em}
}
