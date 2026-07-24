# คู่มือการใช้งาน CNCS Document Class

คลาส LaTeX สำหรับสร้างใบกิจกรรมวิชาคอมพิวเตอร์ โรงเรียนชลกันยานุกูล
ประกอบด้วย 4 ไฟล์: `cncs.cls`, `cncs-colors.sty`, `cncs-boxes.sty`, `cncs-computing.sty`

---

## 1. สิ่งที่ต้องมีก่อนใช้งาน

1. **ตัวคอมไพล์**: ต้องใช้ **XeLaTeX** เท่านั้น (ห้ามใช้ pdfLaTeX เพราะจัดการฟอนต์ไทยไม่ได้)
2. **ฟอนต์ไทย**: คลาสจะค้นหาฟอนต์ตามลำดับนี้อัตโนมัติ
   1. `TH Sarabun New` (แนะนำ — ดาวน์โหลดฟรีจาก [SIPA](https://www.f0nt.com/release/th-sarabun-new/))
   2. `Loma` (มากับ TeX Live อยู่แล้วในบาง distro)
   3. `Noto Sans Thai`

   ถ้าไม่พบฟอนต์ทั้ง 3 ตัวเลย เอกสารจะคอมไพล์ผ่าน แต่**ตัวอักษรไทยจะไม่ขึ้น** และจะมีคำเตือนในหน้าต่าง log ว่า `No Thai font found...` — ให้ติดตั้งฟอนต์ใดฟอนต์หนึ่งในเครื่องก่อน
3. ไฟล์ทั้ง 5 ไฟล์ (4 ไฟล์คลาส + `worksheet.tex`) ต้องอยู่**โฟลเดอร์เดียวกัน**

---

## 2. เริ่มต้นใช้งาน

```latex
\documentclass[theme=blue, thai]{cncs}
\RequirePackage{cncs-computing}   % ใส่บรรทัดนี้ถ้าต้องการใช้โค้ด/ตารางตัวแปร

\subject{การโปรแกรม 2}
\semester{2}
\academicyear{2568}
\school{โรงเรียนชลกันยานุกูล}

\begin{document}

\worksheet{ใบกิจกรรม}   % ต้องมาก่อน \studentinfo เสมอ
\studentinfo

\activitysection{ตอนที่ 1: ...}
...

\end{document}
```

คอมไพล์ด้วยคำสั่ง:
```
xelatex worksheet.tex
```

> ⚠️ **สำคัญ**: ต้องเรียก `\worksheet{...}` **ก่อน** `\studentinfo` เสมอ เพราะเส้นคั่น (`\hrule`)
> ถูกฝังอยู่ท้ายคำสั่ง `\studentinfo` — ถ้าสลับลำดับ หน้าตาเอกสารจะผิดเพี้ยน

---

## 3. Options ของคลาส

ใส่ใน `\documentclass[...]{cncs}`

| Option | ค่าที่รับได้ | ค่าเริ่มต้น | ความหมาย |
|---|---|---|---|
| `theme` | `blue`, `green`, `red`, `purple`, `orange` | `blue` | สีธีมของหัวข้อ/กรอบ/พื้นหลัง |
| `thai` | `true`, `false` | `true` | เปิด/ปิดการโหลดฟอนต์ไทยอัตโนมัติ |
| `twoside` | `true`, `false` | `false` | ประกาศไว้ในโครงสร้าง แต่ยังไม่มีผลต่อ layout จริง (ดูหัวข้อ 7) |

ถ้าใส่ชื่อ `theme` ผิด (เช่น `theme=pink`) คลาสจะ fallback เป็น `blue` ให้อัตโนมัติ พร้อมคำเตือนใน log

**ตัวอย่าง:**
```latex
\documentclass[theme=purple, thai]{cncs}
```

---

## 4. คำสั่งตั้งค่าข้อมูลเอกสาร

ใส่ก่อน `\begin{document}` เพื่อเปลี่ยนข้อความใน footer

```latex
\subject{ชื่อวิชา}
\semester{ภาคเรียนที่}
\academicyear{ปีการศึกษา}
\school{ชื่อโรงเรียน}
```

ถ้าไม่ประกาศ จะใช้ค่าเริ่มต้น: วิชา "วิทยาการคำนวณ", ภาคเรียน 1, ปีการศึกษา 2569, โรงเรียนชลกันยานุกูล

---

## 5. คำสั่งจัดโครงสร้างเอกสาร

| คำสั่ง | หน้าที่ |
|---|---|
| `\worksheet{หัวข้อ}` | พิมพ์ชื่อใบกิจกรรมตัวใหญ่ กึ่งกลาง สีธีม (เรียกก่อน `\studentinfo` เสมอ) |
| `\studentinfo` | พิมพ์แถว ชื่อ-สกุล / ห้อง / เลขที่ พร้อมเส้นคั่นท้ายแถว |
| `\activitysection{หัวข้อย่อย}` | หัวข้อตอน เช่น "ตอนที่ 1: ..." ตัวหนา สีธีม |

---

## 6. คำสั่งจาก `cncs-boxes.sty` (โหลดมาให้อัตโนมัติ)

| คำสั่ง | หน้าที่ |
|---|---|
| `\begin{instruction}[หัวข้อ] ... \end{instruction}` | กล่องคำชี้แจง มีกรอบสีธีม (ไม่ใส่ `[หัวข้อ]` จะขึ้น "คำชี้แจง" อัตโนมัติ) |
| `\drawingbox[ป้ายกำกับ]{ความสูง}` | กล่องเส้นประเปล่า ๆ สำหรับให้นักเรียนวาดภาพ/ผังงาน เช่น `\drawingbox[วาด Flowchart]{6cm}` |
| `\answerline` | เส้นประให้ตอบ 1 บรรทัด |
| `\answerlines{n}` | เส้นประให้ตอบ n บรรทัด เช่น `\answerlines{4}` |

---

## 7. คำสั่งจาก `cncs-computing.sty` (ต้องเรียก `\RequirePackage{cncs-computing}` เอง)

### บล็อกโค้ด
```latex
\begin{cncscode}[C]
#include <stdio.h>
int main(void) { return 0; }
\end{cncscode}
```
เปลี่ยน `[C]` เป็น `[Python]`, `[Java]` ฯลฯ ได้ตามภาษาที่ `listings` รองรับ ถ้าไม่ใส่ `[...]` จะ default เป็น C

> ⚠️ **ข้อจำกัดที่ควรรู้**: ฟอนต์ในบล็อกโค้ดใช้ฟอนต์ไทยตัวเดียวกับเนื้อหาปกติ (ไม่ใช่ monospace แท้)
> เพื่อให้คอมเมนต์ภาษาไทยในโค้ด (เช่น `# เขียนสูตรตรงนี้`) แสดงผลได้โดยไม่พัง — แลกกับที่
> ตัวอักษรโค้ดจะไม่เรียงตัวชิดตารางแบบ monospace เหมือนโค้ดทั่วไป

### ตารางตัวแปร
```latex
\begin{vartable}
    i & 0 \\ \hline
    i & 1 \\ 
\end{vartable}
```
หัวตารางคือ "ชื่อตัวแปร" / "ค่า" มาให้อัตโนมัติ

### ตาราง Trace
```latex
\begin{tracetable}{5}   % {5} คือจำนวนคอลัมน์ตัวแปร
Step & i & sum & ... \\ \hline
1 & 0 & 0 & ... \\
\end{tracetable}
```

### ตารางแปลงเลขฐานสอง
```latex
\binarytable
```
ได้ตารางค่าน้ำหนักบิต 128-64-32-16-8-4-2-1 พร้อมช่องว่างให้กรอก

### กล่องแสดงหน่วยความจำ (array)
```latex
\memorybox{10, 20, 30, 5, 8}
```
วาดกล่อง array แนวนอนพร้อมเลข index กำกับใต้แต่ละช่อง

---

## 7b. คำสั่งจาก `cncs-pseudocode.sty` (ต้องเรียก `\RequirePackage{cncs-pseudocode}` เอง)

กล่อง pseudocode ที่มีเลขบรรทัดอัตโนมัติและย่อหน้าตามบล็อก `if/for/while/function` (มาจาก `algpseudocode`) ห่อด้วยกรอบสีธีมเดียวกับ `cncscode`

```latex
\begin{pseudocode}                 % คีย์เวิร์ดอังกฤษ: if/then/else/for/while/...
\Function{FindMax}{$A, n$}
    \State $max \gets A[0]$ \Comment{ตั้งค่าเริ่มต้นเป็นตัวแรก}
    \For{$i \gets 1$ \textbf{to} $n-1$}
        \If{$A[i] > max$}
            \State $max \gets A[i]$
        \EndIf
    \EndFor
    \State \Return $max$
\EndFunction
\end{pseudocode}
```

ถ้าต้องการคีย์เวิร์ดภาษาไทยล้วน (ถ้า/แล้ว/มิฉะนั้น/สำหรับ/ขณะที่/จบ...) ใช้ `pseudocodethai` แทน โดยเนื้อหาข้างในเขียนแบบเดียวกันทุกประการ:

```latex
\begin{pseudocodethai}
\Function{หาค่ามากสุด}{$A, n$}
    \State $max \gets A[0]$ \Comment{ตั้งค่าเริ่มต้นเป็นตัวแรก}
    ...
\EndFunction
\end{pseudocodethai}
```

> หมายเหตุ: `pseudocode` และ `pseudocodethai` ใช้สลับกันได้ในเอกสารเดียวกัน คีย์เวิร์ดของบล็อกหนึ่งจะไม่ไปกระทบอีกบล็อกหนึ่ง
> คำสั่งพื้นฐานที่ใช้บ่อย: `\State` (บรรทัดคำสั่ง), `\If{...}...\Else...\EndIf`, `\For{...}...\EndFor`, `\While{...}...\EndWhile`, `\Function{ชื่อ}{พารามิเตอร์}...\EndFunction`, `\Return`, `\Comment{...}` (คอมเมนต์ท้ายบรรทัด — เขียนไทยได้เสมอไม่ว่าจะใช้ environment ไหน)

ดูตัวอย่างเต็มได้ที่ `example-pseudocode.tex`

**`\begin{pseudosteps}` — สไตล์เลขข้อ outline แบบตำราไทย (คนละแบบกับข้างบน)**

`\pseudocode`/`\pseudocodethai` ข้างบนลอกโครงสร้าง "indent + end if/end for" มาจากภาษาอังกฤษ ซึ่ง **ไม่ตรงกับที่ตำราไทยเขียนจริง** — ของจริงใช้ **เลขข้อซ้อนกัน** (1, 2, 3, 4 → 4.1, 4.2, ...) แทนคำว่า "จบ" ทั้งหมด ใช้ `pseudosteps` เมื่อต้องการสไตล์นี้:

```latex
\begin{pseudosteps}
  \item ให้ $n$ \pcgets จำนวนข้อมูลในรายการ $L$
  \item ให้ $left$ \pcgets $1$
  \item ทำซ้ำ ขณะที่ $left \le right$
    \begin{pseudosubsteps}
      \item ให้ $mid$ \pcgets $(left+right)/2$ ปัดเศษทิ้ง
      \item ถ้า $x = target$ แล้ว ให้คืนค่าดัชนี $i$ เท่ากับ $mid$ และจบการทำงาน
    \end{pseudosubsteps}
  \item คืนคำตอบว่าไม่พบข้อมูล $target$ ในรายการ $L$
\end{pseudosteps}
```

- `\pcgets` พิมพ์ลูกศร ← ผ่าน math mode (`\leftarrow`) เสมอ ไม่ใช้ตัวอักษร Unicode ลูกศรตรง ๆ เพื่อไม่ให้ไปพึ่ง glyph ในฟอนต์ไทย (กันบั๊กแบบที่เจอกับ `\texttt` ครอบภาษาไทยตอนแรก)
- `\begin{pseudosubsteps}` ต้องอยู่ **ข้างใน** `\item` ของ `pseudosteps` เท่านั้น (ซ้อนจริง ไม่ใช่แค่เรียกลอย ๆ) เพราะเลข "4.1" ดึงเลขแม่ (4) มาจากตัวนับของ `enumerate` ชั้นนอกอัตโนมัติ — แก้/สลับลำดับข้อพ่อแล้วเลขลูกขยับตามเองเสมอ ไม่มีทางเลขเพี้ยน
- ถ้าต้องซ้อนลึกถึง 3 ชั้น (เช่น `2.1.1`) ใช้ `\begin{pseudosubsubsteps}` ข้างใน `\item` ของ `pseudosubsteps` อีกที — กลไกเดียวกัน ดึงเลขแม่+ปู่มาต่อกันอัตโนมัติ แนะนำให้ใช้เท่าที่จำเป็นจริง ๆ เพราะซ้อนลึกเกิน 3 ชั้นเริ่มอ่านตามยาก ไม่ว่าจะพิมพ์ด้วยเครื่องมือไหน
- `\PCBegin` / `\PCEnd` (พิมพ์ "เริ่มต้น"/"จบ" ตัวหนา) เป็นตัวเลือก ไม่บังคับ — **ต้องวางไว้นอก** `\begin{pseudosteps}...\end{pseudosteps}` เท่านั้น (ใส่ข้างในจะพัง เพราะ list environment ของ LaTeX ต้องขึ้นต้นด้วย `\item` เสมอ)

ดูตัวอย่างเต็ม (binary search แบบมีลูกซ้อน + คำนวณพื้นที่สามเหลี่ยมแบบเรียบง่าย) ได้ที่ `example-pseudosteps.tex`

---

## 7c. คำสั่งจาก `cncs-components.sty` (Phase 1-2: Educational Components)

แนวคิด: แยก "เนื้อหา" ออกจาก "การประกอบเป็น worksheet" — เขียนแต่ละ Objective/Warmup/Activity/Question/Assessment/Reflection เป็นไฟล์ `.tex` เดี่ยว ๆ เก็บไว้ในโฟลเดอร์ `components/` แล้วให้ worksheet หลัก `\input{}` มาประกอบตามลำดับที่ต้องการ → นำไฟล์เดียวกันไปใช้ซ้ำใน worksheet อื่นได้ทันทีโดยไม่ต้อง copy-paste

โครงสร้างโฟลเดอร์ที่แนะนำ:
```
project/
  worksheet.tex
  components/
    objectives/loop-basic.tex
    activities/while-trace.tex
    questions/while-mc-01.tex
```

คำสั่งที่มี (ทุกตัวเป็นกล่องธีมสีเดียวกับ `\instruction`):

```latex
\Objective[label]{เนื้อหา}    % วัตถุประสงค์การเรียนรู้
\Warmup[label]{เนื้อหา}       % กิจกรรมนำเข้าสู่บทเรียน
\Activity[label]{เนื้อหา}     % กิจกรรม
\Question[label]{เนื้อหา}     % คำถาม/โจทย์ (สำหรับคลังข้อสอบ)
\Assessment[label]{เนื้อหา}   % การประเมินผล
\Reflection[label]{เนื้อหา}   % สะท้อนคิด/ทบทวนบทเรียน
```

`label` (optional argument) **ไม่ใช่ตัวนับอัตโนมัติ** — ใส่เองทุกครั้ง เพราะ component แต่ละไฟล์ถูกออกแบบให้ถูก `\input` ในลำดับต่างกันได้ในแต่ละ worksheet การนับอัตโนมัติจะทำให้เลขเพี้ยนเมื่อสลับลำดับ:

```latex
\Activity{...}                              % หัวเรื่อง: "กิจกรรม"
\Activity[1]{...}                           % หัวเรื่อง: "กิจกรรมที่ 1"
\Activity[1: สำรวจอาร์เรย์]{...}             % หัวเรื่อง: "กิจกรรมที่ 1: สำรวจอาร์เรย์"
```

ตัวอย่างการประกอบ worksheet จากไฟล์ components ดูได้ที่ `example-components/worksheet-demo.tex`

**`\Question` + เฉลยที่สลับได้ (`showanswers`)**

`\Question` เป็นแค่กล่องธีม ไม่ใช่ระบบข้อสอบ — สำหรับโจทย์ปรนัยที่ต้องการเฉลยสลับได้ตาม option `showanswers` ให้ใช้ `\choice`/`\correct`/`\begin{choices}...\end{choices}` (จาก `cncs-exam.sty` ซึ่ง `cncs-components.sty` โหลดให้อัตโนมัติแล้ว) **ไว้ข้างในเนื้อหาของ `\Question`**:

```latex
\Question[1]{
  ข้อใดคือเงื่อนไขที่ทำให้ลูป while หยุดทำงาน
  \begin{choices}
    \choice{เมื่อเงื่อนไขเป็นจริง}
    \correct{เมื่อเงื่อนไขเป็นเท็จ}   % ตัวหนา+สีธีม เฉพาะตอน showanswers=true
  \end{choices}
}
```

`\Question` **ไม่เปิด** `\begin{choices}` ให้อัตโนมัติ เพราะไม่ใช่ทุกคำถามเป็นปรนัย (บางข้อเป็นแบบเขียนตอบเปิด ใช้ `\answerline`/`\answerlines{n}` แทนได้ตามปกติ) และอย่าสับสนกับ environment `question` เดิมของ `cncs-exam.sty` (ตัว q พิมพ์เล็ก, นับเลขข้ออัตโนมัติผ่านตัวนับ `cncsq`) — คนละกลไกกัน ใช้ `question` สำหรับข้อสอบที่พิมพ์รวมเป็นชุดเรียงเลขอัตโนมัติ ส่วน `\Question` สำหรับโจทย์ที่จะแยกไฟล์เก็บไว้ใช้ซ้ำและกำหนดเลขเอง

---

## 7d. `cncs-lessonplan.cls` (คนละคลาส แยกจาก `cncs.cls`) — แผนการจัดการเรียนรู้ราชการ

คลาสใหม่สำหรับพิมพ์ "แผนการจัดการเรียนรู้" ตามแบบฟอร์มของโรงเรียนชลกันยานุกูล (18 หัวข้อ + ลายเซ็น) หน้าตาเป็นทางการล้วน ไม่มีกล่องสีแบบใบงาน

**จุดสำคัญที่สุด:** ไฟล์ component เดียวกัน (`\Warmup`/`\Activity`/`\Reflection` จาก `cncs-components.sty`) ใช้ `\input` ซ้ำได้ทั้งในใบงาน (`cncs.cls`) และแผนการสอน (`cncs-lessonplan.cls`) — โค้ดในไฟล์ component **ไม่ต้องแก้อะไรเลย** เพราะคลาสนี้ตั้ง `\cncs@planmodetrue` ให้อัตโนมัติ ทำให้ 3 คำสั่งนั้นเปลี่ยนจากกล่องสีเป็นข้อความใต้หัวข้อ **11.1/11.2/11.3** แทน

```latex
\documentclass{cncs-lessonplan}
\LessonPlanNo{5} \LearningArea{วิทยาการคำนวณ} \Subject{...} \SubjectCode{...}
\UnitNo{3} \UnitName{...} \Topic{...} \Grade{5} \Term{1}
\AcademicYear{2569} \Periods{2} \Teacher{...}

\begin{document}
\LessonPlanHeader

\Standards{...}
\Indicators[between]{...}   \Indicators[final]{...}
\KeyConcept{...}
\LearningObjective{K}{...}  \LearningObjective{P}{...}  \LearningObjective{A}{...}
\Competencies{communication, thinking}      % checklist 5 ข้อ
\Characteristics{disciplined, eager}        % checklist 8 ข้อ
\Content{...}
\CenturySkills{criticalthinking, computing} % checklist 3Rx8C (~11 ข้อ)
\EECIndustries{digital}                     % checklist EEC 12 ข้อ
\Task{...}

\input{components/activities/while-trace-plan}   % Warmup/Activity/Reflection เดิม -> 11.1/11.2/11.3

\Media{...}  \LearningSource{...}

\begin{AssessmentTable}
\AssessmentRow{K}{สิ่งที่วัด}{วิธีวัด}{เครื่องมือ}{เกณฑ์}
\end{AssessmentTable}

\LessonPlanFooter   % หัวข้อ 15-18 + บล็อกลายเซ็น เว้นว่างให้กรอกมือหลังสอน
\end{document}
```

**Checklist ใช้คำ keyword ภาษาอังกฤษสั้น ๆ** (ไม่ใช้เลขข้อ เพราะจำง่ายกว่า) คั่นด้วย comma ไม่สนใจช่องว่าง:

| หัวข้อ | คำสั่ง | keyword ที่ใช้ได้ |
|---|---|---|
| 5. สมรรถนะ | `\Competencies{...}` | communication, thinking, problemsolving, life, technology |
| 6. คุณลักษณะ | `\Characteristics{...}` | patriotic, honest, disciplined, eager, sufficiency, diligent, thai, public |
| 8. 3Rx8C | `\CenturySkills{...}` | reading, writing, arithmetic, criticalthinking, creativity, crosscultural, collaboration, commmedia, computing, career, compassion |
| 9. EEC | `\EECIndustries{...}` | automotive, electronics, agriculture, food, tourism, robotics, aviation, medical, biofuel, digital, defense, education |

พิมพ์ keyword ผิด (ไม่ตรงกับที่กำหนด) จะแค่ไม่ติ๊กข้อนั้นเฉย ๆ ไม่ error — ควรเช็คจากภาพ PDF ทุกครั้งว่าติ๊กครบตามที่ตั้งใจ

**ข้อ 14 (การวัดและประเมินผล)** เป็นตารางแถวละหมวด ไม่ได้ทำ merged cell ซ้อนรายการย่อยแบบฟอร์มต้นฉบับ (ความซับซ้อนไม่คุ้มกับประโยชน์ที่ได้) — เรียก `\AssessmentRow{K|P|A|Competency|Character}{สิ่งที่วัด}{วิธีวัด}{เครื่องมือ}{เกณฑ์}` ได้หลายแถวภายใน `AssessmentTable`

**ข้อ 15-18 + ลายเซ็น** ไม่มี macro รับ input เพราะเป็นส่วนที่กรอกด้วยมือหลังสอนจริง — `\LessonPlanFooter` แค่พิมพ์หัวข้อ + เส้นว่างให้เท่านั้น

**ข้อความสีแดงในแบบฟอร์มต้นฉบับ** (คำแนะนำการกรอก) ไม่ได้ทำเป็นเนื้อหาในคลาสนี้ ตามที่ยืนยันไว้ว่าเป็นแค่ note ช่วยกรอก ไม่ต้องพิมพ์ลงแผนจริง

ดูตัวอย่างเต็มได้ที่ `example-lessonplan.tex`

---

## 8. ตัวอย่างเต็ม

ดูไฟล์ `worksheet.tex` ที่แนบมาเป็นตัวอย่างใช้งานจริง ครอบคลุมทั้งบล็อกโค้ด ตารางตัวแปร กล่องคำตอบ และ `\drawingbox`

---

## 9. ปัญหาที่พบบ่อย

| อาการ | สาเหตุ | วิธีแก้ |
|---|---|---|
| ตัวอักษรไทยไม่ขึ้นเลย / เห็นเป็นช่องว่าง | ไม่มีฟอนต์ไทยทั้ง 3 ตัวในเครื่อง | ติดตั้ง TH Sarabun New แล้วคอมไพล์ใหม่ |
| คอมไพล์ด้วย pdfLaTeX แล้ว error | คลาสนี้ใช้ `fontspec` ซึ่งรองรับเฉพาะ XeLaTeX/LuaLaTeX | เปลี่ยนมาใช้ `xelatex` |
| เรียก `\studentinfo` แล้วหัวข้อ "ใบกิจกรรม" ไปโผล่ข้างล่าง | เรียกผิดลำดับ | ต้องเรียก `\worksheet{...}` ก่อน `\studentinfo` เสมอ |
| ธีมสีไม่เปลี่ยนตามที่ตั้ง | สะกดชื่อธีมผิด | ใช้ได้เฉพาะ `blue, green, red, purple, orange` เท่านั้น |\semester{ภาคเรียนที่}
\academicyear{ปีการศึกษา}
\school{ชื่อโรงเรียน}
```

ถ้าไม่ประกาศ จะใช้ค่าเริ่มต้น: วิชา "วิทยาการคำนวณ", ภาคเรียน 1, ปีการศึกษา 2569, โรงเรียนชลกันยานุกูล

---

## 5. คำสั่งจัดโครงสร้างเอกสาร

| คำสั่ง | หน้าที่ |
|---|---|
| `\worksheet{หัวข้อ}` | พิมพ์ชื่อใบกิจกรรมตัวใหญ่ กึ่งกลาง สีธีม (เรียกก่อน `\studentinfo` เสมอ) |
| `\studentinfo` | พิมพ์แถว ชื่อ-สกุล / ห้อง / เลขที่ พร้อมเส้นคั่นท้ายแถว |
| `\activitysection{หัวข้อย่อย}` | หัวข้อตอน เช่น "ตอนที่ 1: ..." ตัวหนา สีธีม |

---

## 6. คำสั่งจาก `cncs-boxes.sty` (โหลดมาให้อัตโนมัติ)

| คำสั่ง | หน้าที่ |
|---|---|
| `\begin{instruction}[หัวข้อ] ... \end{instruction}` | กล่องคำชี้แจง มีกรอบสีธีม (ไม่ใส่ `[หัวข้อ]` จะขึ้น "คำชี้แจง" อัตโนมัติ) |
| `\drawingbox[ป้ายกำกับ]{ความสูง}` | กล่องเส้นประเปล่า ๆ สำหรับให้นักเรียนวาดภาพ/ผังงาน เช่น `\drawingbox[วาด Flowchart]{6cm}` |
| `\answerline` | เส้นประให้ตอบ 1 บรรทัด |
| `\answerlines{n}` | เส้นประให้ตอบ n บรรทัด เช่น `\answerlines{4}` |

---

## 7. คำสั่งจาก `cncs-computing.sty` (ต้องเรียก `\RequirePackage{cncs-computing}` เอง)

### บล็อกโค้ด
```latex
\begin{cncscode}[C]
#include <stdio.h>
int main(void) { return 0; }
\end{cncscode}
```
เปลี่ยน `[C]` เป็น `[Python]`, `[Java]` ฯลฯ ได้ตามภาษาที่ `listings` รองรับ ถ้าไม่ใส่ `[...]` จะ default เป็น C

> ⚠️ **ข้อจำกัดที่ควรรู้**: ฟอนต์ในบล็อกโค้ดใช้ฟอนต์ไทยตัวเดียวกับเนื้อหาปกติ (ไม่ใช่ monospace แท้)
> เพื่อให้คอมเมนต์ภาษาไทยในโค้ด (เช่น `# เขียนสูตรตรงนี้`) แสดงผลได้โดยไม่พัง — แลกกับที่
> ตัวอักษรโค้ดจะไม่เรียงตัวชิดตารางแบบ monospace เหมือนโค้ดทั่วไป

### ตารางตัวแปร
```latex
\begin{vartable}
    i & 0 \\ \hline
    i & 1 \\ 
\end{vartable}
```
หัวตารางคือ "ชื่อตัวแปร" / "ค่า" มาให้อัตโนมัติ

### ตาราง Trace
```latex
\begin{tracetable}{5}   % {5} คือจำนวนคอลัมน์ตัวแปร
Step & i & sum & ... \\ \hline
1 & 0 & 0 & ... \\
\end{tracetable}
```

### ตารางแปลงเลขฐานสอง
```latex
\binarytable
```
ได้ตารางค่าน้ำหนักบิต 128-64-32-16-8-4-2-1 พร้อมช่องว่างให้กรอก

### กล่องแสดงหน่วยความจำ (array)
```latex
\memorybox{10, 20, 30, 5, 8}
```
วาดกล่อง array แนวนอนพร้อมเลข index กำกับใต้แต่ละช่อง

---

## 8. ตัวอย่างเต็ม

ดูไฟล์ `worksheet.tex` ที่แนบมาเป็นตัวอย่างใช้งานจริง ครอบคลุมทั้งบล็อกโค้ด ตารางตัวแปร กล่องคำตอบ และ `\drawingbox`

---

## 9. ปัญหาที่พบบ่อย

| อาการ | สาเหตุ | วิธีแก้ |
|---|---|---|
| ตัวอักษรไทยไม่ขึ้นเลย / เห็นเป็นช่องว่าง | ไม่มีฟอนต์ไทยทั้ง 3 ตัวในเครื่อง | ติดตั้ง TH Sarabun New แล้วคอมไพล์ใหม่ |
| คอมไพล์ด้วย pdfLaTeX แล้ว error | คลาสนี้ใช้ `fontspec` ซึ่งรองรับเฉพาะ XeLaTeX/LuaLaTeX | เปลี่ยนมาใช้ `xelatex` |
| เรียก `\studentinfo` แล้วหัวข้อ "ใบกิจกรรม" ไปโผล่ข้างล่าง | เรียกผิดลำดับ | ต้องเรียก `\worksheet{...}` ก่อน `\studentinfo` เสมอ |
| ธีมสีไม่เปลี่ยนตามที่ตั้ง | สะกดชื่อธีมผิด | ใช้ได้เฉพาะ `blue, green, red, purple, orange` เท่านั้น |
