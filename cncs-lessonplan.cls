\ProvidesClass{cncs-lessonplan}[2026/07/23 v0.1 CNCS Lesson Plan Class]

% ---------------------------------------------------------------------------
% Official "แผนการจัดการเรียนรู้" form (โรงเรียนชลกันยานุกูล). Plain formal
% layout — no theme colors on boxes, matches the school's paper form.
% Loads cncs-components.sty so \Warmup / \Activity / \Reflection (section
% 11.1/11.2/11.3) can be reused verbatim from the same .tex files used in
% worksheets — this class just flips \cncs@planmodetrue so they render as
% plain numbered paragraphs instead of colored boxes. See cncs-components.sty
% for the switch itself.
% ---------------------------------------------------------------------------

\LoadClass[10pt, a4paper]{extarticle}

\RequirePackage[margin=2cm, top=1.5cm, bottom=1.5cm]{geometry}
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{etoolbox}
\RequirePackage{array}
\RequirePackage{tabularx}

% Thai font (same fallback chain as cncs.cls: TH Sarabun New -> Loma -> Noto
% Sans Thai). Duplicated here rather than factored out, since cncs.cls itself
% is left untouched.
\XeTeXlinebreaklocale "th"
\XeTeXlinebreakskip = 0pt plus 1pt
\RequirePackage{fontspec}
\newif\ifcncslp@fontfound \cncslp@fontfoundfalse
\IfFontExistsTF{TH Sarabun New}
  {\setmainfont{TH Sarabun New}\cncslp@fontfoundtrue}
  {\IfFontExistsTF{Loma}
    {\setmainfont{Loma}\cncslp@fontfoundtrue}
    {\IfFontExistsTF{Noto Sans Thai}
      {\setmainfont{Noto Sans Thai}\cncslp@fontfoundtrue}
      {}
    }
  }
\ifcncslp@fontfound\else
  \ClassWarning{cncs-lessonplan}{No Thai font found (tried TH Sarabun New, Loma, Noto Sans Thai). Thai glyphs will not render.}
\fi

\RequirePackage{cncs-colors}
\RequirePackage{cncs-components}
\cncs@planmodetrue

