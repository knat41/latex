# CNCS — LaTeX Document System สำหรับวิชาคอมพิวเตอร์

ชุดคลาส/แพ็กเกจ LaTeX สำหรับสร้างเอกสารวิชาคอมพิวเตอร์ โรงเรียนชลกันยานุกูล — ใบกิจกรรม (worksheet), แผนการจัดการเรียนรู้ (lesson plan), pseudocode, ผังงาน (flowchart) และข้อสอบ โดยเนื้อหาส่วนที่เป็น component (วัตถุประสงค์/กิจกรรม/คำถาม ฯลฯ) เขียนครั้งเดียว ใช้ซ้ำได้ทั้งในใบงานและแผนการสอน

**เอกสารฉบับเต็ม (คำสั่งทั้งหมด พร้อมตัวอย่าง):** [`manual.md`](./manual.md)

## ต้องมีอะไรก่อนใช้

- **XeLaTeX** (ห้ามใช้ pdfLaTeX — ไม่รองรับฟอนต์ไทย)
- ฟอนต์ไทยอย่างน้อย 1 ตัว: TH Sarabun New (แนะนำ), Loma, หรือ Noto Sans Thai

รายละเอียดครบถ้วนดูที่ [`manual.md` หัวข้อ 1](./manual.md#1-สิ่งที่ต้องมีก่อนใช้งาน)

## เริ่มต้นเร็ว ๆ (ใบกิจกรรม)

```latex
\documentclass[theme=blue, thai]{cncs}
\RequirePackage{cncs-computing}   % ถ้าต้องการโค้ด/ตารางตัวแปร

\begin{document}
\worksheet{ชื่อใบกิจกรรม}
\studentinfo

\activitysection{ตอนที่ 1}
...
\end{document}
```

คอมไพล์ด้วย `xelatex ชื่อไฟล์.tex`

## ไฟล์ทั้งหมดในระบบ

| ไฟล์ | ประเภท | ใช้ทำอะไร |
|---|---|---|
| `cncs.cls` | คลาสหลัก | ใบกิจกรรม (worksheet) |
| `cncs-colors.sty` | โหลดอัตโนมัติ | ธีมสี |
| `cncs-boxes.sty` | โหลดอัตโนมัติ | กล่องคำชี้แจง/วาดภาพ/เส้นตอบคำถาม |
| `cncs-computing.sty` | เรียกเอง | บล็อกโค้ด, ตารางตัวแปร/trace, เลขฐานสอง, array |
| `cncs-exam.sty` | เรียกเอง | ข้อสอบปรนัย, rubric |
| `cncs-pseudocode.sty` | เรียกเอง | Pseudocode 3 สไตล์ (อังกฤษ/ไทย end-keyword/ไทย เลขข้อ) |
| `cncs-components.sty` | เรียกเอง | Component ใช้ซ้ำได้ (Objective/Warmup/Activity/Question/Assessment/Reflection) — ใช้ร่วมกันได้ทั้งใบงานและแผนการสอน |
| `cncs-lessonplan.cls` | คลาสแยก | แผนการจัดการเรียนรู้ราชการ (18 หัวข้อ) |
| `cncs-flowchart.sty` | เรียกเอง | ผังงาน (flowchart) ด้วย TikZ |

## ตัวอย่างที่แนบมา

| ไฟล์ | สาธิตอะไร |
|---|---|
| `worksheet.tex` | ใบกิจกรรมพื้นฐาน |
| `example-pseudocode.tex` | pseudocode สไตล์อังกฤษ + ไทย (end-keyword) |
| `example-pseudosteps.tex` | pseudocode สไตล์เลขข้อ outline (ตรงกับตำราไทย) |
| `example-control-structures.tex` | โครงสร้างพื้นฐาน 3 แบบ — เรียงลำดับ/ทางเลือก/ทำซ้ำ |
| `example-components-all.tex` | ทั้ง 6 component ในไฟล์เดียว |
| `example-components.zip` | การใช้ซ้ำ component ข้ามไฟล์ |
| `example-lessonplan.tex` | แผนการจัดการเรียนรู้เต็ม 18 หัวข้อ |
| `example-flowchart.tex` | ผังงาน — มีลูป และแตกเงื่อนไข |

คำอธิบายคำสั่งแต่ละตัวแบบละเอียด พร้อมตาราง options และปัญหาที่พบบ่อย ดูที่ **[`manual.md`](./manual.md)**