% ---------------------------------------------------------------------------
% 0. Header fields — set these before \begin{document}, then call
%    \LessonPlanHeader right after \begin{document} to print them (same
%    explicit-call pattern as \worksheet{} + \studentinfo in cncs.cls).
% ---------------------------------------------------------------------------
\def\cncslp@school{โรงเรียนชลกันยานุกูล สำนักงานเขตพื้นที่การศึกษามัธยมศึกษาชลบุรี ระยอง}
\newcommand{\School}[1]{\gdef\cncslp@school{#1}}

\newcommand{\LessonPlanNo}[1]{\gdef\cncslp@planno{#1}}
\newcommand{\LearningArea}[1]{\gdef\cncslp@area{#1}}
\newcommand{\Subject}[1]{\gdef\cncslp@subject{#1}}
\newcommand{\SubjectCode}[1]{\gdef\cncslp@subjectcode{#1}}
\newcommand{\UnitNo}[1]{\gdef\cncslp@unitno{#1}}
\newcommand{\UnitName}[1]{\gdef\cncslp@unitname{#1}}
\newcommand{\Topic}[1]{\gdef\cncslp@topic{#1}}
\newcommand{\Grade}[1]{\gdef\cncslp@grade{#1}}
\newcommand{\Term}[1]{\gdef\cncslp@term{#1}}
\newcommand{\AcademicYear}[1]{\gdef\cncslp@academicyear{#1}}
\newcommand{\Periods}[1]{\gdef\cncslp@periods{#1}}
\newcommand{\Teacher}[1]{\gdef\cncslp@teacher{#1}}

\let\cncslp@planno\@empty     \let\cncslp@area\@empty
\let\cncslp@subject\@empty    \let\cncslp@subjectcode\@empty
\let\cncslp@unitno\@empty     \let\cncslp@unitname\@empty
\let\cncslp@topic\@empty      \let\cncslp@grade\@empty
\let\cncslp@term\@empty       \let\cncslp@academicyear\@empty
\let\cncslp@periods\@empty    \let\cncslp@teacher\@empty

\newcommand{\LessonPlanHeader}{%
  \begin{center}
    {\large\bfseries แผนการจัดการเรียนรู้ที่ \cncslp@planno}
  \end{center}
  \noindent กลุ่มสาระการเรียนรู้ \cncslp@area \quad
            รายวิชา \cncslp@subject \quad
            รหัสวิชา \cncslp@subjectcode \par
  \noindent หน่วยการเรียนรู้ที่ \cncslp@unitno \quad
            เรื่อง \cncslp@unitname
            \ifx\cncslp@topic\@empty\else\ (\cncslp@topic)\fi \par
  \noindent ชั้นมัธยมศึกษาปีที่ \cncslp@grade \quad
            ภาคเรียนที่ \cncslp@term \quad
            ปีการศึกษา \cncslp@academicyear \quad
            จำนวน \cncslp@periods\ คาบ \par
  \noindent ครูผู้สอน \cncslp@teacher \quad \cncslp@school \par
  \vspace{0.3em}\noindent\hrule\vspace{0.6em}
}

% ---------------------------------------------------------------------------
% 1-4, 7, 10, 12-13 — plain numbered long-text sections
% ---------------------------------------------------------------------------
\newcommand{\cncslp@section}[2]{%
  \par\vspace{0.7em}\noindent{\bfseries #1}\par\vspace{0.2em}\noindent#2\par
}

\newcommand{\Standards}[1]{\cncslp@section{1. มาตรฐานการเรียนรู้}{#1}}

\newcommand{\Indicators}[2][final]{%
  \ifstrequal{#1}{between}
    {\cncslp@section{2.1 ตัวชี้วัดระหว่างทาง}{#2}}
    {\cncslp@section{2.2 ตัวชี้วัดปลายทาง}{#2}}
}

\newcommand{\KeyConcept}[1]{\cncslp@section{3. สาระสำคัญ}{#1}}

\newcommand{\LearningObjective}[2]{%
  \ifstrequal{#1}{K}{\cncslp@section{4.1 ความรู้ (Knowledge : K)}{#2}}{}%
  \ifstrequal{#1}{P}{\cncslp@section{4.2 ด้านทักษะ/กระบวนการ (Process : P)}{#2}}{}%
  \ifstrequal{#1}{A}{\cncslp@section{4.3 ด้านเจตคติ (Attitude : A)}{#2}}{}%
}

\newcommand{\Content}[1]{\cncslp@section{7. สาระการเรียนรู้}{#1}}
\newcommand{\Task}[1]{\cncslp@section{10. ชิ้นงานหรือภาระงาน}{#1}}
\newcommand{\Media}[1]{\cncslp@section{12. สื่อการสอน}{#1}}
\newcommand{\LearningSource}[1]{\cncslp@section{13. แหล่งเรียนรู้ในหรือนอกสถานที่}{#1}}

% ---------------------------------------------------------------------------
% 5, 6, 8, 9 — fixed checklists, selected by short English keyword, e.g.
%   \Competencies{communication, thinking}
% Items render in the form's original order; selected ones get [x], the
% rest [ ]. Unrecognized keywords are ignored silently (typo-safety was
% judged less important than not crashing a teacher's document — revisit
% if that turns out to be the wrong call).
% ---------------------------------------------------------------------------
\RequirePackage{xstring}
\newcommand{\cncslp@inlist}[4]{%
  % #1 = needle (keyword), #2 = raw comma list from user (may have spaces),
  % #3 = true-branch, #4 = false-branch
  \StrSubstitute{,#2,}{ }{}[\cncslp@cleanlist]%
  \IfSubStr{\cncslp@cleanlist}{,#1,}{#3}{#4}%
}
\newcommand{\cncslp@item}[3]{%
  % #1 = keyword, #2 = selected list, #3 = Thai label
  \cncslp@inlist{#1}{#2}{[x]}{[\ ]}\ #3\par
}

\newcommand{\Competencies}[1]{%
  \par\vspace{0.7em}\noindent{\bfseries 5. สมรรถนะสำคัญของผู้เรียน}\par\vspace{0.2em}
  \cncslp@item{communication}{#1}{ความสามารถในการสื่อสาร}
  \cncslp@item{thinking}{#1}{ความสามารถในการคิด}
  \cncslp@item{problemsolving}{#1}{ความสามารถในการแก้ปัญหา}
  \cncslp@item{life}{#1}{ความสามารถในการใช้ทักษะชีวิต}
  \cncslp@item{technology}{#1}{ความสามารถในการใช้เทคโนโลยี}
}

\newcommand{\Characteristics}[1]{%
  \par\vspace{0.7em}\noindent{\bfseries 6. คุณลักษณะอันพึงประสงค์}\par\vspace{0.2em}
  \cncslp@item{patriotic}{#1}{รักชาติ ศาสน์ กษัตริย์}
  \cncslp@item{honest}{#1}{ซื่อสัตย์สุจริต}
  \cncslp@item{disciplined}{#1}{มีวินัย}
  \cncslp@item{eager}{#1}{ใฝ่เรียนรู้}
  \cncslp@item{sufficiency}{#1}{อยู่อย่างพอเพียง}
  \cncslp@item{diligent}{#1}{มุ่งมั่นในการทำงาน}
  \cncslp@item{thai}{#1}{รักความเป็นไทย}
  \cncslp@item{public}{#1}{มีจิตสาธารณะ}
}

\newcommand{\CenturySkills}[1]{%
  \par\vspace{0.7em}\noindent{\bfseries 8. จุดเน้นสู่การพัฒนาคุณภาพผู้เรียน (3R x 8C)}\par\vspace{0.2em}
  \cncslp@item{reading}{#1}{Reading (สามารถอ่านออก)}
  \cncslp@item{writing}{#1}{(W)Riting (สามารถเขียนได้)}
  \cncslp@item{arithmetic}{#1}{(A)Rithmetic (มีทักษะในการคำนวณ)}
  \cncslp@item{criticalthinking}{#1}{Critical thinking and problem solving}
  \cncslp@item{creativity}{#1}{Creativity and innovation}
  \cncslp@item{crosscultural}{#1}{Cross-cultural understanding}
  \cncslp@item{collaboration}{#1}{Collaboration teamwork and leadership}
  \cncslp@item{commmedia}{#1}{Communication information and media literacy}
  \cncslp@item{computing}{#1}{Computing and IT literacy}
  \cncslp@item{career}{#1}{Career and learning skills}
  \cncslp@item{compassion}{#1}{Compassion}
}

\newcommand{\EECIndustries}[1]{%
  \par\vspace{0.7em}\noindent{\bfseries 9. การบูรณาการ 12 อุตสาหกรรมเป้าหมายของเขตพัฒนาพิเศษภาคตะวันออก (EEC)}\par\vspace{0.2em}
  \cncslp@item{automotive}{#1}{อุตสาหกรรมยานยนต์สมัยใหม่ (Next-Generation Automotive)}
  \cncslp@item{electronics}{#1}{อุตสาหกรรมอิเล็กทรอนิกส์อัจฉริยะ (Smart Electronics)}
  \cncslp@item{agriculture}{#1}{อุตสาหกรรมการเกษตรและเทคโนโลยีชีวภาพ (Agriculture and Biotechnology)}
  \cncslp@item{food}{#1}{อุตสาหกรรมการแปรรูปอาหาร (Food for the Future)}
  \cncslp@item{tourism}{#1}{อุตสาหกรรมการท่องเที่ยวกลุ่มรายได้ดีและท่องเที่ยวเชิงสุขภาพ}
  \cncslp@item{robotics}{#1}{อุตสาหกรรมหุ่นยนต์ (Robotics)}
  \cncslp@item{aviation}{#1}{อุตสาหกรรมการบินและโลจิสติกส์ (Aviation and Logistics)}
  \cncslp@item{medical}{#1}{อุตสาหกรรมการแพทย์ครบวงจร (Medical Hub)}
  \cncslp@item{biofuel}{#1}{อุตสาหกรรมเชื้อเพลิงชีวภาพและเคมีชีวภาพ (Biofuels and Biochemicals)}
  \cncslp@item{digital}{#1}{อุตสาหกรรมดิจิทัล (Digital)}
  \cncslp@item{defense}{#1}{อุตสาหกรรมป้องกันประเทศ (National Defense)}
  \cncslp@item{education}{#1}{อุตสาหกรรมพัฒนาบุคลากรและการศึกษา (Workforce Development and Education)}
}

% ---------------------------------------------------------------------------
% 14. การวัดและประเมินผล — one row per category. Not a merged-cell replica of
% the original (that would need multirow gymnastics for little real benefit)
% — one row per K/P/A/Competency/Character, "สิ่งที่ต้องวัด" cell holds a
% comma-separated list rendered as a compact enumeration.
%   \AssessmentRow{K}{ตอบคำถามถูกต้อง}{ใบงาน}{ตรวจให้คะแนนตามเกณฑ์}
% ---------------------------------------------------------------------------
\newcommand{\cncslp@asmtable@started}{false}
\newenvironment{AssessmentTable}{%
  \par\vspace{0.7em}\noindent{\bfseries 14. การวัดและประเมินผล}\par\vspace{0.4em}
  \small
  \begin{tabular}{@{}>{\raggedright\arraybackslash}p{2.6cm} >{\raggedright\arraybackslash}p{5.4cm} >{\raggedright\arraybackslash}p{2.6cm} >{\raggedright\arraybackslash}p{2.8cm}@{}}
    \toprule
    \textbf{สิ่งที่ต้องวัด} & \textbf{วิธีการวัด} & \textbf{เครื่องมือ} & \textbf{เกณฑ์การประเมิน} \\
    \midrule
}{%
    \bottomrule
  \end{tabular}
}
\newcommand{\AssessmentRow}[5]{%
  % #1 = K/P/A/Competency/Character, #2 = สิ่งที่วัด, #3 = วิธีวัด, #4 = เครื่องมือ, #5 = เกณฑ์
  \cncslp@asmlabel{#1} & #3 & #4 & #5 \\
  \multicolumn{4}{@{}p{\dimexpr\textwidth-6\tabcolsep\relax}@{}}{\footnotesize\quad #2} \\
}
\newcommand{\cncslp@asmlabel}[1]{%
  \ifstrequal{#1}{K}{ความรู้ (K)}{}%
  \ifstrequal{#1}{P}{ทักษะ/กระบวนการ (P)}{}%
  \ifstrequal{#1}{A}{เจตคติ (A)}{}%
  \ifstrequal{#1}{Competency}{สมรรถนะสำคัญ}{}%
  \ifstrequal{#1}{Character}{คุณลักษณะอันพึงประสงค์}{}%
}
\RequirePackage{booktabs}

% ---------------------------------------------------------------------------
% 15-18 + signature block — filled by hand AFTER the lesson is taught, so
% these are not content macros: \LessonPlanFooter just prints the blank
% headed sections and signature lines, matching the paper form.
% ---------------------------------------------------------------------------
\newcommand{\cncslp@blank}[1]{%
  \par\vspace{0.7em}\noindent{\bfseries #1}\par
  \vspace{1.4em}\noindent\hrulefill\par
  \vspace{1.4em}\noindent\hrulefill\par
}
\newcommand{\LessonPlanFooter}{%
  \cncslp@blank{15. บันทึกผลหลังการสอน}
  \cncslp@blank{15.1 ด้านความรู้}
  \cncslp@blank{15.2 ด้านทักษะ/กระบวนการ}
  \cncslp@blank{15.3 ด้านเจตคติ}
  \cncslp@blank{16. กิจกรรมเสนอแนะ}
  \cncslp@blank{17. ปัญหา/อุปสรรค}
  \cncslp@blank{18. ข้อเสนอแนะและแนวทางแก้ไข}
  \vspace{2em}
  \noindent
  \begin{minipage}{0.48\textwidth}
    \centering
    ลงชื่อ .......................................... ผู้สอน\\
    (..........................................)\\
    ตำแหน่ง ........... วิทยฐานะ ...........\\
    วันที่ ......... เดือน .......... พ.ศ. ..........
  \end{minipage}
  \hfill
  \begin{minipage}{0.48\textwidth}
    \centering
    ความเห็นของหัวหน้ากลุ่มสาระการเรียนรู้\\[0.5em]
    \hrulefill\\[0.3em]
    \hrulefill\\[1em]
    ลงชื่อ .......................................... \\
    (..........................................)\\
    วันที่ ......... เดือน .......... พ.ศ. ..........
  \end{minipage}
}
