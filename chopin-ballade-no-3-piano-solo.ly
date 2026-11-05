\version "2.26.0"
\language "nederlands"
% Chopin: Ballade No. 3 in A-flat major, Op. 47.
% Standalone edition.  Requires LilyPond 2.26.0 only; no external includes.
% The supplied 12-page PDF is the authority for all 56 system/page boundaries.
% Source MusicXML exact note durations are preserved without any timing repair.
% Title and composer dates follow the previously approved Chopin edition style.
\pointAndClickOff

#(set-global-staff-size 17.0716530256)
\header {
  title = \markup \override #'(font-name . "Times New Roman, Liberation Serif, C059")
    \abs-fontsize #24 "Ballade No. 3"
  subtitle = \markup \override #'(font-name . "Times New Roman, Liberation Serif, C059")
    \abs-fontsize #14 "in A-flat Major, Op. 47"
  composer = \markup \override #'(font-name . "Times New Roman, Liberation Serif, C059")
    \abs-fontsize #11.5 "Frédéric François Chopin"
  composerDates = \markup \override #'(font-name . "Times New Roman, Liberation Serif, C059")
    \abs-fontsize #11.5 "(1810 – 1849)"
  pdftitle = "Ballade No. 3 in A-flat Major, Op. 47"
  pdfauthor = "Frédéric François Chopin"
  tagline = ##f
}
\paper {
  paper-width = 215.9\mm
  paper-height = 279.4\mm
  top-margin = 10\mm
  bottom-margin = 15\mm
  left-margin = 10.0000000000\mm
  right-margin = 9.9999494847\mm
  indent = 3.1133387861\mm
  short-indent = 3.1133387861\mm
  page-count = 12
  ragged-last = ##f
  ragged-last-bottom = ##t
  print-first-page-number = ##f
  bookTitleMarkup = \markup \column {
    \fill-line { \fromproperty #'header:title }
    \vspace #0.8
    \overlay {
      \fill-line { \fromproperty #'header:subtitle }
      \fill-line { "" \fromproperty #'header:composer }
    }
    \vspace #0.7
    \fill-line { "" \fromproperty #'header:composerDates }
  }
  oddHeaderMarkup = ##f
  evenHeaderMarkup = ##f
  oddFooterMarkup = \markup \fill-line { "" \if \should-print-page-number \override #'(font-name . "Nimbus Roman,") \abs-fontsize #8.03 \fromproperty #'page:page-number-string }
  evenFooterMarkup = \markup \fill-line { \if \should-print-page-number \override #'(font-name . "Nimbus Roman,") \abs-fontsize #8.03 \fromproperty #'page:page-number-string "" }
  top-markup-spacing = #'((basic-distance . 0) (minimum-distance . 0) (padding . 0) (stretchability . 0))
  markup-system-spacing = #'((basic-distance . 6) (minimum-distance . 4) (padding . 1) (stretchability . 0))
  system-system-spacing = #'((basic-distance . 0) (minimum-distance . 0) (padding . 0) (stretchability . 0))
}
refSystem =
#(define-music-function (y distance) (number? number?)
   #{ \once \override Score.NonMusicalPaperColumn.line-break-system-details =
      #`((Y-offset . ,y) (alignment-distances . (,distance))) #})

% Semantic IDs support optional contour-audit links; ordinary PDF has no links.
#(define concerto-audit-id 0)
% Source stroke widths in staff-space units. LilyPond's line-thickness base
% is font-size dependent, so derive each factor from the actual layout base.
#(define (op47-source-rule-thickness ratio)
   (lambda (grob)
     (let* ((staff (if (eq? 'StaffSymbol (assoc-get 'name (ly:grob-property grob 'meta)))
                      grob (ly:grob-object grob 'staff-symbol)))
            (space (ly:staff-symbol-staff-space staff))
            (base (ly:output-def-lookup (ly:grob-layout grob) 'line-thickness)))
       (/ (* space ratio) base))))
#(define (concerto-script-with-source-trills grob)
   (let ((kind (ly:grob-property grob 'script-stencil)))
     (if (member kind '((feta . ("trill" . "trill"))
                       (feta . ("prall" . "prall"))))
         #f
         (ly:script-interface::print grob))))
#(define (concerto-visible-rest-positioning grob)
   (let* ((array (ly:grob-object grob 'elements))
          (columns (if (ly:grob-array? array) (ly:grob-array->list array) '()))
          (visible (filter (lambda (column)
                     (let ((rest (ly:grob-object column 'rest)))
                       (or (not (ly:grob? rest))
                           (and (not (ly:grob-property rest 'transparent #f))
                                (not (eq? #f (ly:grob-property-data rest 'stencil))))))) columns)))
     (when (ly:grob-array? array)
       (ly:grob-set-object! grob 'elements (ly:grob-list->grob-array visible)))
     (ly:rest-collision::calc-positioning-done grob)))
#(define (concerto-audit-engraver context)
   (make-engraver
     (acknowledgers
       ((grob-interface engraver grob source-engraver)
        (set! concerto-audit-id (+ concerto-audit-id 1))
        (let* ((name (assoc-get 'name (ly:grob-property grob 'meta) 'Unknown))
               (cause (ly:grob-property grob 'cause))
               (origin (and (ly:stream-event? cause) (ly:event-property cause 'origin #f)))
               (location (and (ly:input-location? origin) (ly:input-file-line-char-column origin)))
               (old (ly:grob-property grob 'output-attributes '())))
          (ly:grob-set-property! grob 'output-attributes
            (append old
              (list (cons 'id (format #f "g~a" concerto-audit-id))
                    (cons 'data-grob (symbol->string name))
                    (cons 'data-voice (ly:context-id (ly:translator-context source-engraver)))
                    (cons 'data-bar (format #f "~a" (ly:context-property context 'currentBarNumber 0)))
                    (cons 'data-source (if location (format #f "~a" location) "")))))
        (concerto-audit-wrap-pdf-stencil! grob))))))

% OP47_NATIVE_MUSIC_OBJECT_REPAIRS
% Source endpoints plus documented contour-clearance exceptions; no musical-event changes.
#(define op47-source-flag-tip-targets (make-hash-table 401))
#(for-each (lambda (r) (hash-set! op47-source-flag-tip-targets (car r) (cdr r)))
  '(
    ("n1-11" . -10.000003543855)
    ("n1-1178" . -7.999999988424)
    ("n1-1179" . -7.999999988424)
    ("n1-1186" . 10.326444476869)
    ("n1-1187" . 10.326444476869)
    ("n1-1188" . 10.326444476869)
    ("n1-1199" . 10.326444476869)
    ("n1-12" . -10.000003543855)
    ("n1-1200" . 10.326444476869)
    ("n1-1201" . 10.326444476869)
    ("n1-1215" . 3.319851859670)
    ("n1-1216" . 3.319851859670)
    ("n1-1242" . 3.319851791968)
    ("n1-1243" . 3.319851791968)
    ("n1-1276" . 3.319851791968)
    ("n1-1277" . 3.319851791968)
    ("n1-13" . -10.000003543855)
    ("n1-1345" . 8.000014300546)
    ("n1-1683" . 6.250006265756)
    ("n1-1684" . 6.250006265756)
    ("n1-1685" . 6.250006265756)
    ("n1-1733" . 6.999989226865)
    ("n1-1734" . 6.999989226865)
    ("n1-1735" . 6.999989226865)
    ("n1-1791" . 8.000000981760)
    ("n1-1792" . 8.000000981760)
    ("n1-1793" . 8.000000981760)
    ("n1-1797" . 7.000001197239)
    ("n1-1798" . 7.000001197239)
    ("n1-1799" . 7.000001197239)
    ("n1-1803" . 6.250000461689)
    ("n1-1804" . 6.250000461689)
    ("n1-1805" . 6.250000461689)
    ("n1-1841" . -9.999999979421)
    ("n1-1842" . -9.999999979421)
    ("n1-1843" . -9.999999979421)
    ("n1-1847" . 9.326444428821)
    ("n1-1848" . 9.326444428821)
    ("n1-1849" . 9.326444428821)
    ("n1-1868" . -7.999985621917)
    ("n1-1869" . -7.999985621917)
    ("n1-187" . -7.999985593805)
    ("n1-1870" . -7.999985621917)
    ("n1-188" . -7.999985593805)
    ("n1-189" . -7.999985593805)
    ("n1-1918" . -9.999992800393)
    ("n1-1919" . -9.999992800393)
    ("n1-317" . -10.000007117476)
    ("n1-318" . -10.000007117476)
    ("n1-319" . -10.000007117476)
    ("n1-341" . -9.999992779998)
    ("n1-342" . -9.999992779998)
    ("n1-343" . -9.999992779998)
    ("n1-394" . -7.999985613648)
    ("n1-395" . -7.999985613648)
    ("n1-427" . -7.999995570573)
    ("n1-428" . -7.999995570573)
    ("n1-469" . 6.999996367124)
    ("n1-472" . 6.999996367124)
    ("n1-486" . 6.999989206653)
    ("n1-487" . 6.999989206653)
    ("n1-488" . 6.999989206653)
    ("n1-503" . 8.326433683522)
    ("n1-504" . 8.326433683522)
    ("n1-505" . 8.326433683522)
    ("n1-506" . 6.999989206653)
    ("n1-507" . 6.999989206653)
    ("n1-508" . 6.999989206653)
    ("n1-510" . -7.999999970234)
    ("n1-511" . -7.999999970234)
    ("n1-547" . -8.000014333619)
    ("n1-548" . -8.000014333619)
    ("n1-549" . -8.000014333619)
    ("n1-550" . -9.000010741165)
    ("n1-551" . -9.000010741165)
    ("n1-552" . -9.000010741165)
    ("n1-565" . -8.000014333619)
    ("n1-566" . -8.000014333619)
    ("n1-567" . -8.000014333619)
    ("n1-571" . -8.999982002086)
    ("n1-572" . -8.999982002086)
    ("n1-573" . -8.999982002086)
    ("n1-715" . -8.000007164329)
    ("n1-716" . -8.000007164329)
    ("n1-717" . -8.000007164329)
    ("n1-718" . 5.499994578522)
    ("n1-730" . 5.499994578522)
    ("n1-783" . 9.326430070122)
    ("n1-784" . 9.326430070122)
    ("n1-785" . 9.326430070122)
    ("n1-789" . -8.999996398727)
    ("n1-790" . -8.999996398727)
    ("n1-791" . -8.999996398727)
    ("n1-795" . -8.999996398727)
    ("n1-796" . -8.999996398727)
    ("n1-797" . -8.999996398727)
    ("n1-798" . 7.899991694325)
    ("n1-799" . 7.899991694325)
    ("n1-800" . 7.899991694325)
    ("n1-807" . -7.999999991181)
    ("n1-808" . -7.999999991181)
    ("n1-809" . -7.999999991181)
    ("n1-841" . -7.999995570573)
    ("n1-842" . -7.999995570573)
    ("n1-874" . -7.999995570573)
    ("n1-875" . -7.999995570573)
    ("n1-914" . 6.999996367124)
    ("n1-915" . 6.999996367124)
    ("n2-100" . -15.000003549000)
    ("n2-101" . -15.999999956546)
    ("n2-102" . -15.999999956546)
    ("n2-11" . -14.999999936151)
    ("n2-123" . -14.000007145588)
    ("n2-124" . -14.000007145588)
    ("n2-128" . -12.999996342870)
    ("n2-129" . -12.999996342870)
    ("n2-131" . -9.999978411102)
    ("n2-132" . -8.999982003556)
    ("n2-136" . -10.999974818648)
    ("n2-137" . -10.999974818648)
    ("n2-15" . -14.000021483800)
    ("n2-157" . -13.000003556625)
    ("n2-16" . -14.000021483800)
    ("n2-17" . -14.000021483800)
    ("n2-170" . -8.999995355093)
    ("n2-171" . -8.999995355093)
    ("n2-172" . -15.999993846739)
    ("n2-186" . -7.999999988241)
    ("n2-187" . -7.999999988241)
    ("n2-193" . -12.999996359407)
    ("n2-194" . -12.999996359407)
    ("n2-214" . 3.099997460331)
    ("n2-241" . 3.100001319880)
    ("n2-260" . 3.100001319880)
    ("n2-52" . -15.000003509771)
    ("n2-56" . -15.000003526859)
    ("n2-83" . -10.999996386968)
    ("n2-85" . -9.999999979421)
    ("n2-86" . -8.000007164329)
    ("n2-89" . -7.999999970234)
    ("n2-91" . -10.000007139892)
    ("n2-92" . -10.000007139892)
    ("n2-93" . -15.999999956546)
    ("n2-94" . -15.999999956546)
    ("n5-1018" . 7.000017903840)
    ("n5-1062" . -9.000005762867)
    ("n5-1063" . -9.000005762867)
    ("n5-1107" . -7.999999969132)
    ("n5-1108" . -7.999999969132)
    ("n5-1218" . -9.000005762867)
    ("n5-1219" . -9.000005762867)
    ("n5-1220" . -9.000005762867)
    ("n5-1224" . -8.000001731184)
    ("n5-1225" . -8.000001731184)
    ("n5-1226" . -8.000001731184)
    ("n5-1240" . -8.000001731184)
    ("n5-1241" . -8.000001731184)
    ("n5-1242" . -8.000001731184)
    ("n5-1269" . -7.999982031500)
    ("n5-1270" . -7.999982031500)
    ("n5-1275" . -7.999982031500)
    ("n5-1276" . -7.999982031500)
    ("n5-1321" . -7.999999961415)
    ("n5-1322" . -7.999999961415)
    ("n5-1629" . 7.000001325765)
    ("n5-1770" . -9.999978436090)
    ("n5-1771" . -9.999978436090)
    ("n5-1814" . -10.000009807778)
    ("n5-1815" . -10.000009807778)
    ("n5-31" . 24.426208180023)
    ("n5-32" . 24.426208180023)
    ("n5-35" . 14.229118377635)
    ("n5-36" . 14.229118377635)
    ("n5-418" . 13.326443291421)
    ("n5-419" . 13.326443291421)
    ("n5-450" . -9.999992778528)
    ("n5-451" . -9.999992778528)
    ("n5-452" . -9.999992778528)
    ("n5-634" . -9.999992781836)
    ("n5-635" . -9.999992781836)
    ("n5-636" . -9.999992781836)
    ("n5-683" . -8.000014328290)
    ("n5-684" . -8.000014328290)
    ("n5-685" . -8.000014328290)
    ("n5-686" . -8.000014328290)
    ("n5-691" . -8.000014328290)
    ("n5-692" . -8.000014328290)
    ("n5-693" . -8.000014328290)
    ("n5-694" . -8.000014328290)
    ("n5-699" . -8.000014328290)
    ("n5-700" . -8.000014328290)
    ("n5-701" . -8.000014328290)
    ("n5-702" . -8.000014328290)
    ("n5-819" . -9.000010723526)
    ("n5-820" . -9.000010723526)
    ("n5-822" . -8.999982031484)
    ("n5-823" . -8.999982031484)
    ("n5-824" . -8.999982031484)
    ("n5-829" . 4.750011635971)
    ("n5-888" . 7.322443563451)
    ("n5-889" . 7.322443563451)
    ("n5-890" . 7.322443563451)
    ("n5-891" . 7.322443563451)
    ("n5-892" . 7.322443563451)
    ("n5-893" . 7.322443563451)
    ("n6-107" . -12.999996376494)
    ("n6-108" . -12.999996376494)
    ("n6-109" . -11.000003561402)
    ("n6-111" . -11.000003561402)
    ("n6-122" . -15.999985607952)
    ("n6-123" . -15.999985607952)
    ("n6-124" . -15.999985607952)
    ("n6-125" . -15.999985607952)
    ("n6-126" . -15.999985607952)
    ("n6-127" . -15.999985607952)
    ("n6-128" . -15.999985607952)
    ("n6-129" . -15.999985607952)
    ("n6-130" . -15.999985607952)
    ("n6-131" . -15.999985607952)
    ("n6-132" . -15.999985607952)
    ("n6-133" . -15.999985607952)
    ("n6-134" . -12.999996385314)
    ("n6-135" . -12.999996385314)
    ("n6-143" . -8.999996400564)
    ("n6-148" . -11.999985623203)
    ("n6-149" . -11.999985623203)
    ("n6-150" . -11.999985623203)
    ("n6-151" . -11.999985623203)
    ("n6-152" . -11.999985623203)
    ("n6-153" . -11.999985623203)
    ("n6-172" . -10.000007119864)
    ("n6-175" . -10.000007128684)
    ("n6-18" . -8.000001731184)
    ("n6-22" . -7.999996426842)
    ("n6-35" . -18.000007114719)
    ("n6-46" . -8.000014331230)
    ("n6-47" . -8.000014331230)
    ("n6-51" . -8.000001731184)
    ("n6-55" . -7.999982031500)
    ("n6-69" . -15.000003508853)
    ("n6-7" . -13.000010720770)
    ("n6-78" . -10.000007151835)
    ("n6-82" . -10.000002617263)
    ("n6-86" . -9.999992775405)
    ("n6-90" . -10.999996386968)
    ("n6-91" . -16.199140835075)
    ("n6-92" . -16.199140835075)
    ("n6-95" . -13.199137257872)
    ("n6-96" . -13.199137257872)
  ))
#(define (op47-source-flag-length target)
   (lambda (stem)
     (abs (- target (ly:grob-property stem 'stem-begin-position)))))
#(define concerto-source-special-beam-positions
  '(
    ("n1-301" -7.135475029838 -8.240419353572)
    ("n6-15" 0.582843499247 -1.162307170815)
    ("n6-48" 0.587293955236 -1.162557832309)
    ("n6-52" 0.591804719292 -1.162752025103)
    ("n6-56" 0.594016406519 -1.162892050129)
    ("n1-922" 2.999999985071 2.999999985071)
    ("n6-79" -0.423900009029 -2.147883819170)
    ("n6-83" -0.379004468249 -2.150020694483)
    ("n6-87" -0.379003552125 -2.150021787162)
  ))
#(define concerto-source-chord-beam-notes (make-hash-table))
#(define (concerto-starting-beam-event? event)
   (and (eq? (ly:music-property event 'name) 'BeamEvent)
        (= (ly:music-property event 'span-direction 0) START)))
#(define (concerto-set-source-beam-event! beam ref)
   (set! (ly:music-property beam 'tweaks)
     (acons 'positions (cons (cadr ref) (caddr ref)) (ly:music-property beam 'tweaks))))
#(define (concerto-special-beam-properties nid music)
   (let ((target (hash-ref op47-source-flag-tip-targets nid #f)))
     (when target
       (set! (ly:music-property music 'tweaks)
         (acons (cons 'Stem 'length) (op47-source-flag-length target)
           (ly:music-property music 'tweaks)))))
   (let ((ref (assoc nid concerto-source-special-beam-positions)))
     (when ref
       (let ((starts (filter concerto-starting-beam-event?
                       (ly:music-property music 'articulations))))
         (cond ((= (length starts) 1)
                 (concerto-set-source-beam-event! (car starts) ref))
               ((null? starts)
                 (hashq-set! concerto-source-chord-beam-notes music ref))
               (else (ly:error "Source beam ~a has multiple starts" nid)))))))
#(define (concerto-complete-special-beam-events music)
   (music-map
     (lambda (m)
       (when (eq? (ly:music-property m 'name) 'EventChord)
         (let* ((elements (ly:music-property m 'elements))
                (notes (filter (lambda (n) (eq? (ly:music-property n 'name) 'NoteEvent)) elements))
                (pending (filter-map (lambda (n)
                            (let ((r (hashq-ref concerto-source-chord-beam-notes n #f)))
                              (and r (cons n r)))) notes)))
           (when (pair? pending)
             (let ((starts (filter concerto-starting-beam-event?
                             (append elements (ly:music-property m 'articulations)))))
               (unless (= (length starts) 1)
                 (ly:error "Source chord beam expected one starting BeamEvent"))
               (for-each (lambda (p)
                 (concerto-set-source-beam-event! (car starts) (cdr p))
                 (hashq-remove! concerto-source-chord-beam-notes (car p))) pending)))))
       m) music))
#(define op47-source-rest-targets
  '(
    ("op47-rest-0090" 105.306899323097 0.777980193789)
    ("op47-rest-0092" 14.814781549176 0.792088718251)
    ("op47-rest-0050" 68.450256121377 -1.179694303467)
  ))
#(define op47-source-positioned-rests (make-hash-table))
#(define (op47-source-rest-positioner grob)
   (let* ((attrs (ly:grob-property grob 'output-attributes '()))
          (sid (assoc-get 'data-sid attrs #f))
          (ref (and sid (assoc sid op47-source-rest-targets)))
          (staff (ly:grob-object grob 'staff-symbol))
          (system (ly:grob-system grob)))
     (when (and ref (ly:grob? staff) (ly:grob? system)
                (not (hashq-ref op47-source-positioned-rests grob #f)))
       (hashq-set! op47-source-positioned-rests grob #t)
       (concerto-place-columns system)
       (let* ((left (ly:spanner-bound staff LEFT))
              (space (ly:staff-symbol-staff-space staff))
              (origin (ly:grob-relative-coordinate left system X))
              (stencil (ly:grob-property grob 'stencil)))
         (when (ly:stencil? stencil)
           (let* ((xx (stencil-true-extent stencil X)) (yy (stencil-true-extent stencil Y))
                  (now-x (+ (ly:grob-relative-coordinate grob system X) (car xx)))
                  (common (ly:grob-common-refpoint grob staff Y))
                  (now-y (+ (- (ly:grob-relative-coordinate grob common Y)
                               (ly:grob-relative-coordinate staff common Y)) (cdr yy))))
             (ly:grob-translate-axis! grob (- (+ origin (* space (cadr ref))) now-x) X)
             (ly:grob-translate-axis! grob (- (* space (caddr ref)) now-y) Y)))))))
% OP47_REFERENCE_CLEF_X_POSITIONS
% Op.47 source PDF clef X positions, generated from actual paint origins.
% Native glyphs, vertical positions, source ClefEvents and other grobs are retained.
% Positions use each own StaffSymbol left bound and a common X reference point.
#(define op47-source-clef-x-targets
  '(
    ((0 1 0 "clefs.G") . 0.850937710203)
    ((0 2 0 "clefs.F") . 0.850937710203)
    ((9/2 1 9/2 "clefs.G") . 0.850937710203)
    ((9/2 2 9/2 "clefs.F") . 0.850937710203)
    ((9/2 2 25/4 "clefs.G_change") . 58.073493358210)
    ((9/2 2 27/4 "clefs.F_change") . 76.865291088163)
    ((33/4 1 33/4 "clefs.G") . 0.850937710203)
    ((33/4 2 33/4 "clefs.F") . 0.850937710203)
    ((33/4 2 147/16 "clefs.G_change") . 35.103394004537)
    ((33/4 2 39/4 "clefs.F_change") . 51.404585012412)
    ((12 1 12 "clefs.G") . 0.850937710203)
    ((12 2 12 "clefs.F") . 0.850937710203)
    ((63/4 1 63/4 "clefs.G") . 0.850937710203)
    ((63/4 2 63/4 "clefs.F") . 0.850937710203)
    ((39/2 1 39/2 "clefs.G") . 0.850937530088)
    ((39/2 2 39/2 "clefs.F") . 0.850938090446)
    ((93/4 1 93/4 "clefs.G") . 0.850937710203)
    ((93/4 2 93/4 "clefs.F") . 0.850936949717)
    ((105/4 1 105/4 "clefs.G") . 0.850937710203)
    ((105/4 2 105/4 "clefs.F") . 0.850937710203)
    ((123/4 1 123/4 "clefs.G") . 0.850937710203)
    ((123/4 1 141/4 "clefs.F_change") . 125.763477561320)
    ((123/4 2 123/4 "clefs.F") . 0.850937710203)
    ((123/4 2 34 "clefs.G_change") . 99.117306922538)
    ((123/4 2 279/8 "clefs.F_change") . 119.638901492916)
    ((141/4 1 141/4 "clefs.F") . 0.850937710203)
    ((141/4 1 147/4 "clefs.G_change") . 41.934699131422)
    ((141/4 2 141/4 "clefs.F") . 0.850937710203)
    ((141/4 2 147/4 "clefs.G_change") . 41.934699131422)
    ((141/4 2 159/4 "clefs.F_change") . 88.013182539505)
    ((165/4 1 165/4 "clefs.G") . 0.850937530088)
    ((165/4 2 165/4 "clefs.F") . 0.850938090446)
    ((45 1 45 "clefs.G") . 0.850937710203)
    ((45 2 45 "clefs.F") . 0.850936949717)
    ((195/4 1 195/4 "clefs.G") . 0.850937710203)
    ((195/4 2 195/4 "clefs.F") . 0.850937710203)
    ((105/2 1 105/2 "clefs.G") . 0.850937710203)
    ((105/2 2 105/2 "clefs.F") . 0.850937710203)
    ((225/4 1 225/4 "clefs.G") . 0.850937710203)
    ((225/4 2 225/4 "clefs.F") . 0.850937710203)
    ((60 1 60 "clefs.G") . 0.850937530088)
    ((60 2 60 "clefs.F") . 0.850938090446)
    ((255/4 1 255/4 "clefs.G") . 0.850937710203)
    ((255/4 2 255/4 "clefs.F") . 0.850937710203)
    ((135/2 1 135/2 "clefs.G") . 0.850937710203)
    ((135/2 1 271/4 "clefs.F_change") . 15.718908851083)
    ((135/2 2 135/2 "clefs.F") . 0.850937710203)
    ((285/4 1 285/4 "clefs.F") . 0.850937710203)
    ((285/4 1 72 "clefs.G_change") . 31.985679406706)
    ((285/4 2 285/4 "clefs.F") . 0.850937710203)
    ((75 1 75 "clefs.G") . 0.850937710203)
    ((75 2 75 "clefs.F") . 0.850937710203)
    ((75 2 78 "clefs.F_change") . 103.303090863200)
    ((315/4 1 315/4 "clefs.G") . 0.850937530088)
    ((315/4 2 315/4 "clefs.F") . 0.850938090446)
    ((165/2 1 165/2 "clefs.G") . 0.850937710203)
    ((165/2 2 165/2 "clefs.F") . 0.850936949717)
    ((345/4 1 345/4 "clefs.G") . 0.850937710203)
    ((345/4 2 345/4 "clefs.F") . 0.850937710203)
    ((357/4 1 357/4 "clefs.G") . 0.850937710203)
    ((357/4 2 357/4 "clefs.F") . 0.850937710203)
    ((357/4 2 735/8 "clefs.G_change") . 111.114787650652)
    ((357/4 2 369/4 "clefs.F_change") . 125.756242860623)
    ((369/4 1 369/4 "clefs.G") . 0.850937710203)
    ((369/4 2 369/4 "clefs.F") . 0.850937710203)
    ((381/4 1 381/4 "clefs.G") . 0.850937530088)
    ((381/4 2 381/4 "clefs.F") . 0.850937710203)
    ((381/4 2 777/8 "clefs.G_change") . 106.963260879067)
    ((195/2 1 195/2 "clefs.G") . 0.799999639579)
    ((195/2 2 195/2 "clefs.G") . 0.799999639579)
    ((195/2 2 393/4 "clefs.F_change") . 41.149848942242)
    ((195/2 2 197/2 "clefs.G_change") . 55.259912515056)
    ((195/2 2 399/4 "clefs.F_change") . 104.490852156612)
    ((201/2 1 201/2 "clefs.G") . 0.850937710203)
    ((201/2 2 201/2 "clefs.F") . 0.850937710203)
    ((207/2 1 207/2 "clefs.G") . 0.850937710203)
    ((207/2 2 207/2 "clefs.F") . 0.850937710203)
    ((213/2 1 213/2 "clefs.G") . 0.850937710203)
    ((213/2 2 213/2 "clefs.F") . 0.850937710203)
    ((441/4 1 441/4 "clefs.G") . 0.850937530088)
    ((441/4 2 441/4 "clefs.F") . 0.850938090446)
    ((114 1 114 "clefs.G") . 0.850937710203)
    ((114 2 114 "clefs.F") . 0.850937710203)
    ((471/4 1 471/4 "clefs.G") . 0.850937710203)
    ((471/4 2 471/4 "clefs.F") . 0.850937710203)
    ((120 1 120 "clefs.G") . 0.850937710203)
    ((120 2 120 "clefs.F") . 0.850937710203)
    ((123 1 123 "clefs.G") . 0.850937710203)
    ((123 2 123 "clefs.F") . 0.850937710203)
    ((126 1 126 "clefs.G") . 0.850937530088)
    ((126 2 126 "clefs.F") . 0.850938090446)
    ((129 1 129 "clefs.G") . 0.850937710203)
    ((129 2 129 "clefs.F") . 0.850936949717)
    ((129 2 1037/8 "clefs.G_change") . 31.268605059851)
    ((129 2 519/4 "clefs.F_change") . 37.675073936453)
    ((129 2 130 "clefs.G_change") . 48.793880279719)
    ((129 2 1041/8 "clefs.F_change") . 55.184293589855)
    ((132 1 132 "clefs.G") . 0.850937710203)
    ((132 2 132 "clefs.F") . 0.850937710203)
    ((132 2 133 "clefs.G_change") . 57.170045754022)
    ((132 2 1065/8 "clefs.F_change") . 65.045577291479)
    ((132 2 1067/8 "clefs.G_change") . 77.348781542329)
    ((132 2 267/2 "clefs.F_change") . 85.224320257068)
    ((132 2 1069/8 "clefs.G_change") . 93.183359475692)
    ((132 2 535/4 "clefs.F_change") . 99.732400027490)
    ((132 2 134 "clefs.G_change") . 112.845058191717)
    ((132 2 1073/8 "clefs.F_change") . 119.394098743515)
    ((537/4 1 537/4 "clefs.G") . 0.850937710203)
    ((537/4 2 537/4 "clefs.F") . 0.850937710203)
    ((273/2 1 273/2 "clefs.G") . 0.850937710203)
    ((273/2 1 139 "clefs.F_change") . 106.168972563482)
    ((273/2 2 273/2 "clefs.F") . 0.850937710203)
    ((279/2 1 279/2 "clefs.F") . 0.850937530088)
    ((279/2 1 565/4 "clefs.G_change") . 74.299296407876)
    ((279/2 2 279/2 "clefs.F") . 0.850937329960)
    ((285/2 1 285/2 "clefs.G") . 0.850937710203)
    ((285/2 2 285/2 "clefs.F") . 0.850936949717)
    ((579/4 1 579/4 "clefs.G") . 0.850937710203)
    ((579/4 1 145 "clefs.F_change") . 19.134150515106)
    ((579/4 1 589/4 "clefs.G_change") . 107.253617840104)
    ((579/4 2 579/4 "clefs.F") . 0.850937710203)
    ((591/4 1 591/4 "clefs.G") . 0.850937710203)
    ((591/4 2 591/4 "clefs.F") . 0.850937710203)
    ((150 1 150 "clefs.G") . 0.850937710203)
    ((150 2 150 "clefs.F") . 0.850937710203)
    ((609/4 1 609/4 "clefs.G") . 0.850937530088)
    ((609/4 2 609/4 "clefs.F") . 0.850938090446)
    ((621/4 1 621/4 "clefs.G") . 0.850937710203)
    ((621/4 2 621/4 "clefs.F") . 0.850936949717)
    ((627/4 1 627/4 "clefs.G") . 0.850937710203)
    ((627/4 2 627/4 "clefs.F") . 0.850937710203)
    ((159 1 159 "clefs.G") . 0.850937710203)
    ((159 2 159 "clefs.F") . 0.850937710203)
    ((159 2 1273/8 "clefs.G_change") . 15.050416764791)
    ((159 2 639/4 "clefs.F_change") . 46.509057554645)
    ((159 2 1279/8 "clefs.G_change") . 55.037510064144)
    ((159 2 321/2 "clefs.F_change") . 87.349721728202)
    ((645/4 1 645/4 "clefs.G") . 0.850937710203)
    ((645/4 2 645/4 "clefs.F") . 0.850937710203)
    ((327/2 1 327/2 "clefs.G") . 0.850937530088)
    ((327/2 2 327/2 "clefs.F") . 0.850938090446)
    ((333/2 1 333/2 "clefs.G") . 0.850937710203)
    ((333/2 2 333/2 "clefs.F") . 0.850936949717)
    ((675/4 1 675/4 "clefs.G") . 0.850937710203)
    ((675/4 2 675/4 "clefs.F") . 0.850937710203)
    ((687/4 1 687/4 "clefs.G") . 0.850937710203)
    ((687/4 2 687/4 "clefs.F") . 0.850937710203)
    ((174 1 174 "clefs.G") . 0.850937710203)
    ((174 2 174 "clefs.F") . 0.850937710203)
    ((174 2 353/2 "clefs.G_change") . 108.322114231240)
    ((177 1 177 "clefs.G") . 0.799999470245)
    ((177 2 177 "clefs.G") . 0.799999997060)
    ((177 2 711/4 "clefs.F_change") . 43.798016585063)
   ))

#(define op47-source-clefs-positioned (make-hash-table))
#(define (op47SourceClefXAfterLineBreaking grob)
  (unless (hashq-ref op47-source-clefs-positioned grob #f)
    (let ((stencil (ly:grob-property grob 'stencil #f)))
      (when (and (ly:stencil? stencil) (not (ly:stencil-empty? stencil)))
        (let* ((attrs (ly:grob-property grob 'output-attributes '()))
               (staff-id (assoc-get 'data-clef-staff attrs #f))
               (staff-number (and staff-id (string->number staff-id)))
               (system (ly:grob-system grob))
               (staff (ly:grob-object grob 'staff-symbol))
               (column (concerto-paper-column-of grob))
               (when (and (ly:grob? column) (ly:grob-property column 'when)))
               (array (and (ly:grob? system) (ly:grob-object system 'columns)))
               (columns (if (ly:grob-array? array) (ly:grob-array->list array) '()))
               (first-moment (and (pair? columns) (ly:grob-property (car columns) 'when)))
               (start (and (ly:moment? first-moment) (ly:moment-main first-moment)))
               (moment (and (ly:moment? when) (ly:moment-main when)))
               (glyph (ly:grob-property grob 'glyph-name ""))
               (key (list start staff-number moment glyph))
               (entry (assoc key op47-source-clef-x-targets)))
          (if (and entry (ly:grob? staff) (ly:grob? system))
            (begin
              (concerto-place-columns system)
              (let* ((left (ly:spanner-bound staff LEFT))
                     (reference (ly:grob-common-refpoint left grob X))
                     (origin (ly:grob-relative-coordinate left reference X))
                     (space (ly:staff-symbol-staff-space staff))
                     (target (+ origin (* space (cdr entry))))
                     (now (ly:grob-relative-coordinate grob reference X)))
                (ly:grob-translate-axis! grob (- target now) X)
                (hashq-set! op47-source-clefs-positioned grob #t)
                (if (ly:get-option 'op47-clef-debug)
                  (ly:message "OP47CLEFX ~a delta ~a" key (- target now)))))
            (ly:warning "Source clef X target missing: ~a" key)))))))
#(define opFortySevenSourceClefPositionsEngraver
  (lambda (context)
    (make-engraver
      (acknowledgers
        ((clef-interface engraver grob source)
          (let ((attrs (ly:grob-property grob 'output-attributes '())))
            (ly:grob-set-property! grob 'output-attributes
              (acons 'data-clef-staff (ly:context-id context) attrs)))
          (ly:grob-set-property! grob 'after-line-breaking op47SourceClefXAfterLineBreaking))))))

% OP47_SOURCE_BAR_KEY_GEOMETRY
% Actual source geometry for all 241 measure boundaries and 116 native key-signature grobs.
% Native BarLine/SpanBar printing and native key glyph shapes are retained; no music events change.
#(define op47-source-bar-key-data
  '(
    (0 (
      (3/4 "|" ((30.261778703804 . 0.160000003315)))
      (3/2 "|" ((46.709705662487 . 0.160000003315)))
      (9/4 "|" ((68.715400752225 . 0.160000003315)))
      (3 "|" ((86.406189001597 . 0.160000003315)))
      (15/4 "|" ((110.067995361609 . 0.160000003315)))
      (9/2 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (0 1 ("accidentals.flat" 4.482188531787 -0.746093033053 5.376719874024 1.839844576455) ("accidentals.flat" 5.482188908083 0.753906355466 6.376720250320 3.339843964974) ("accidentals.flat" 6.482189284379 -1.245468804519 7.376720626616 1.340468804989) ("accidentals.flat" 7.482189660676 0.253905461762 8.376721002912 2.839843071270))
      (0 2 ("accidentals.flat" 4.482188531787 -1.746094632312 5.376719874024 0.839842977196) ("accidentals.flat" 5.482188908083 -0.246095243793 6.376720250320 2.339842365715) ("accidentals.flat" 6.482189284379 -2.246095996386 7.376720626616 0.339841613122) ("accidentals.flat" 7.482189660676 -0.746094256016 8.376721002912 1.839843353492))
    ))
    (9/2 (
      (21/4 "|" ((33.482688268531 . 0.160000003315)))
      (6 "|" ((50.644690234270 . 0.160000003315)))
      (27/4 "|" ((79.546285992837 . 0.160000003315)))
      (15/2 "|" ((103.325103588438 . 0.160000003315)))
      (33/4 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (9/2 1 ("accidentals.flat" 4.482188531787 -0.746094938053 5.376719874024 1.839842671455) ("accidentals.flat" 5.482188908083 0.753906802318 6.376720250320 3.339844411826) ("accidentals.flat" 6.482189284379 -1.245468357667 7.376720626616 1.340469251841) ("accidentals.flat" 7.482189660676 0.253905438244 8.376721002912 2.839843047752))
      (9/2 2 ("accidentals.flat" 4.482188531787 -1.746093621016 5.376719874024 0.839843988492) ("accidentals.flat" 5.482188908083 -0.246098936201 6.376720250320 2.339838673307) ("accidentals.flat" 6.482189284379 -2.246097336942 7.376720626616 0.339840272566) ("accidentals.flat" 7.482189660676 -0.746090892867 8.376721002912 1.839846716641))
    ))
    (33/4 (
      (9 "|" ((28.848596912216 . 0.160000003315)))
      (39/4 "|" ((54.085579917086 . 0.160000003315)))
      (21/2 "|" ((88.428567760614 . 0.160000003315)))
      (45/4 "|" ((108.300309647193 . 0.160000003315)))
      (12 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (33/4 1 ("accidentals.flat" 4.482188531787 -0.746096137497 5.376719874024 1.839841472011) ("accidentals.flat" 5.482188908083 0.753905602873 6.376720250320 3.339843212381) ("accidentals.flat" 6.482189284379 -1.245467205260 7.376720626616 1.340470404249) ("accidentals.flat" 7.482189660676 0.253899535095 8.376721002912 2.839837144603))
      (33/4 2 ("accidentals.flat" 4.482188531787 -1.746092468608 5.376719874024 0.839845140900) ("accidentals.flat" 5.482188908083 -0.246095431942 6.376720250320 2.339842177567) ("accidentals.flat" 6.482189284379 -2.246098536386 7.376720626616 0.339839073122) ("accidentals.flat" 7.482189660676 -0.746096796016 8.376721002912 1.839840813492))
    ))
    (12 (
      (51/4 "|" ((30.540878097336 . 0.160000003315)))
      (27/2 "|" ((52.425976898907 . 0.160000003315)))
      (57/4 "|" ((76.224374120999 . 0.160000003315)))
      (15 "|" ((101.918183975777 . 0.160000003315)))
      (63/4 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (12 1 ("accidentals.flat" 4.482188531787 -0.746090422497 5.376719874024 1.839847187011) ("accidentals.flat" 5.482188908083 0.753906614170 6.376720250320 3.339844223678) ("accidentals.flat" 6.482189284379 -1.245473249519 7.376720626616 1.340464359989) ("accidentals.flat" 7.482189660676 0.253907601947 8.376721002912 2.839845211455))
      (12 2 ("accidentals.flat" 4.482188531787 -1.746098512868 5.376719874024 0.839839096641) ("accidentals.flat" 5.482188908083 -0.246087365090 6.376720250320 2.339850244419) ("accidentals.flat" 6.482189284379 -2.246102228794 7.376720626616 0.339835380715) ("accidentals.flat" 7.482189660676 -0.746107543979 8.376721002912 1.839830065529))
    ))
    (63/4 (
      (33/2 "|" ((36.723672692237 . 0.160000003315)))
      (69/4 "|" ((60.747282271316 . 0.160000003315)))
      (18 "|" ((85.080279375816 . 0.160000003315)))
      (75/4 "|" ((104.644201973186 . 0.160000003315)))
      (39/2 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (63/4 1 ("accidentals.flat" 4.482188531787 -0.746091621942 5.376719874024 1.839845987567) ("accidentals.flat" 5.482188908083 0.753912470281 6.376720250320 3.339850079789) ("accidentals.flat" 6.482189284379 -1.245467393408 7.376720626616 1.340470216100) ("accidentals.flat" 7.482189660676 0.253908754355 8.376721002912 2.839846363863))
      (63/4 2 ("accidentals.flat" 4.482188531787 -1.746104439534 5.376719874024 0.839833169974) ("accidentals.flat" 5.482188908083 -0.246093291756 6.376720250320 2.339844317752) ("accidentals.flat" 6.482189284379 -2.246101099905 7.376720626616 0.339836509603) ("accidentals.flat" 7.482189660676 -0.746099359534 8.376721002912 1.839838249974))
    ))
    (39/2 (
      (81/4 "|" ((32.053153431605 . 0.159999969448)))
      (21 "|" ((54.144343222419 . 0.159999969448)))
      (87/4 "|" ((77.367519405214 . 0.159999969448)))
      (45/2 "|" ((100.590702765290 . 0.159999969448)))
      (93/4 "|" ((128.444438101305 . 0.159999969448)))
    ) (
      (39/2 1 ("accidentals.flat" 4.482187583057 -0.746094780129 5.376718735951 1.839842282022) ("accidentals.flat" 5.482187747687 0.753906642741 6.376718900581 3.339843704892) ("accidentals.flat" 6.482187912316 -1.245468094043 7.376719065211 1.340468968108) ("accidentals.flat" 7.482188076946 0.253906325241 8.376719229840 2.839843387392))
      (39/2 2 ("accidentals.flat" 4.482190534662 -1.746095412558 5.376722276622 0.839843352482) ("accidentals.flat" 5.482191357811 -0.246095353762 6.376723099770 2.339843411278) ("accidentals.flat" 6.482192180959 -2.246096294503 7.376723922919 0.339842470537) ("accidentals.flat" 7.482193004108 -0.746094589409 8.376724746067 1.839844175630))
    ))
    (93/4 (
      (24 "|" ((37.354157479378 . 0.160000003315)))
      (99/4 "|" ((65.062422373361 . 0.160000003315)))
      (51/2 "|" ((98.035252644876 . 0.160000003315)))
      (105/4 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (93/4 1 ("accidentals.flat" 4.482188531787 -0.746095337868 5.376719874024 1.839842271641) ("accidentals.flat" 5.482188908083 0.753904050651 6.376720250320 3.339841660159) ("accidentals.flat" 6.482189284379 -1.245468757482 7.376720626616 1.340468852026) ("accidentals.flat" 7.482189660676 0.253905038429 8.376721002912 2.839842647937))
      (93/4 2 ("accidentals.flat" 4.482184526042 -1.746092295712 5.376715068833 0.839843002736) ("accidentals.flat" 5.482184008635 -0.246091895897 6.376714551426 2.339843402551) ("accidentals.flat" 6.482183491228 -2.246090861083 7.376714034019 0.339844437365) ("accidentals.flat" 7.482182973821 -0.746085757569 8.376713516612 1.839849540879))
    ))
    (105/4 (
      (27 "|" ((28.391899253392 . 0.160000003315)))
      (111/4 "|" ((49.822711963038 . 0.160000003315)))
      (57/2 "|" ((65.974525780169 . 0.160000003315)))
      (117/4 "|" ((87.684111316997 . 0.160000003315)))
      (30 "|" ((105.078786424817 . 0.160000003315)))
      (123/4 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (105/4 1 ("accidentals.flat" 4.482188531787 -0.746095431942 5.376719874024 1.839842177567) ("accidentals.flat" 5.482188908083 0.753906308429 6.376720250320 3.339843917937) ("accidentals.flat" 6.482189284379 -1.245468851556 7.376720626616 1.340468757952) ("accidentals.flat" 7.482189660676 0.253900240651 8.376721002912 2.839837850159))
      (105/4 2 ("accidentals.flat" 4.482188531787 -1.746091786571 5.376719874024 0.839845822937) ("accidentals.flat" 5.482188908083 -0.246097101756 6.376720250320 2.339840507752) ("accidentals.flat" 6.482189284379 -2.246097854349 7.376720626616 0.339839755159) ("accidentals.flat" 7.482189660676 -0.746096113979 8.376721002912 1.839841495529))
    ))
    (123/4 (
      (63/2 "|" ((32.850951045605 . 0.160000003315)))
      (129/4 "|" ((53.510729834765 . 0.160000003315)))
      (33 "|" ((75.486506422660 . 0.160000003315)))
      (135/4 "|" ((95.036849601657 . 0.160000003315)))
      (69/2 "|" ((113.955340721209 . 0.160000003315)))
      (141/4 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (123/4 1 ("accidentals.flat" 4.482188531787 -0.746097266386 5.376719874024 1.839840343122) ("accidentals.flat" 5.482188908083 0.753909177688 6.376720250320 3.339846787196) ("accidentals.flat" 6.482189284379 -1.245470686000 7.376720626616 1.340466923508) ("accidentals.flat" 7.482189660676 0.253907813614 8.376721002912 2.839845423122))
      (123/4 2 ("accidentals.flat" 4.482188531787 -1.746102910831 5.376719874024 0.839834698677) ("accidentals.flat" 5.482188908083 -0.246094114905 6.376720250320 2.339843494604) ("accidentals.flat" 6.482189284379 -2.246090163793 7.376720626616 0.339847445715) ("accidentals.flat" 7.482189660676 -0.746102534534 8.376721002912 1.839835074974))
    ))
    (141/4 (
      (36 "|" ((28.112103663463 . 0.160000003315)))
      (147/4 "|" ((44.530700657463 . 0.160000003315)))
      (75/2 "|" ((52.312453822582 . 0.160000003315)))
      (153/4 "|" ((60.094214164984 . 0.160000003315)))
      (39 "|" ((76.791867488821 . 0.160000003315)))
      (159/4 "|" ((90.898313711285 . 0.160000003315)))
      (81/2 "|" ((107.595967035122 . 0.160000003315)))
      (165/4 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (141/4 1 ("accidentals.flat" 4.482188531787 -1.746104180831 5.376719874024 0.839833428677) ("accidentals.flat" 5.482188908083 -0.246095384905 6.376720250320 2.339842224604) ("accidentals.flat" 6.482189284379 -2.246100841201 7.376720626616 0.339836768307) ("accidentals.flat" 7.482189660676 -0.746092045275 8.376721002912 1.839845564233))
      (141/4 2 ("accidentals.flat" 4.482188531787 -1.746098042497 5.376719874024 0.839839567011) ("accidentals.flat" 5.482188908083 -0.246086894719 6.376720250320 2.339850714789) ("accidentals.flat" 6.482189284379 -2.246101758423 7.376720626616 0.339835851085) ("accidentals.flat" 7.482189660676 -0.746090610645 8.376721002912 1.839846998863))
    ))
    (165/4 (
      (42 "|" ((31.563713113897 . 0.159999969448)))
      (171/4 "|" ((59.122627281603 . 0.159999969448)))
      (87/2 "|" ((80.172623284062 . 0.159999969448)))
      (177/4 "|" ((105.373470514959 . 0.159999969448)))
      (45 "|" ((128.444438101305 . 0.159999969448)))
    ) (
      (165/4 1 ("accidentals.flat" 4.482187583057 -0.746094780129 5.376718735951 1.839842282022) ("accidentals.flat" 5.482187747687 0.753906642741 6.376718900581 3.339843704892) ("accidentals.flat" 6.482187912316 -1.245468094043 7.376719065211 1.340468968108) ("accidentals.flat" 7.482188076946 0.253906325241 8.376719229840 2.839843387392))
      (165/4 2 ("accidentals.flat" 4.482190534662 -1.746095412558 5.376722276622 0.839843352482) ("accidentals.flat" 5.482191357811 -0.246095353762 6.376723099770 2.339843411278) ("accidentals.flat" 6.482192180959 -2.246096294503 7.376723922919 0.339842470537) ("accidentals.flat" 7.482193004108 -0.746094589409 8.376724746067 1.839844175630))
    ))
    (45 (
      (183/4 "|" ((36.372621042262 . 0.160000003315)))
      (93/2 "|" ((62.319473166681 . 0.160000003315)))
      (189/4 "|" ((84.081481574437 . 0.160000003315)))
      (48 "|" ((105.470264118125 . 0.160000003315)))
      (195/4 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (45 1 ("accidentals.flat" 4.482188531787 -0.746095337868 5.376719874024 1.839842271641) ("accidentals.flat" 5.482188908083 0.753904050651 6.376720250320 3.339841660159) ("accidentals.flat" 6.482189284379 -1.245468757482 7.376720626616 1.340468852026) ("accidentals.flat" 7.482189660676 0.253905038429 8.376721002912 2.839842647937))
      (45 2 ("accidentals.flat" 4.482184526042 -1.746093753859 5.376715068833 0.839841544590) ("accidentals.flat" 5.482184008635 -0.246091002194 6.376714551426 2.339844296254) ("accidentals.flat" 6.482183491228 -2.246089967380 7.376714034019 0.339845331068) ("accidentals.flat" 7.482182973821 -0.746087215716 8.376713516612 1.839848082732))
    ))
    (195/4 (
      (99/2 "|" ((32.539356505834 . 0.160000003315)))
      (201/4 "|" ((56.743442440462 . 0.160000003315)))
      (51 "|" ((81.291592940611 . 0.160000003315)))
      (207/4 "|" ((105.994277508936 . 0.160000003315)))
      (105/2 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (195/4 1 ("accidentals.flat" 4.482188531787 -0.746096890090 5.376719874024 1.839840719418) ("accidentals.flat" 5.482188908083 0.753904850281 6.376720250320 3.339842459789) ("accidentals.flat" 6.482189284379 -1.245470309704 7.376720626616 1.340467299804) ("accidentals.flat" 7.482189660676 0.253901134355 8.376721002912 2.839838743863))
      (195/4 2 ("accidentals.flat" 4.482188531787 -1.746100159164 5.376719874024 0.839837450344) ("accidentals.flat" 5.482188908083 -0.246098418794 6.376720250320 2.339839190715) ("accidentals.flat" 6.482189284379 -2.246094467682 7.376720626616 0.339843141826) ("accidentals.flat" 7.482189660676 -0.746095079164 8.376721002912 1.839842530344))
    ))
    (105/2 (
      (213/4 "|" ((33.148987698850 . 0.160000003315)))
      (54 "|" ((59.308997934400 . 0.160000003315)))
      (219/4 "|" ((82.273638964779 . 0.160000003315)))
      (111/2 "|" ((105.967642613808 . 0.160000003315)))
      (225/4 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (105/2 1 ("accidentals.flat" 4.482188531787 -0.746096490275 5.376719874024 1.839841119233) ("accidentals.flat" 5.482188908083 0.753905250095 6.376720250320 3.339842859604) ("accidentals.flat" 6.482189284379 -1.245469909889 7.376720626616 1.340467699619) ("accidentals.flat" 7.482189660676 0.253899182318 8.376721002912 2.839836791826))
      (105/2 2 ("accidentals.flat" 4.482188531787 -1.746104463053 5.376719874024 0.839833146455) ("accidentals.flat" 5.482188908083 -0.246093315275 6.376720250320 2.339844294233) ("accidentals.flat" 6.482189284379 -2.246091716016 7.376720626616 0.339845893493) ("accidentals.flat" 7.482189660676 -0.746104086757 8.376721002912 1.839833522751))
    ))
    (225/4 (
      (57 "|" ((34.984793000887 . 0.160000003315)))
      (231/4 "|" ((59.211673984538 . 0.160000003315)))
      (117/2 "|" ((82.505702037853 . 0.160000003315)))
      (237/4 "|" ((105.957013058517 . 0.160000003315)))
      (60 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (225/4 1 ("accidentals.flat" 4.482188531787 -0.746093597497 5.376719874024 1.839844012011) ("accidentals.flat" 5.482188908083 0.753910494725 6.376720250320 3.339848104233) ("accidentals.flat" 6.482189284379 -1.245469368963 7.376720626616 1.340468240545) ("accidentals.flat" 7.482189660676 0.253906778799 8.376721002912 2.839844388307))
      (225/4 2 ("accidentals.flat" 4.482188531787 -1.746104063238 5.376719874024 0.839833546270) ("accidentals.flat" 5.482188908083 -0.246095267312 6.376720250320 2.339842342196) ("accidentals.flat" 6.482189284379 -2.246088964349 7.376720626616 0.339848645159) ("accidentals.flat" 7.482189660676 -0.746101335090 8.376721002912 1.839836274418))
    ))
    (60 (
      (243/4 "|" ((29.649288265252 . 0.159999969448)))
      (123/2 "|" ((57.176421433049 . 0.159999969448)))
      (249/4 "|" ((78.589566318166 . 0.159999969448)))
      (63 "|" ((106.446308934887 . 0.159999969448)))
      (255/4 "|" ((128.444438101305 . 0.159999969448)))
    ) (
      (60 1 ("accidentals.flat" 4.482187583057 -0.746094780129 5.376718735951 1.839842282022) ("accidentals.flat" 5.482187747687 0.753906642741 6.376718900581 3.339843704892) ("accidentals.flat" 6.482187912316 -1.245468094043 7.376719065211 1.340468968108) ("accidentals.flat" 7.482188076946 0.253906325241 8.376719229840 2.839843387392))
      (60 2 ("accidentals.flat" 4.482190534662 -1.746095412558 5.376722276622 0.839843352482) ("accidentals.flat" 5.482191357811 -0.246095353762 6.376723099770 2.339843411278) ("accidentals.flat" 6.482192180959 -2.246096294503 7.376723922919 0.339842470537) ("accidentals.flat" 7.482193004108 -0.746094589409 8.376724746067 1.839844175630))
    ))
    (255/4 (
      (129/2 "|" ((33.865861846058 . 0.160000003315)))
      (261/4 "|" ((58.396578727164 . 0.160000003315)))
      (66 "|" ((80.737485204536 . 0.160000003315)))
      (267/4 "|" ((103.881192254466 . 0.160000003315)))
      (135/2 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (255/4 1 ("accidentals.flat" 4.482188531787 -0.746095337868 5.376719874024 1.839842271641) ("accidentals.flat" 5.482188908083 0.753904050651 6.376720250320 3.339841660159) ("accidentals.flat" 6.482189284379 -1.245468757482 7.376720626616 1.340468852026) ("accidentals.flat" 7.482189660676 0.253905038429 8.376721002912 2.839842647937))
      (255/4 2 ("accidentals.flat" 4.482188531787 -1.746099641757 5.376719874024 0.839837967752) ("accidentals.flat" 5.482188908083 -0.246097901386 6.376720250320 2.339839708122) ("accidentals.flat" 6.482189284379 -2.246098653979 7.376720626616 0.339838955529) ("accidentals.flat" 7.482189660676 -0.746096913608 8.376721002912 1.839840695900))
    ))
    (135/2 (
      (273/4 "|" ((35.305154591156 . 0.160000003315)))
      (69 "|" ((60.124753501758 . 0.160000003315)))
      (279/4 "|" ((82.809365680530 . 0.160000003315)))
      (141/2 "|" ((108.737693238975 . 0.160000003315)))
      (285/4 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (135/2 1 ("accidentals.flat" 4.482188531787 -0.746095855275 5.376719874024 1.839841754233) ("accidentals.flat" 5.482188908083 0.753910588799 6.376720250320 3.339848198307) ("accidentals.flat" 6.482189284379 -1.245469274889 7.376720626616 1.340468334619) ("accidentals.flat" 7.482189660676 0.253906872873 8.376721002912 2.839844482381))
      (135/2 2 ("accidentals.flat" 4.482188531787 -1.746099241942 5.376719874024 0.839838367566) ("accidentals.flat" 5.482188908083 -0.246097501571 6.376720250320 2.339840107937) ("accidentals.flat" 6.482189284379 -2.246098254164 7.376720626616 0.339839355344) ("accidentals.flat" 7.482189660676 -0.746096513793 8.376721002912 1.839841095715))
    ))
    (285/4 (
      (72 "|" ((34.581680932747 . 0.160000003315)))
      (291/4 "|" ((56.119162413989 . 0.160000003315)))
      (147/2 "|" ((79.566769956916 . 0.160000003315)))
      (297/4 "|" ((102.619009719453 . 0.160000003315)))
      (75 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (285/4 1 ("accidentals.flat" 4.482188531787 -1.746088893793 5.376719874024 0.839848715715) ("accidentals.flat" 5.482188908083 -0.246098912682 6.376720250320 2.339838696826) ("accidentals.flat" 6.482189284379 -2.246092609719 7.376720626616 0.339844999789) ("accidentals.flat" 7.482189660676 -0.746095573053 8.376721002912 1.839842036455))
      (285/4 2 ("accidentals.flat" 4.482188531787 -1.746100770645 5.376719874024 0.839836838863) ("accidentals.flat" 5.482188908083 -0.246089622867 6.376720250320 2.339847986641) ("accidentals.flat" 6.482189284379 -2.246102134720 7.376720626616 0.339835474789) ("accidentals.flat" 7.482189660676 -0.746107449905 8.376721002912 1.839830159603))
    ))
    (75 (
      (303/4 "|" ((35.204460907190 . 0.160000003315)))
      (153/2 "|" ((64.446948872440 . 0.160000003315)))
      (309/4 "|" ((86.523193059904 . 0.160000003315)))
      (78 "|" ((106.188236389546 . 0.160000003315)))
      (315/4 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (75 1 ("accidentals.flat" 4.482188531787 -0.746089905090 5.376719874024 1.839847704418) ("accidentals.flat" 5.482188908083 0.753902427873 6.376720250320 3.339840037381) ("accidentals.flat" 6.482189284379 -1.245472732112 7.376720626616 1.340464877397) ("accidentals.flat" 7.482189660676 0.253903415651 8.376721002912 2.839841025159))
      (75 2 ("accidentals.flat" 4.482188531787 -1.746103381201 5.376719874024 0.839834228307) ("accidentals.flat" 5.482188908083 -0.246094585275 6.376720250320 2.339843024233) ("accidentals.flat" 6.482189284379 -2.246102393423 7.376720626616 0.339835216085) ("accidentals.flat" 7.482189660676 -0.746098301201 8.376721002912 1.839839308307))
    ))
    (315/4 (
      (159/2 "|" ((34.372685547160 . 0.159999969448)))
      (321/4 "|" ((55.912609922430 . 0.159999969448)))
      (81 "|" ((83.045559644875 . 0.159999969448)))
      (327/4 "|" ((103.669569670231 . 0.159999969448)))
      (165/2 "|" ((128.444438101305 . 0.159999969448)))
    ) (
      (315/4 1 ("accidentals.flat" 4.482187583057 -0.746094780129 5.376718735951 1.839842282022) ("accidentals.flat" 5.482187747687 0.753906642741 6.376718900581 3.339843704892) ("accidentals.flat" 6.482187912316 -1.245468094043 7.376719065211 1.340468968108) ("accidentals.flat" 7.482188076946 0.253906325241 8.376719229840 2.839843387392))
      (315/4 2 ("accidentals.flat" 4.482190534662 -1.746095412558 5.376722276622 0.839843352482) ("accidentals.flat" 5.482191357811 -0.246095353762 6.376723099770 2.339843411278) ("accidentals.flat" 6.482192180959 -2.246096294503 7.376723922919 0.339842470537) ("accidentals.flat" 7.482193004108 -0.746094589409 8.376724746067 1.839844175630))
    ))
    (165/2 (
      (333/4 "|" ((31.328498717537 . 0.160000003315)))
      (84 "|" ((58.142517283418 . 0.160000003315)))
      (339/4 "|" ((84.735532968463 . 0.160000003315)))
      (171/2 "|" ((106.779996149291 . 0.160000003315)))
      (345/4 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (165/2 1 ("accidentals.flat" 4.482188531787 -0.746095337868 5.376719874024 1.839842271641) ("accidentals.flat" 5.482188908083 0.753904050651 6.376720250320 3.339841660159) ("accidentals.flat" 6.482189284379 -1.245468757482 7.376720626616 1.340468852026) ("accidentals.flat" 7.482189660676 0.253905038429 8.376721002912 2.839842647937))
      (165/2 2 ("accidentals.flat" 4.482184526042 -1.746092883674 5.376715068833 0.839842414774) ("accidentals.flat" 5.482184008635 -0.246090132010 6.376714551426 2.339845166438) ("accidentals.flat" 6.482183491228 -2.246091449046 7.376714034019 0.339843849402) ("accidentals.flat" 7.482182973821 -0.746091049231 8.376713516612 1.839844249217))
    ))
    (345/4 (
      (87 "|" ((40.142176431128 . 0.160000003315)))
      (351/4 "|" ((61.766255413629 . 0.160000003315)))
      (177/2 "|" ((97.891168699930 . 0.160000003315)))
      (357/4 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (345/4 1 ("accidentals.flat" 4.482188531787 -0.746096043423 5.376719874024 1.839841566085) ("accidentals.flat" 5.482188908083 0.753905696947 6.376720250320 3.339843306455) ("accidentals.flat" 6.482189284379 -1.245469463037 7.376720626616 1.340468146471) ("accidentals.flat" 7.482189660676 0.253899629169 8.376721002912 2.839837238678))
      (345/4 2 ("accidentals.flat" 4.482188531787 -1.746092374534 5.376719874024 0.839845234974) ("accidentals.flat" 5.482188908083 -0.246097689719 6.376720250320 2.339839919789) ("accidentals.flat" 6.482189284379 -2.246098442312 7.376720626616 0.339839167196) ("accidentals.flat" 7.482189660676 -0.746096701942 8.376721002912 1.839840907566))
    ))
    (357/4 (
      (90 "|" ((36.925838795315 . 0.160000003315)))
      (363/4 "|" ((59.929107959776 . 0.160000003315)))
      (183/2 "|" ((96.880736523719 . 0.160000003315)))
      (369/4 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (357/4 1 ("accidentals.flat" 4.482188531787 -0.746095643608 5.376719874024 1.839841965900) ("accidentals.flat" 5.482188908083 0.753906096762 6.376720250320 3.339843706270) ("accidentals.flat" 6.482189284379 -1.245469063223 7.376720626616 1.340468546286) ("accidentals.flat" 7.482189660676 0.253900028984 8.376721002912 2.839837638492))
      (357/4 2 ("accidentals.flat" 4.482188531787 -1.746103616386 5.376719874024 0.839833993122) ("accidentals.flat" 5.482188908083 -0.246094820460 6.376720250320 2.339842789048) ("accidentals.flat" 6.482189284379 -2.246090869349 7.376720626616 0.339846740159) ("accidentals.flat" 7.482189660676 -0.746079721571 8.376721002912 1.839857887937))
    ))
    (369/4 (
      (93 "|" ((37.135271896861 . 0.160000003315)))
      (375/4 "|" ((64.672731823380 . 0.160000003315)))
      (189/2 "|" ((93.480355422984 . 0.160000003315)))
      (381/4 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (369/4 1 ("accidentals.flat" 4.482188531787 -0.746099806386 5.376719874024 1.839837803122) ("accidentals.flat" 5.482188908083 0.753911341392 6.376720250320 3.339848950900) ("accidentals.flat" 6.482189284379 -1.245468522297 7.376720626616 1.340469087211) ("accidentals.flat" 7.482189660676 0.253907625466 8.376721002912 2.839845234974))
      (369/4 2 ("accidentals.flat" 4.482188531787 -1.746100911757 5.376719874024 0.839836697752) ("accidentals.flat" 5.482188908083 -0.246089763978 6.376720250320 2.339847845530) ("accidentals.flat" 6.482189284379 -2.246102275831 7.376720626616 0.339835333677) ("accidentals.flat" 7.482189660676 -0.746107591016 8.376721002912 1.839830018492))
    ))
    (381/4 (
      (96 "|" ((50.116923282585 . 0.159999969448)))
      (387/4 "|" ((88.934030583800 . 0.159999969448)))
      (195/2 "|" ((128.444438101305 . 0.159999969448)))
    ) (
      (381/4 1 ("accidentals.flat" 4.482187583057 -0.746094780129 5.376718735951 1.839842282022) ("accidentals.flat" 5.482187747687 0.753906642741 6.376718900581 3.339843704892) ("accidentals.flat" 6.482187912316 -1.245468094043 7.376719065211 1.340468968108) ("accidentals.flat" 7.482188076946 0.253906325241 8.376719229840 2.839843387392))
      (381/4 2 ("accidentals.flat" 4.482188531787 -1.746093338793 5.376719874024 0.839844270715) ("accidentals.flat" 5.482188908083 -0.246093950275 6.376720250320 2.339843659233) ("accidentals.flat" 6.482189284379 -2.246094467682 7.376720626616 0.339843141826) ("accidentals.flat" 7.482189660676 -0.746092962497 8.376721002912 1.839844647011))
    ))
    (195/2 (
      (393/4 "|" ((44.034990879946 . 0.160000003315)))
      (99 "|" ((78.012306949173 . 0.160000003315)))
      (399/4 "|" ((107.179103293830 . 0.160000003315)))
      (201/2 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (195/2 1 ("accidentals.flat" 4.325000157574 -0.746095502497 5.219531499811 1.839842107011) ("accidentals.flat" 5.325000063500 0.753903886021 6.219531405737 3.339841495529) ("accidentals.flat" 6.325000674981 -1.245466570260 7.219532017218 1.340471039249) ("accidentals.flat" 7.324998934611 0.253904873799 8.219530276848 2.839842483307))
      (195/2 2 ("accidentals.flat" 4.325000157574 -0.746094914534 5.219531499811 1.839842694974) ("accidentals.flat" 5.325000063500 0.753906825836 6.219531405737 3.339844435344) ("accidentals.flat" 6.325000674981 -1.245470686000 7.219532017218 1.340466923508) ("accidentals.flat" 7.324998934611 0.253905461762 8.219530276848 2.839843071270))
    ))
    (201/2 (
      (405/4 "|" ((36.709623161865 . 0.160000003315)))
      (102 "|" ((69.412788577613 . 0.160000003315)))
      (411/4 "|" ((98.669702880564 . 0.160000003315)))
      (207/2 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (201/2 1 ("accidentals.flat" 4.482188531787 -0.746091504349 5.376719874024 1.839846105159) ("accidentals.flat" 5.482188908083 0.753905532318 6.376720250320 3.339843141826) ("accidentals.flat" 6.482189284379 -1.245469627667 7.376720626616 1.340467981841) ("accidentals.flat" 7.482189660676 0.253906520095 8.376721002912 2.839844129604))
      (201/2 2 ("accidentals.flat" 4.482188531787 -1.746099594719 5.376719874024 0.839838014789) ("accidentals.flat" 5.482188908083 -0.246097854349 6.376720250320 2.339839755159) ("accidentals.flat" 6.482189284379 -2.246098606942 7.376720626616 0.339839002566) ("accidentals.flat" 7.482189660676 -0.746092162867 8.376721002912 1.839845446641))
    ))
    (207/2 (
      (417/4 "|" ((38.665479278603 . 0.160000003315)))
      (105 "|" ((69.044141819741 . 0.160000003315)))
      (423/4 "|" ((97.674802343549 . 0.160000003315)))
      (213/2 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (207/2 1 ("accidentals.flat" 4.482188531787 -0.746095808238 5.376719874024 1.839841801270) ("accidentals.flat" 5.482188908083 0.753905932133 6.376720250320 3.339843541641) ("accidentals.flat" 6.482189284379 -1.245469227852 7.376720626616 1.340468381656) ("accidentals.flat" 7.482189660676 0.253906919910 8.376721002912 2.839844529418))
      (207/2 2 ("accidentals.flat" 4.482188531787 -1.746096843053 5.376719874024 0.839840766455) ("accidentals.flat" 5.482188908083 -0.246085695275 6.376720250320 2.339851914233) ("accidentals.flat" 6.482189284379 -2.246100558979 7.376720626616 0.339837050529) ("accidentals.flat" 7.482189660676 -0.746089411201 8.376721002912 1.839848198307))
    ))
    (213/2 (
      (429/4 "|" ((42.914943657698 . 0.160000003315)))
      (108 "|" ((63.399352727764 . 0.160000003315)))
      (435/4 "|" ((82.548191549887 . 0.160000003315)))
      (219/2 "|" ((104.912847654847 . 0.160000003315)))
      (441/4 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (213/2 1 ("accidentals.flat" 4.482188531787 -0.746107144164 5.376719874024 1.839830465344) ("accidentals.flat" 5.482188908083 0.753901651762 6.376720250320 3.339839261270) ("accidentals.flat" 6.482189284379 -1.245473508223 7.376720626616 1.340464101285) ("accidentals.flat" 7.482189660676 0.253904991392 8.376721002912 2.839842600900))
      (213/2 2 ("accidentals.flat" 4.482188531787 -1.746094091386 5.376719874024 0.839843518122) ("accidentals.flat" 5.482188908083 -0.246082943608 6.376720250320 2.339854665900) ("accidentals.flat" 6.482189284379 -2.246097807312 7.376720626616 0.339839802196) ("accidentals.flat" 7.482189660676 -0.746086659534 8.376721002912 1.839850949974))
    ))
    (441/4 (
      (111 "|" ((31.864319170627 . 0.159999969448)))
      (447/4 "|" ((58.819444581023 . 0.159999969448)))
      (225/2 "|" ((81.362666701396 . 0.159999969448)))
      (453/4 "|" ((105.072864458230 . 0.159999969448)))
      (114 "|" ((128.444438101305 . 0.159999969448)))
    ) (
      (441/4 1 ("accidentals.flat" 4.482187583057 -0.746094780129 5.376718735951 1.839842282022) ("accidentals.flat" 5.482187747687 0.753906642741 6.376718900581 3.339843704892) ("accidentals.flat" 6.482187912316 -1.245468094043 7.376719065211 1.340468968108) ("accidentals.flat" 7.482188076946 0.253906325241 8.376719229840 2.839843387392))
      (441/4 2 ("accidentals.flat" 4.482190534662 -1.746095412558 5.376722276622 0.839843352482) ("accidentals.flat" 5.482191357811 -0.246095353762 6.376723099770 2.339843411278) ("accidentals.flat" 6.482192180959 -2.246096294503 7.376723922919 0.339842470537) ("accidentals.flat" 7.482193004108 -0.746094589409 8.376724746067 1.839844175630))
    ))
    (114 (
      (459/4 "|" ((32.792233697978 . 0.160000003315)))
      (231/2 "|" ((55.986655425616 . 0.160000003315)))
      (465/4 "|" ((73.312263544533 . 0.160000003315)))
      (117 "||" ((90.390377433136 . 0.160000003315) (90.850376641881 . 0.160000003315)))
      (471/4 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (114 1 ("accidentals.flat" 4.482188531787 -0.746095337868 5.376719874024 1.839842271641) ("accidentals.flat" 5.482188908083 0.753904050651 6.376720250320 3.339841660159) ("accidentals.flat" 6.482189284379 -1.245468757482 7.376720626616 1.340468852026) ("accidentals.flat" 7.482189660676 0.253905038429 8.376721002912 2.839842647937))
      (114 2 ("accidentals.flat" 4.482188531787 -1.746091763053 5.376719874024 0.839845846455) ("accidentals.flat" 5.482188908083 -0.246094726386 6.376720250320 2.339842883122) ("accidentals.flat" 6.482189284379 -2.246097830831 7.376720626616 0.339839778678) ("accidentals.flat" 7.482189660676 -0.746096090460 8.376721002912 1.839841519048))
      (117 1 ("accidentals.sharp" 91.430383396076 0.484374060729 92.422570920330 3.496093056571) ("accidentals.sharp" 92.430386124224 -1.015622975937 93.422573648478 1.996096019905) ("accidentals.sharp" 93.430381796817 0.984375424803 94.422569321070 3.996094420645) ("accidentals.sharp" 94.430379821261 -0.515626315567 95.422567345515 2.496092680275))
      (117 2 ("accidentals.sharp" 91.430383396076 -0.515631771864 92.422570920330 2.496087223978) ("accidentals.sharp" 92.430386124224 -2.014998512218 93.422573648478 0.996720483624) ("accidentals.sharp" 93.430381796817 -0.015625704086 94.422569321070 2.996093291756) ("accidentals.sharp" 94.430379821261 -1.515627444456 95.422567345515 1.496091551386))
    ))
    (471/4 (
      (237/2 "|" ((49.648465488645 . 0.160000003315)))
      (477/4 "|" ((92.603155140673 . 0.160000003315)))
      (120 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (471/4 1 ("accidentals.sharp" 4.478124766873 0.484372014618 5.470312291126 3.496091010460) ("accidentals.sharp" 5.478124202428 -1.015629725752 6.470311726682 1.996089270090) ("accidentals.sharp" 6.478124343539 0.984371026840 7.470311867793 3.996090022682) ("accidentals.sharp" 7.478124484650 -0.515630713530 8.470312008904 2.496088282312))
      (471/4 2 ("accidentals.sharp" 4.478124766873 -0.515631372049 5.470312291126 2.496087623793) ("accidentals.sharp" 5.478124202428 -2.014995760552 6.470311726682 0.996723235290) ("accidentals.sharp" 6.478124343539 -0.015625304271 7.470311867793 2.996093691571) ("accidentals.sharp" 7.478124484650 -1.515627044641 8.470312008904 1.496091951201))
    ))
    (120 (
      (483/4 "|" ((36.320887190448 . 0.160000003315)))
      (243/2 "|" ((65.164382847678 . 0.160000003315)))
      (489/4 "|" ((101.453031478241 . 0.160000003315)))
      (123 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (120 1 ("accidentals.sharp" 4.478124766873 0.484372414433 5.470312291126 3.496091410275) ("accidentals.sharp" 5.478124202428 -1.015629325938 6.470311726682 1.996089669904) ("accidentals.sharp" 6.478124343539 0.984371426655 7.470311867793 3.996090422497) ("accidentals.sharp" 7.478124484650 -0.515630313715 8.470312008904 2.496088682127))
      (120 2 ("accidentals.sharp" 4.478124766873 -0.515628502789 5.470312291126 2.496090493053) ("accidentals.sharp" 5.478124202428 -2.015004650552 6.470311726682 0.996714345290) ("accidentals.sharp" 6.478124343539 -0.015629490567 7.470311867793 2.996089505275) ("accidentals.sharp" 7.478124484650 -1.515638286493 8.470312008904 1.496080709349))
    ))
    (123 (
      (495/4 "|" ((39.051276152861 . 0.160000003315)))
      (249/2 "|" ((68.801298468445 . 0.160000003315)))
      (501/4 "|" ((98.694450150411 . 0.160000003315)))
      (126 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (123 1 ("accidentals.sharp" 4.478124766873 0.484368016470 5.470312291126 3.496087012312) ("accidentals.sharp" 5.478124202428 -1.015624316493 6.470311726682 1.996094679349) ("accidentals.sharp" 6.478124343539 0.984367028692 7.470311867793 3.996086024534) ("accidentals.sharp" 7.478124484650 -0.515620600567 8.470312008904 2.496098395275))
      (123 2 ("accidentals.sharp" 4.478124766873 -0.515628079456 5.470312291126 2.496090916386) ("accidentals.sharp" 5.478124202428 -2.015004227219 6.470311726682 0.996714768623) ("accidentals.sharp" 6.478124343539 -0.015626715382 7.470311867793 2.996092280460) ("accidentals.sharp" 7.478124484650 -1.515637863160 8.470312008904 1.496081132682))
    ))
    (126 (
      (507/4 "|" ((39.657048339774 . 0.159999969448)))
      (255/2 "|" ((69.252842534524 . 0.159999969448)))
      (513/4 "|" ((98.848640317915 . 0.159999969448)))
      (129 "|" ((128.444438101305 . 0.159999969448)))
    ) (
      (126 1 ("accidentals.sharp" 4.478123819003 0.484374828388 5.470311133244 3.496093186750) ("accidentals.sharp" 5.478123042892 -1.015624242630 6.470310357133 1.996094115731) ("accidentals.sharp" 6.478122972337 0.984374910703 7.470310286577 3.996093269065) ("accidentals.sharp" 7.478122901781 -0.515624865871 8.470310216022 2.496093492491))
      (126 2 ("accidentals.sharp" 4.478126767932 -0.515625464123 5.470314735546 2.496094877511) ("accidentals.sharp" 5.478126650339 -2.015002281885 6.470314617954 0.996718059750) ("accidentals.sharp" 6.478127238303 -0.015626228476 7.470315205917 2.996094113159) ("accidentals.sharp" 7.478127826266 -1.515626287272 8.470315793880 1.496094054363))
    ))
    (129 (
      (519/4 "|" ((40.356106100122 . 0.160000003315)))
      (261/2 "|" ((71.519464518866 . 0.160000003315)))
      (525/4 "|" ((100.418964510961 . 0.160000003315)))
      (132 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (129 1 ("accidentals.sharp" 4.478124766873 0.484374060729 5.470312291126 3.496093056571) ("accidentals.sharp" 5.478124202428 -1.015622975937 6.470311726682 1.996096019905) ("accidentals.sharp" 6.478124343539 0.984375424803 7.470311867793 3.996094420645) ("accidentals.sharp" 7.478124484650 -0.515626315567 8.470312008904 2.496092680275))
      (129 2 ("accidentals.sharp" 4.478120764759 -0.515624584752 5.470307402292 2.496091719508) ("accidentals.sharp" 5.478119306613 -2.014997040667 6.470305944145 0.996719263593) ("accidentals.sharp" 6.478118554021 -0.015626019380 7.470305191553 2.996090284880) ("accidentals.sharp" 7.478117801429 -1.515621715495 8.470304438961 1.496094588765))
    ))
    (132 (
      (531/4 "|" ((46.630525882629 . 0.160000003315)))
      (267/2 "|" ((87.905315161741 . 0.160000003315)))
      (537/4 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (132 1 ("accidentals.sharp" 4.478124766873 0.484373355174 5.470312291126 3.496092351016) ("accidentals.sharp" 5.478124202428 -1.015628385197 6.470311726682 1.996090610645) ("accidentals.sharp" 6.478124343539 0.984374719248 7.470311867793 3.996093715090) ("accidentals.sharp" 7.478124484650 -0.515631724827 8.470312008904 2.496087271015))
      (132 2 ("accidentals.sharp" 4.478124766873 -0.515630031493 5.470312291126 2.496088964349) ("accidentals.sharp" 5.478124202428 -2.015001475552 6.470311726682 0.996717520290) ("accidentals.sharp" 6.478124343539 -0.015626315567 7.470311867793 2.996092680275) ("accidentals.sharp" 7.478124484650 -1.515628055938 8.470312008904 1.496090939904))
    ))
    (537/4 (
      (135 "|" ((48.881816887729 . 0.160000003315)))
      (543/4 "|" ((83.059766710233 . 0.160000003315)))
      (273/2 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (537/4 1 ("accidentals.sharp" 4.478124766873 0.484373754988 5.470312291126 3.496092750830) ("accidentals.sharp" 5.478124202428 -1.015630337234 6.470311726682 1.996088658608) ("accidentals.sharp" 6.478124343539 0.984370415359 7.470311867793 3.996089411201) ("accidentals.sharp" 7.478124484650 -0.515631325012 8.470312008904 2.496087670830))
      (537/4 2 ("accidentals.sharp" 4.478124766873 -0.515627162234 5.470312291126 2.496091833608) ("accidentals.sharp" 5.478124202428 -2.015003309996 6.470311726682 0.996715685846) ("accidentals.sharp" 6.478124343539 -0.015623446308 7.470311867793 2.996095549534) ("accidentals.sharp" 7.478124484650 -1.515611075567 8.470312008904 1.496107920275))
    ))
    (273/2 (
      (549/4 "|" ((34.749679582777 . 0.160000003315)))
      (138 "|" ((65.644636347464 . 0.160000003315)))
      (555/4 "|" ((96.539600289432 . 0.160000003315)))
      (279/2 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (273/2 1 ("accidentals.sharp" 4.478124766873 0.484369592211 5.470312291126 3.496088588053) ("accidentals.sharp" 5.478124202428 -1.015625092604 6.470311726682 1.996093903238) ("accidentals.sharp" 6.478124343539 0.984366252581 7.470311867793 3.996085248423) ("accidentals.sharp" 7.478124484650 -0.515623728530 8.470312008904 2.496095267312))
      (273/2 2 ("accidentals.sharp" 4.478124766873 -0.515620953345 5.470312291126 2.496098042497) ("accidentals.sharp" 5.478124202428 -2.014997101107 6.470311726682 0.996721894735) ("accidentals.sharp" 6.478124343539 -0.015617237419 7.470311867793 2.996101758423) ("accidentals.sharp" 7.478124484650 -1.515623681493 8.470312008904 1.496095314349))
    ))
    (279/2 (
      (561/4 "|" ((38.357612395313 . 0.159999969448)))
      (141 "|" ((67.057096982979 . 0.159999969448)))
      (567/4 "|" ((93.341706455362 . 0.159999969448)))
      (285/2 "|" ((128.444438101305 . 0.159999969448)))
    ) (
      (279/2 1 ("accidentals.sharp" 4.478123819003 -0.515624865871 5.470311133244 2.496093492491) ("accidentals.sharp" 5.478123042892 -2.014999285155 6.470310357133 0.996719073207) ("accidentals.sharp" 6.478122972337 -0.015624548371 7.470310286577 2.996093809991) ("accidentals.sharp" 7.478122901781 -1.515625971241 8.470310216022 1.496092387120))
      (279/2 2 ("accidentals.sharp" 4.478122765815 -0.515623592197 5.470309846708 2.496094057854) ("accidentals.sharp" 5.478121754519 -2.014999069961 6.470308835412 0.996718580090) ("accidentals.sharp" 6.478121448779 -0.015624803400 7.470308529672 2.996092846650) ("accidentals.sharp" 7.478121143038 -1.515623521641 8.470308223931 1.496094128409))
    ))
    (285/2 (
      (573/4 "|" ((41.131510985613 . 0.160000003315)))
      (144 "|" ((77.989956891661 . 0.160000003315)))
      (579/4 "||" ((123.583851721365 . 0.160000003315) (124.043858107393 . 0.160000003315)))
    ) (
      (285/2 1 ("accidentals.sharp" 4.478124766873 0.484374930914 5.470312291126 3.496093926756) ("accidentals.sharp" 5.478124202428 -1.015624457604 6.470311726682 1.996094538238) ("accidentals.sharp" 6.478124343539 0.984376294988 7.470311867793 3.996095290830) ("accidentals.sharp" 7.478124484650 -0.515625445382 8.470312008904 2.496093550460))
      (285/2 2 ("accidentals.sharp" 4.478120764759 -0.515621503828 5.470307402292 2.496094800432) ("accidentals.sharp" 5.478119306613 -2.014996311594 6.470305944145 0.996719992666) ("accidentals.sharp" 6.478118554021 -0.015625290306 7.470305191553 2.996091013953) ("accidentals.sharp" 7.478117801429 -1.515620986421 8.470304438961 1.496095317839))
      (579/4 1 ("accidentals.flat" 124.628862246483 -0.746094467682 125.523393588720 1.839843141826) ("accidentals.flat" 125.628848511668 0.753904920836 126.523379853905 3.339842530344) ("accidentals.flat" 126.628870054632 -1.245467887297 127.523401396868 1.340469722211) ("accidentals.flat" 127.628863375372 0.253905908614 128.523394717609 2.839843518122))
      (579/4 2 ("accidentals.flat" 124.628750865304 -1.746092154601 125.523281408096 0.839843143847) ("accidentals.flat" 125.628736236799 -0.246089402936 126.523266779590 2.339845895512) ("accidentals.flat" 126.628756886040 -2.246090719972 127.523287428831 0.339844578476) ("accidentals.flat" 127.628749313083 -0.746090320158 128.523279855875 1.839844978290))
    ))
    (579/4 (
      (291/2 "|" ((41.206384396008 . 0.160000003315)))
      (585/4 "|" ((70.245812686517 . 0.160000003315)))
      (147 "|" ((99.285240977027 . 0.160000003315)))
      (591/4 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (579/4 1 ("accidentals.flat" 4.482188531787 -0.746095314349 5.376719874024 1.839842295159) ("accidentals.flat" 5.482188908083 0.753911129725 6.376720250320 3.339848739233) ("accidentals.flat" 6.482189284379 -1.245468733963 7.376720626616 1.340468875545) ("accidentals.flat" 7.482189660676 0.253900358243 8.376721002912 2.839837967752))
      (579/4 2 ("accidentals.flat" 4.482188531787 -1.746091645460 5.376719874024 0.839845964048) ("accidentals.flat" 5.482188908083 -0.246096960645 6.376720250320 2.339840648863) ("accidentals.flat" 6.482189284379 -2.246097713238 7.376720626616 0.339839896270) ("accidentals.flat" 7.482189660676 -0.746095972868 8.376721002912 1.839841636641))
    ))
    (591/4 (
      (297/2 "|" ((53.773834654384 . 0.160000003315)))
      (597/4 "|" ((86.537762943254 . 0.160000003315)))
      (150 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (591/4 1 ("accidentals.flat" 4.482188531787 -0.746097242868 5.376719874024 1.839840366641) ("accidentals.flat" 5.482188908083 0.753904497503 6.376720250320 3.339842107011) ("accidentals.flat" 6.482189284379 -1.245465958778 7.376720626616 1.340471650730) ("accidentals.flat" 7.482189660676 0.253900781577 8.376721002912 2.839838391085))
      (591/4 2 ("accidentals.flat" 4.482188531787 -1.746098183608 5.376719874024 0.839839425900) ("accidentals.flat" 5.482188908083 -0.246087035830 6.376720250320 2.339850573678) ("accidentals.flat" 6.482189284379 -2.246101899534 7.376720626616 0.339835709974) ("accidentals.flat" 7.482189660676 -0.746090751756 8.376721002912 1.839846857752))
    ))
    (150 (
      (603/4 "|" ((50.686042147038 . 0.160000003315)))
      (303/2 "|" ((88.259542759195 . 0.160000003315)))
      (609/4 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (150 1 ("accidentals.flat" 4.482188531787 -0.746106132868 5.376719874024 1.839831476640) ("accidentals.flat" 5.482188908083 0.753902663058 6.376720250320 3.339840272566) ("accidentals.flat" 6.482189284379 -1.245472496926 7.376720626616 1.340465112582) ("accidentals.flat" 7.482189660676 0.253903650836 8.376721002912 2.839841260344))
      (150 2 ("accidentals.flat" 4.482188531787 -1.746095408423 5.376719874024 0.839842201085) ("accidentals.flat" 5.482188908083 -0.246084260645 6.376720250320 2.339853348863) ("accidentals.flat" 6.482189284379 -2.246099124349 7.376720626616 0.339838485159) ("accidentals.flat" 7.482189660676 -0.746087976571 8.376721002912 1.839849632937))
    ))
    (609/4 (
      (153 "|" ((42.521127935933 . 0.159999969448)))
      (615/4 "|" ((71.289374463443 . 0.159999969448)))
      (309/2 "|" ((99.416729279933 . 0.159999969448)))
      (621/4 "|" ((128.444438101305 . 0.159999969448)))
    ) (
      (609/4 1 ("accidentals.flat" 4.482187583057 -0.746094780129 5.376718735951 1.839842282022) ("accidentals.flat" 5.482187747687 0.753906642741 6.376718900581 3.339843704892) ("accidentals.flat" 6.482187912316 -1.245468094043 7.376719065211 1.340468968108) ("accidentals.flat" 7.482188076946 0.253906325241 8.376719229840 2.839843387392))
      (609/4 2 ("accidentals.flat" 4.482190534662 -1.746095412558 5.376722276622 0.839843352482) ("accidentals.flat" 5.482191357811 -0.246095353762 6.376723099770 2.339843411278) ("accidentals.flat" 6.482192180959 -2.246096294503 7.376723922919 0.339842470537) ("accidentals.flat" 7.482193004108 -0.746094589409 8.376724746067 1.839844175630))
    ))
    (621/4 (
      (156 "|" ((67.591675172727 . 0.160000003315)))
      (627/4 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (621/4 1 ("accidentals.flat" 4.482188531787 -0.746095337868 5.376719874024 1.839842271641) ("accidentals.flat" 5.482188908083 0.753904050651 6.376720250320 3.339841660159) ("accidentals.flat" 6.482189284379 -1.245468757482 7.376720626616 1.340468852026) ("accidentals.flat" 7.482189660676 0.253905038429 8.376721002912 2.839842647937))
      (621/4 2 ("accidentals.flat" 4.482184526042 -1.746092883674 5.376715068833 0.839842414774) ("accidentals.flat" 5.482184008635 -0.246090132010 6.376714551426 2.339845166438) ("accidentals.flat" 6.482183491228 -2.246091449046 7.376714034019 0.339843849402) ("accidentals.flat" 7.482182973821 -0.746091049231 8.376713516612 1.839844249217))
    ))
    (627/4 (
      (315/2 "|" ((50.574654312239 . 0.160000003315)))
      (633/4 "|" ((88.980292638919 . 0.160000003315)))
      (159 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (627/4 1 ("accidentals.flat" 4.482188531787 -0.746096043423 5.376719874024 1.839841566085) ("accidentals.flat" 5.482188908083 0.753905696947 6.376720250320 3.339843306455) ("accidentals.flat" 6.482189284379 -1.245469463037 7.376720626616 1.340468146471) ("accidentals.flat" 7.482189660676 0.253899629169 8.376721002912 2.839837238678))
      (627/4 2 ("accidentals.flat" 4.482188531787 -1.746092374534 5.376719874024 0.839845234974) ("accidentals.flat" 5.482188908083 -0.246097689719 6.376720250320 2.339839919789) ("accidentals.flat" 6.482189284379 -2.246098442312 7.376720626616 0.339839167196) ("accidentals.flat" 7.482189660676 -0.746096701942 8.376721002912 1.839840907566))
    ))
    (159 (
      (639/4 "|" ((49.190059636602 . 0.160000003315)))
      (321/2 "|" ((90.030723810159 . 0.160000003315)))
      (645/4 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (159 1 ("accidentals.flat" 4.482188531787 -0.746095643608 5.376719874024 1.839841965900) ("accidentals.flat" 5.482188908083 0.753906096762 6.376720250320 3.339843706270) ("accidentals.flat" 6.482189284379 -1.245469063223 7.376720626616 1.340468546286) ("accidentals.flat" 7.482189660676 0.253900028984 8.376721002912 2.839837638492))
      (159 2 ("accidentals.flat" 4.482188531787 -1.746097854349 5.376719874024 0.839839755159) ("accidentals.flat" 5.482188908083 -0.246086706571 6.376720250320 2.339850902937) ("accidentals.flat" 6.482189284379 -2.246101570275 7.376720626616 0.339836039233) ("accidentals.flat" 7.482189660676 -0.746090422497 8.376721002912 1.839847187011))
    ))
    (645/4 (
      (162 "|" ((49.459781910628 . 0.160000003315)))
      (651/4 "|" ((88.963447557037 . 0.160000003315)))
      (327/2 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (645/4 1 ("accidentals.flat" 4.482188531787 -0.746105803609 5.376719874024 1.839831805900) ("accidentals.flat" 5.482188908083 0.753902992318 6.376720250320 3.339840601826) ("accidentals.flat" 6.482189284379 -1.245474519519 7.376720626616 1.340463089989) ("accidentals.flat" 7.482189660676 0.253903980095 8.376721002912 2.839841589604))
      (645/4 2 ("accidentals.flat" 4.482188531787 -1.746093950275 5.376719874024 0.839843659233) ("accidentals.flat" 5.482188908083 -0.246082802497 6.376720250320 2.339854807011) ("accidentals.flat" 6.482189284379 -2.246097666201 7.376720626616 0.339839943307) ("accidentals.flat" 7.482189660676 -0.746086518423 8.376721002912 1.839851091085))
    ))
    (327/2 (
      (657/4 "|" ((40.475965326709 . 0.159999969448)))
      (165 "|" ((68.896705855324 . 0.159999969448)))
      (663/4 "|" ((99.074236611760 . 0.159999969448)))
      (333/2 "|" ((128.444438101305 . 0.159999969448)))
    ) (
      (327/2 1 ("accidentals.flat" 4.482187583057 -0.746094780129 5.376718735951 1.839842282022) ("accidentals.flat" 5.482187747687 0.753906642741 6.376718900581 3.339843704892) ("accidentals.flat" 6.482187912316 -1.245468094043 7.376719065211 1.340468968108) ("accidentals.flat" 7.482188076946 0.253906325241 8.376719229840 2.839843387392))
      (327/2 2 ("accidentals.flat" 4.482190534662 -1.746096282744 5.376722276622 0.839842482296) ("accidentals.flat" 5.482191357811 -0.246093872094 6.376723099770 2.339844892945) ("accidentals.flat" 6.482192180959 -2.246095518391 7.376723922919 0.339843246648) ("accidentals.flat" 7.482193004108 -0.746095459595 8.376724746067 1.839843305445))
    ))
    (333/2 (
      (669/4 "|" ((47.683888973744 . 0.160000003315)))
      (168 "|" ((87.256603665849 . 0.160000003315)))
      (675/4 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (333/2 1 ("accidentals.flat" 4.482188531787 -0.746094961571 5.376719874024 1.839842647937) ("accidentals.flat" 5.482188908083 0.753906778799 6.376720250320 3.339844388307) ("accidentals.flat" 6.482189284379 -1.245468381186 7.376720626616 1.340469228323) ("accidentals.flat" 7.482189660676 0.253905414725 8.376721002912 2.839843024233))
      (333/2 2 ("accidentals.flat" 4.482184526042 -1.746093753859 5.376715068833 0.839841544590) ("accidentals.flat" 5.482184008635 -0.246091002194 6.376714551426 2.339844296254) ("accidentals.flat" 6.482183491228 -2.246087615531 7.376714034019 0.339847682918) ("accidentals.flat" 7.482182973821 -0.746091919416 8.376713516612 1.839843379032))
    ))
    (675/4 (
      (339/2 "|" ((44.523494665895 . 0.160000003315)))
      (681/4 "|" ((71.409565970173 . 0.160000003315)))
      (171 "|" ((96.839653759043 . 0.160000003315)))
      (687/4 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (675/4 1 ("accidentals.flat" 4.482188531787 -0.746096913608 5.376719874024 1.839840695900) ("accidentals.flat" 5.482188908083 0.753907178614 6.376720250320 3.339844788122) ("accidentals.flat" 6.482189284379 -1.245470333223 7.376720626616 1.340467276286) ("accidentals.flat" 7.482189660676 0.253903462688 8.376721002912 2.839841072196))
      (675/4 2 ("accidentals.flat" 4.482188531787 -1.746091927682 5.376719874024 0.839845681826) ("accidentals.flat" 5.482188908083 -0.246092539164 6.376720250320 2.339845070344) ("accidentals.flat" 6.482189284379 -2.246097995460 7.376720626616 0.339839614048) ("accidentals.flat" 7.482189660676 -0.746096255090 8.376721002912 1.839841354418))
    ))
    (687/4 (
      (345/2 "|" ((44.385346333525 . 0.160000003315)))
      (693/4 "|" ((91.167468979999 . 0.160000003315)))
      (174 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (687/4 1 ("accidentals.flat" 4.482188531787 -0.746095431942 5.376719874024 1.839842177567) ("accidentals.flat" 5.482188908083 0.753906308429 6.376720250320 3.339843917937) ("accidentals.flat" 6.482189284379 -1.245468851556 7.376720626616 1.340468757952) ("accidentals.flat" 7.482189660676 0.253900240651 8.376721002912 2.839837850159))
      (687/4 2 ("accidentals.flat" 4.482188531787 -1.746103404720 5.376719874024 0.839834204789) ("accidentals.flat" 5.482188908083 -0.246094608793 6.376720250320 2.339843000715) ("accidentals.flat" 6.482189284379 -2.246102416942 7.376720626616 0.339835192566) ("accidentals.flat" 7.482189660676 -0.746100676571 8.376721002912 1.839836932937))
    ))
    (174 (
      (699/4 "|" ((46.481783881380 . 0.160000003315)))
      (351/2 "|" ((72.126289394449 . 0.160000003315)))
      (705/4 "|" ((99.002463226245 . 0.160000003315)))
      (177 "|" ((128.444465288712 . 0.160000003315)))
    ) (
      (174 1 ("accidentals.flat" 4.482188531787 -0.746092562682 5.376719874024 1.839845046826) ("accidentals.flat" 5.482188908083 0.753913881392 6.376720250320 3.339851490900) ("accidentals.flat" 6.482189284379 -1.245465982297 7.376720626616 1.340471627212) ("accidentals.flat" 7.482189660676 0.253910165466 8.376721002912 2.839847774974))
      (174 2 ("accidentals.flat" 4.482188531787 -1.746103004905 5.376719874024 0.839834604603) ("accidentals.flat" 5.482188908083 -0.246094208979 6.376720250320 2.339843400530) ("accidentals.flat" 6.482189284379 -2.246102017127 7.376720626616 0.339835592381) ("accidentals.flat" 7.482189660676 -0.746097924905 8.376721002912 1.839839684604))
    ))
    (177 (
      (711/4 "|" ((46.486231134188 . 0.159999969448)))
      (357/2 "|" ((78.771388375687 . 0.159999969448)))
      (717/4 "|" ((97.190975516866 . 0.159999969448)))
      (180 "|" ((115.151999002850 . 0.159999969448)))
      (723/4 "|." ((127.624448110873 . 0.159999969448) (128.274451380020 . 0.499999892260)))
    ) (
      (177 1 ("accidentals.flat" 4.324999242116 -0.746094780129 5.219530395010 1.839842282022) ("accidentals.flat" 5.324998936375 0.753906642741 6.219530089269 3.339843704892) ("accidentals.flat" 6.324999336190 -1.245468094043 7.219530489084 1.340468968108) ("accidentals.flat" 7.324997384153 0.253906325241 8.219528537048 2.839843387392))
      (177 2 ("accidentals.flat" 4.325002090209 -0.746094589409 5.219533832169 1.839844175630) ("accidentals.flat" 5.325002442987 0.753905469387 6.219534184947 3.339844234427) ("accidentals.flat" 6.325003501321 -1.245470584023 7.219535243281 1.340468181017) ("accidentals.flat" 7.325002207802 0.253906233739 8.219533949762 2.839844998779))
    ))
   ))

#(define op47-source-absent-courtesy-key-groups
  '(
    (213/2 441/4 1)
    (213/2 441/4 2)
   ))

% Native Emmentaler ink metrics measured from the compiled Op.47 PDF.
% Each tuple is true X0,Y0,X1,Y1 as fractions of the declared glyph extents.
#(define op47-native-key-ink-fractions
  '(
    ("accidentals.flat" 0.018484006266 -0.009858812404 0.999424451934 1.012630658696)
    ("accidentals.sharp" 0.000074856296 0.000786405756 0.999954501841 1.000700639261)
   ))

% Source bar/key callbacks use each grob's own staff and a common reference point.
#(define op47-source-bar-key-done (make-hash-table))
#(define (op47SourceNativeKeyGlyph font data origin-x staff-y now-x now-y space)
  (let* ((glyph (ly:font-get-glyph font (car data)))
         (declared-x (ly:stencil-extent glyph X))
         (declared-y (ly:stencil-extent glyph Y))
         (ink (cdr (assoc (car data) op47-native-key-ink-fractions)))
         (dx (- (cdr declared-x) (car declared-x)))
         (dy (- (cdr declared-y) (car declared-y)))
         (xe (cons (+ (car declared-x) (* dx (list-ref ink 0)))
                   (+ (car declared-x) (* dx (list-ref ink 2)))))
         (ye (cons (+ (car declared-y) (* dy (list-ref ink 1)))
                   (+ (car declared-y) (* dy (list-ref ink 3)))))
         (x0 (+ origin-x (* space (list-ref data 1)) (- now-x)))
         (y0 (+ staff-y (* space (list-ref data 2)) (- now-y)))
         (width (* space (- (list-ref data 3) (list-ref data 1))))
         (height (* space (- (list-ref data 4) (list-ref data 2))))
         (sx (/ width (- (cdr xe) (car xe))))
         (sy (/ height (- (cdr ye) (car ye)))))
    (let ((placed (ly:stencil-translate (ly:stencil-scale glyph sx sy)
                    (cons (- x0 (* sx (car xe))) (- y0 (* sy (car ye)))))))
      (ly:make-stencil (ly:stencil-expr placed)
        (cons x0 (+ x0 width)) (cons y0 (+ y0 height))))))

#(define (op47SourceNativeKeyStencil grob glyphs)
  ; Deliberately compute staff-relative Y only when the stencil is printed.
  (let* ((staff (ly:grob-object grob 'staff-symbol))
         (space (ly:staff-symbol-staff-space staff))
         (left (ly:spanner-bound staff LEFT))
         (x-ref (ly:grob-common-refpoint left grob X))
         (y-ref (ly:grob-common-refpoint staff grob Y))
         (origin-x (ly:grob-relative-coordinate left x-ref X))
         (now-x (ly:grob-relative-coordinate grob x-ref X))
         (staff-y (ly:grob-relative-coordinate staff y-ref Y))
         (now-y (ly:grob-relative-coordinate grob y-ref Y))
         (font (ly:grob-default-font grob)))
    (apply ly:stencil-add
      (map (lambda (data)
        (op47SourceNativeKeyGlyph font data origin-x staff-y now-x now-y space)) glyphs))))

#(define (op47ApplySourceBarKeyGeometry system)
  (unless (hashq-ref op47-source-bar-key-done system)
    (hashq-set! op47-source-bar-key-done system #t)
    (let* ((array (ly:grob-object system 'columns))
           (columns (if (ly:grob-array? array) (ly:grob-array->list array) '()))
           (first (and (pair? columns) (car columns)))
           (start (and first (ly:moment-main (ly:grob-property first 'when))))
           (reference (and start (assoc start op47-source-bar-key-data))))
      (when reference
        (let* ((all-array (ly:grob-object system 'all-elements))
               (all (if (ly:grob-array? all-array) (ly:grob-array->list all-array) '()))
               (staffs (filter (lambda (g)
                         (eq? (assoc-get 'name (ly:grob-property g 'meta)) 'StaffSymbol)) all))
               (upper (find (lambda (g)
                        (equal? (assoc-get 'data-voice (ly:grob-property g 'output-attributes)) "1")) staffs))
               (lower (find (lambda (g)
                        (equal? (assoc-get 'data-voice (ly:grob-property g 'output-attributes)) "2")) staffs))
               (bars (cadr reference))
               (keys (caddr reference))
               (counts (make-hash-table)))
          ; Native SpanBar printing derives its model from these native BarLines.
          ; Set their physical widths and gaps before any print/width lookup.
          (for-each
            (lambda (g)
              (let* ((name (assoc-get 'name (ly:grob-property g 'meta)))
                     (column (concerto-paper-column-of g))
                     (moment (and column (ly:grob-property column 'when)))
                     (bar (and (ly:moment? moment) (assoc (ly:moment-main moment) bars))))
                (when (and bar (eq? name 'BarLine))
                  (let* ((staff (ly:grob-object g 'staff-symbol))
                         (space (ly:staff-symbol-staff-space staff))
                         (line-width (layout-line-thickness g))
                         (axes (caddr bar))
                         (thin (apply min (map cdr axes)))
                         (thick (apply max (map cdr axes))))
                    (ly:grob-set-property! g 'hair-thickness (/ (* space thin) line-width))
                    (when (> thick thin)
                      (ly:grob-set-property! g 'thick-thickness (/ (* space thick) line-width)))
                    (when (> (length axes) 1)
                      (let* ((a (car axes)) (b (cadr axes))
                             (gap (- (car b) (car a) (/ (+ (cdr a) (cdr b)) 2)))
                             (kern (/ (* space gap) line-width)))
                        (ly:grob-set-property! g 'kern kern))))))) all)
          (for-each
            (lambda (g)
              (let* ((name (assoc-get 'name (ly:grob-property g 'meta)))
                     (column (concerto-paper-column-of g))
                     (column-moment (and column (ly:grob-property column 'when)))
                     (moment (and (ly:moment? column-moment) (ly:moment-main column-moment))))
                (when (and moment (memq name '(BarLine SpanBar KeySignature KeyCancellation)))
                  (let* ((own-staff (ly:grob-object g 'staff-symbol #f))
                         (staff (if (ly:grob? own-staff) own-staff upper))
                         (staff-number (cond ((eq? staff upper) 1) ((eq? staff lower) 2) (else 0)))
                         (space (ly:staff-symbol-staff-space staff))
                         (left (ly:spanner-bound staff LEFT))
                         (x-ref (ly:grob-common-refpoint left g X))
                         (origin-x (ly:grob-relative-coordinate left x-ref X))
                         (now-x (ly:grob-relative-coordinate g x-ref X))
                         (bar (and (memq name '(BarLine SpanBar)) (assoc moment bars)))
                         (key (and (eq? name 'KeySignature)
                                (find (lambda (k) (and (= (car k) moment) (= (cadr k) staff-number))) keys)))
                         (absent (and (eq? name 'KeySignature)
                                   (member (list start moment staff-number) op47-source-absent-courtesy-key-groups))))
                    (cond
                      (absent
                        ; Exactly the source-absent m147-end courtesy; m148's
                        ; initial signature has a different system and survives.
                        (hashq-set! counts 'AbsentCourtesy (+ 1 (hashq-ref counts 'AbsentCourtesy 0)))
                        (ly:grob-set-property! g 'stencil #f))
                      (bar
                        (let* ((printer (if (eq? name 'SpanBar) ly:span-bar::print ly:bar-line::print))
                               (axis (car (caddr bar)))
                               (target-left (+ origin-x (* space (- (car axis) (/ (cdr axis) 2)))))
                               (xe (if (eq? name 'SpanBar)
                                     (ly:span-bar::width g)
                                     (ly:stencil-extent (bar-line::compound-bar-line g (cadr bar) '(-2 . 2)) X)))
                               (dx (- target-left now-x (car xe)))
                               (old-x (ly:grob-property-data g 'X-extent))
                               (old-y (ly:grob-property-data g 'Y-extent)))
                          (ly:grob-set-property! g 'X-extent old-x)
                          (ly:grob-set-property! g 'Y-extent old-y)
                          (ly:grob-set-property! g 'stencil
                            (lambda (actual) (ly:stencil-translate-axis (printer actual) dx X)))
                          (concerto-audit-wrap-pdf-stencil! g)
                          (hashq-set! counts name (+ 1 (hashq-ref counts name 0)))))
                      (key
                        (let* ((old-x (ly:grob-property-data g 'X-extent))
                               (old-y (ly:grob-property-data g 'Y-extent))
                               (glyphs (cddr key)))
                          (ly:grob-set-property! g 'X-extent old-x)
                          (ly:grob-set-property! g 'Y-extent old-y)
                          (ly:grob-set-property! g 'stencil
                            (lambda (actual) (op47SourceNativeKeyStencil actual glyphs)))
                          (concerto-audit-wrap-pdf-stencil! g)
                          (hashq-set! counts name (+ 1 (hashq-ref counts name 0)))))))))) all)
          (unless (= (hashq-ref counts 'KeySignature 0) (length keys))
            (ly:warning "Op47 source key coverage system ~a: expected ~a got ~a"
              start (length keys) (hashq-ref counts 'KeySignature 0)))
          (if (ly:get-option 'op47-bar-key-debug)
            (ly:message "OP47BARKEY system ~a BarLine=~a SpanBar=~a KeySignature=~a absent-courtesy=~a"
              start (hashq-ref counts 'BarLine 0) (hashq-ref counts 'SpanBar 0)
              (hashq-ref counts 'KeySignature 0) (hashq-ref counts 'AbsentCourtesy 0))))))))

#(define (opFortySevenSystemWithSourceBarKeys system)
  (concerto-place-columns system)
  (op47ApplySourceBarKeyGeometry system))

\layout { \context { \Voice \override Rest.after-line-breaking = #op47-source-rest-positioner } }


% Source-confirmed native Accidental display; original musical events retained.
#(define op47-source-accidental-targets (make-hash-table))
#(for-each (lambda (entry) (hash-set! op47-source-accidental-targets (car entry) (cdr entry)))
  '(
    ("n1-1000" . 100.687296029764) ; p5 m123 p005-o000258
    ("n1-1003" . 108.006971782763) ; p5 m123 p005-o000257
    ("n1-1005" . 114.559536942937) ; p5 m123 p005-o000256
    ("n1-1008" . 120.798967838049) ; p5 m123 p005-o000254
    ("n1-1020" . 29.619841718485) ; p5 m124 p005-o000266
    ("n1-1032" . 57.157308836068) ; p5 m125 p005-o000265
    ("n1-1046" . 89.968176621444) ; p5 m126 p005-o000259
    ("n1-1052" . 108.658637726470) ; p5 m127 p005-o000253
    ("n1-1058" . 124.830544601413) ; p5 m127 p005-o000252
    ("n1-1060" . 13.025445409495) ; p6 m128 p006-o000149
    ("n1-1061" . 16.524329326649) ; p6 m128 p006-o000148
    ("n1-1067" . 35.868258503183) ; p6 m128 p006-o000145
    ("n1-1068" . 39.367144772188) ; p6 m128 p006-o000144
    ("n1-1079" . 75.252705611021) ; p6 m129 p006-o000140
    ("n1-1080" . 78.609758776951) ; p6 m129 p006-o000139
    ("n1-1082" . 84.616985357820) ; p6 m129 p006-o000138
    ("n1-1084" . 92.778235957630) ; p6 m130 p006-o000137
    ("n1-109" . 26.557396569551) ; p1 m17 p001-o000276
    ("n1-1090" . 112.163441772733) ; p6 m130 p006-o000132
    ("n1-1092" . 118.291849143878) ; p6 m130 p006-o000130
    ("n1-1093" . 120.976045382077) ; p6 m130 p006-o000131
    ("n1-1098" . 18.053974954282) ; p6 m131 p006-o000147
    ("n1-110" . 26.557396569551) ; p1 m17 p001-o000277
    ("n1-1101" . 26.267319155053) ; p6 m131 p006-o000146
    ("n1-1106" . 39.487457385619) ; p6 m131 p006-o000143
    ("n1-1108" . 47.641553733090) ; p6 m132 p006-o000141
    ("n1-1109" . 50.853116406039) ; p6 m132 p006-o000142
    ("n1-111" . 36.410276238177) ; p1 m18 p001-o000275
    ("n1-1116" . 69.593299658577) ; p6 m132 p006-o000136
    ("n1-1117" . 72.244232577081) ; p6 m132 p006-o000135
    ("n1-112" . 39.296835790219) ; p1 m18 p001-o000274
    ("n1-1124" . 90.799459139913) ; p6 m133 p006-o000133
    ("n1-1125" . 93.450399113973) ; p6 m133 p006-o000134
    ("n1-1132" . 114.085584690611) ; p6 m134 p006-o000129
    ("n1-1140" . 22.558053582901) ; p6 m135 p006-o000128
    ("n1-1141" . 26.003947018985) ; p6 m135 p006-o000127
    ("n1-1145" . 38.373680058394) ; p6 m136 p006-o000126
    ("n1-1227" . 89.967452251056) ; p6 m146 p006-o000125
    ("n1-1261" . 66.298231268979) ; p7 m150 p007-o000260
    ("n1-1327" . 104.410091805950) ; p7 m160 p007-o000258
    ("n1-1337" . 55.280277012407) ; p7 m162 p007-o000259
    ("n1-146" . 120.973742655284) ; p1 m21 p001-o000265
    ("n1-147" . 120.973742655284) ; p1 m21 p001-o000266
    ("n1-150" . 16.188994725361) ; p1 m22 p001-o000272
    ("n1-152" . 16.188994725361) ; p1 m22 p001-o000273
    ("n1-1535" . 27.552763797586) ; p8 m177 p008-o000179
    ("n1-1543" . 39.197424656307) ; p8 m177 p008-o000178
    ("n1-1562" . 72.657024214949) ; p8 m178 p008-o000169
    ("n1-1574" . 101.837184631946) ; p8 m179 p008-o000163
    ("n1-1575" . 105.206856899501) ; p8 m179 p008-o000162
    ("n1-1582" . 121.850442491529) ; p8 m179 p008-o000159
    ("n1-1585" . 10.961250558682) ; p8 m180 p008-o000181
    ("n1-1586" . 11.404449995442) ; p8 m180 p008-o000182
    ("n1-1597" . 33.961703713508) ; p8 m180 p008-o000176
    ("n1-1598" . 35.164826483659) ; p8 m180 p008-o000177
    ("n1-1600" . 40.941762643391) ; p8 m180 p008-o000174
    ("n1-1601" . 41.821757424161) ; p8 m180 p008-o000175
    ("n1-1602" . 44.811448034280) ; p8 m180 p008-o000173
    ("n1-1606" . 54.930549577932) ; p8 m181 p008-o000172
    ("n1-1609" . 60.902407223911) ; p8 m181 p008-o000171
    ("n1-1624" . 89.817395867759) ; p8 m182 p008-o000168
    ("n1-1625" . 91.126618203465) ; p8 m182 p008-o000167
    ("n1-1626" . 94.860637016964) ; p8 m182 p008-o000164
    ("n1-1627" . 97.850332330786) ; p8 m182 p008-o000165
    ("n1-1628" . 99.053448045381) ; p8 m182 p008-o000166
    ("n1-1629" . 102.787483321842) ; p8 m182 p008-o000161
    ("n1-1633" . 112.849575975212) ; p8 m182 p008-o000160
    ("n1-1636" . 119.193296685836) ; p8 m182 p008-o000157
    ("n1-1637" . 120.073289114754) ; p8 m182 p008-o000158
    ("n1-1639" . 10.961250558682) ; p8 m183 p008-o000170
    ("n1-1641" . 10.961250558682) ; p8 m183 p008-o000180
    ("n1-1648" . 76.111706521619) ; p8 m185 p008-o000156
    ("n1-1674" . 93.941701554618) ; p9 m190 p009-o000282
    ("n1-1676" . 108.416509733502) ; p9 m190 p009-o000281
    ("n1-1691" . 35.004959350121) ; p9 m191 p009-o000283
    ("n1-1696" . 70.808365132723) ; p9 m192 p009-o000280
    ("n1-1698" . 92.918772397274) ; p9 m193 p009-o000278
    ("n1-1699" . 93.414598518653) ; p9 m193 p009-o000279
    ("n1-1700" . 100.336910076754) ; p9 m193 p009-o000277
    ("n1-1702" . 115.321536961564) ; p9 m193 p009-o000276
    ("n1-1706" . 30.924891398534) ; p9 m194 p009-o000273
    ("n1-1707" . 35.341511710200) ; p9 m194 p009-o000272
    ("n1-1710" . 50.809133717927) ; p9 m195 p009-o000269
    ("n1-1713" . 63.483851620346) ; p9 m195 p009-o000261
    ("n1-1714" . 64.363853456672) ; p9 m195 p009-o000262
    ("n1-172" . 41.937894223297) ; p1 m23 p001-o000271
    ("n1-1720" . 110.269629708443) ; p9 m197 p009-o000257
    ("n1-1721" . 114.431807865740) ; p9 m197 p009-o000256
    ("n1-1724" . 12.081875067557) ; p9 m198 p009-o000275
    ("n1-1725" . 25.054057551321) ; p9 m198 p009-o000274
    ("n1-1726" . 28.606558082605) ; p9 m198 p009-o000271
    ("n1-1728" . 32.975558096810) ; p9 m198 p009-o000270
    ("n1-1739" . 79.911288616350) ; p9 m199 p009-o000259
    ("n1-1741" . 80.407110034026) ; p9 m199 p009-o000260
    ("n1-1743" . 87.137764476331) ; p9 m200 p009-o000258
    ("n1-1744" . 100.586667342119) ; p9 m200 p009-o000255
    ("n1-1746" . 120.760027520430) ; p9 m200 p009-o000254
    ("n1-1748" . 22.231261408246) ; p9 m201 p009-o000268
    ("n1-1749" . 23.418763883570) ; p9 m201 p009-o000267
    ("n1-1750" . 30.295716920192) ; p9 m201 p009-o000266
    ("n1-1752" . 43.337754109367) ; p9 m201 p009-o000265
    ("n1-1753" . 51.989170709735) ; p9 m202 p009-o000264
    ("n1-1754" . 62.371065833885) ; p9 m202 p009-o000263
    ("n1-1761" . 74.802225952573) ; p9 m202 p009-o000252
    ("n1-1763" . 75.245430093036) ; p9 m202 p009-o000253
    ("n1-1766" . 81.226862833694) ; p9 m202 p009-o000251
    ("n1-1767" . 89.739542984374) ; p9 m203 p009-o000249
    ("n1-1768" . 88.859534092492) ; p9 m203 p009-o000250
    ("n1-1769" . 90.942672810080) ; p9 m203 p009-o000248
    ("n1-1772" . 103.137024960016) ; p9 m203 p009-o000247
    ("n1-1773" . 107.925762336333) ; p9 m203 p009-o000246
    ("n1-1775" . 108.805754765252) ; p9 m203 p009-o000245
    ("n1-1781" . 121.492608223523) ; p9 m203 p009-o000244
    ("n1-1785" . 22.014626022817) ; p10 m204 p010-o000202
    ("n1-1786" . 21.150249367981) ; p10 m204 p010-o000203
    ("n1-1787" . 22.014626022817) ; p10 m204 p010-o000204
    ("n1-1788" . 27.045498893889) ; p10 m204 p010-o000200
    ("n1-1790" . 27.045498893889) ; p10 m204 p010-o000201
    ("n1-1791" . 36.400378996151) ; p10 m204 p010-o000198
    ("n1-1793" . 36.400378996151) ; p10 m204 p010-o000199
    ("n1-1847" . 57.402698712436) ; p10 m208 p010-o000195
    ("n1-1848" . 56.287077298129) ; p10 m208 p010-o000196
    ("n1-1849" . 57.402698712436) ; p10 m208 p010-o000197
    ("n1-1854" . 88.075944073338) ; p10 m209 p010-o000194
    ("n1-1856" . 97.692446162112) ; p10 m209 p010-o000187
    ("n1-1857" . 96.592449746334) ; p10 m209 p010-o000192
    ("n1-1858" . 97.692446162112) ; p10 m209 p010-o000193
    ("n1-1859" . 107.780206221664) ; p10 m209 p010-o000186
    ("n1-1860" . 106.900211440894) ; p10 m209 p010-o000190
    ("n1-1861" . 107.780206221664) ; p10 m209 p010-o000191
    ("n1-1862" . 117.396708310438) ; p10 m209 p010-o000188
    ("n1-1864" . 117.396708310438) ; p10 m209 p010-o000189
    ("n1-1865" . 11.757813392969) ; p10 m210 p010-o000183
    ("n1-1866" . 10.877813908495) ; p10 m210 p010-o000184
    ("n1-1867" . 11.757813392969) ; p10 m210 p010-o000185
    ("n1-1871" . 29.387542955399) ; p10 m210 p010-o000179
    ("n1-1872" . 28.287541835918) ; p10 m210 p010-o000180
    ("n1-1873" . 29.387542955399) ; p10 m210 p010-o000181
    ("n1-1874" . 36.420744331026) ; p10 m210 p010-o000176
    ("n1-1875" . 35.556369845082) ; p10 m210 p010-o000178
    ("n1-1876" . 36.420744331026) ; p10 m210 p010-o000177
    ("n1-1877" . 45.854462135702) ; p10 m210 p010-o000174
    ("n1-1879" . 45.854462135702) ; p10 m210 p010-o000175
    ("n1-1880" . 51.159028839443) ; p10 m211 p010-o000172
    ("n1-1882" . 51.159028839443) ; p10 m211 p010-o000173
    ("n1-1883" . 57.770850554769) ; p10 m211 p010-o000169
    ("n1-1884" . 56.890851070295) ; p10 m211 p010-o000170
    ("n1-1885" . 57.770850554769) ; p10 m211 p010-o000171
    ("n1-1886" . 63.799882426219) ; p10 m211 p010-o000166
    ("n1-1888" . 63.799882426219) ; p10 m211 p010-o000167
    ("n1-1889" . 70.031710724849) ; p10 m211 p010-o000163
    ("n1-1890" . 69.151711240375) ; p10 m211 p010-o000164
    ("n1-1891" . 70.031710724849) ; p10 m211 p010-o000165
    ("n1-1895" . 80.664415097723) ; p10 m211 p010-o000160
    ("n1-1896" . 79.564411626389) ; p10 m211 p010-o000161
    ("n1-1897" . 80.664415097723) ; p10 m211 p010-o000162
    ("n1-1898" . 90.444668873833) ; p10 m212 p010-o000156
    ("n1-1899" . 89.580301443444) ; p10 m212 p010-o000159
    ("n1-190" . 91.685498885646) ; p1 m25 p001-o000263
    ("n1-1900" . 90.444668873833) ; p10 m212 p010-o000157
    ("n1-1901" . 96.466872613635) ; p10 m212 p010-o000154
    ("n1-1903" . 96.466872613635) ; p10 m212 p010-o000155
    ("n1-1904" . 102.980170548775) ; p10 m212 p010-o000151
    ("n1-1906" . 102.980170548775) ; p10 m212 p010-o000152
    ("n1-1907" . 108.714714577841) ; p10 m212 p010-o000149
    ("n1-1909" . 108.714714577841) ; p10 m212 p010-o000150
    ("n1-191" . 91.685498885646) ; p1 m25 p001-o000264
    ("n1-1910" . 115.060058066283) ; p10 m212 p010-o000147
    ("n1-1912" . 115.060058066283) ; p10 m212 p010-o000148
    ("n1-1934" . 81.987281702282) ; p10 m214 p010-o000153
    ("n1-1935" . 81.987281702282) ; p10 m214 p010-o000158
    ("n1-1942" . 22.576844879656) ; p10 m216 p010-o000168
    ("n1-1943" . 22.576844879656) ; p10 m216 p010-o000182
    ("n1-197" . 107.404861005082) ; p1 m26 p001-o000262
    ("n1-1971" . 120.814310614350) ; p10 m218 p010-o000145
    ("n1-1972" . 120.814310614350) ; p10 m218 p010-o000146
    ("n1-1974" . 41.075962378186) ; p11 m220 p011-o000223
    ("n1-1976" . 41.075962378186) ; p11 m220 p011-o000224
    ("n1-1978" . 45.253798986742) ; p11 m220 p011-o000222
    ("n1-1984" . 63.143257172624) ; p11 m220 p011-o000220
    ("n1-1985" . 63.143257172624) ; p11 m220 p011-o000221
    ("n1-1990" . 103.985803472288) ; p11 m222 p011-o000203
    ("n1-1991" . 102.885804937491) ; p11 m222 p011-o000205
    ("n1-1992" . 103.985803472288) ; p11 m222 p011-o000204
    ("n1-2006" . 11.262812771609) ; p11 m223 p011-o000225
    ("n1-201" . 117.390367012135) ; p1 m26 p001-o000261
    ("n1-2014" . 29.297388710603) ; p11 m223 p011-o000217
    ("n1-2015" . 28.094265940452) ; p11 m223 p011-o000218
    ("n1-2016" . 29.297388710603) ; p11 m223 p011-o000219
    ("n1-2026" . 53.486703005601) ; p11 m224 p011-o000214
    ("n1-2027" . 52.606710576683) ; p11 m224 p011-o000215
    ("n1-2028" . 53.486703005601) ; p11 m224 p011-o000216
    ("n1-2029" . 63.494481990976) ; p11 m224 p011-o000211
    ("n1-2032" . 67.364179141124) ; p11 m224 p011-o000200
    ("n1-2033" . 66.161044611714) ; p11 m224 p011-o000212
    ("n1-2034" . 67.364179141124) ; p11 m224 p011-o000213
    ("n1-2041" . 88.736602793191) ; p11 m225 p011-o000208
    ("n1-2042" . 87.856605660569) ; p11 m225 p011-o000209
    ("n1-2043" . 88.736602793191) ; p11 m225 p011-o000210
    ("n1-2044" . 98.417222715014) ; p11 m225 p011-o000206
    ("n1-2045" . 97.537230286095) ; p11 m225 p011-o000207
    ("n1-2046" . 99.297229255043) ; p11 m225 p011-o000202
    ("n1-2059" . 115.568239171298) ; p11 m225 p011-o000201
    ("n1-2064" . 12.960938279786) ; p11 m226 p011-o000197
    ("n1-2065" . 10.877813908495) ; p11 m226 p011-o000198
    ("n1-2066" . 11.757813392969) ; p11 m226 p011-o000199
    ("n1-2067" . 13.840937999445) ; p11 m226 p011-o000195
    ("n1-2068" . 18.740842711813) ; p11 m226 p011-o000193
    ("n1-2069" . 17.860843227339) ; p11 m226 p011-o000196
    ("n1-2070" . 18.740842711813) ; p11 m226 p011-o000194
    ("n1-2072" . 23.640749776033) ; p11 m226 p011-o000192
    ("n1-2075" . 28.863777774078) ; p11 m226 p011-o000191
    ("n1-2077" . 33.060561080369) ; p11 m226 p011-o000189
    ("n1-2079" . 33.060561080369) ; p11 m226 p011-o000190
    ("n1-2082" . 38.283591430266) ; p11 m226 p011-o000188
    ("n1-2084" . 45.107866747081) ; p11 m227 p011-o000187
    ("n1-2085" . 46.207870218415) ; p11 m227 p011-o000186
    ("n1-2099" . 62.574211746258) ; p11 m227 p011-o000184
    ("n1-2102" . 62.574211746258) ; p11 m227 p011-o000185
    ("n1-2107" . 72.009568791715) ; p11 m228 p011-o000179
    ("n1-2110" . 72.009568791715) ; p11 m228 p011-o000180
    ("n1-2112" . 75.987914444519) ; p11 m228 p011-o000178
    ("n1-2123" . 87.599835172811) ; p11 m228 p011-o000176
    ("n1-2126" . 87.599835172811) ; p11 m228 p011-o000177
    ("n1-2131" . 97.439654302229) ; p11 m229 p011-o000174
    ("n1-2134" . 97.439654302229) ; p11 m229 p011-o000175
    ("n1-2136" . 102.283014144696) ; p11 m229 p011-o000170
    ("n1-2147" . 117.357150161323) ; p11 m229 p011-o000168
    ("n1-2149" . 117.357150161323) ; p11 m229 p011-o000169
    ("n1-215" . 35.010406824903) ; p2 m28 p002-o000290
    ("n1-218" . 43.806953403920) ; p2 m28 p002-o000289
    ("n1-2181" . 86.214364622277) ; p11 m231 p011-o000173
    ("n1-2182" . 91.767457867279) ; p11 m232 p011-o000172
    ("n1-2183" . 95.412066326739) ; p11 m232 p011-o000171
    ("n1-2189" . 121.417502538354) ; p11 m232 p011-o000167
    ("n1-219" . 46.633514263614) ; p2 m28 p002-o000288
    ("n1-2201" . 42.522729943148) ; p11 m233 p011-o000183
    ("n1-2202" . 47.081784756444) ; p11 m234 p011-o000181
    ("n1-2203" . 49.748345025330) ; p11 m234 p011-o000182
    ("n1-2209" . 67.036501023855) ; p11 m234 p011-o000165
    ("n1-2216" . 85.110698611965) ; p11 m235 p011-o000164
    ("n1-2227" . 113.665598032196) ; p11 m236 p011-o000166
    ("n1-2251" . 88.700541887732) ; p12 m239 p012-o000036
    ("n1-2259" . 105.845866290709) ; p12 m240 p012-o000034
    ("n1-226" . 66.889925804497) ; p2 m29 p002-o000279
    ("n1-2262" . 105.845866290709) ; p12 m240 p012-o000035
    ("n1-227" . 69.716489016043) ; p2 m29 p002-o000278
    ("n1-23" . 115.436937631051) ; p1 m6 p001-o000278
    ("n1-234" . 90.113108530675) ; p2 m30 p002-o000277
    ("n1-235" . 92.939671742221) ; p2 m30 p002-o000276
    ("n1-238" . 101.190695567816) ; p2 m31 p002-o000270
    ("n1-24" . 116.316930059969) ; p1 m6 p001-o000279
    ("n1-240" . 101.190695567816) ; p2 m31 p002-o000271
    ("n1-241" . 108.144233543737) ; p2 m31 p002-o000269
    ("n1-242" . 110.151825649353) ; p2 m31 p002-o000268
    ("n1-246" . 117.399112218425) ; p2 m31 p002-o000266
    ("n1-247" . 120.225682485525) ; p2 m31 p002-o000267
    ("n1-250" . 10.877813908495) ; p2 m32 p002-o000293
    ("n1-252" . 10.877813908495) ; p2 m32 p002-o000294
    ("n1-253" . 17.482305136604) ; p2 m32 p002-o000281
    ("n1-254" . 19.489900489383) ; p2 m32 p002-o000292
    ("n1-258" . 26.737181536909) ; p2 m32 p002-o000291
    ("n1-259" . 29.563745346743) ; p2 m32 p002-o000287
    ("n1-262" . 37.954158125916) ; p2 m33 p002-o000285
    ("n1-264" . 37.954158125916) ; p2 m33 p002-o000286
    ("n1-265" . 41.507216046102) ; p2 m33 p002-o000280
    ("n1-267" . 44.173778666841) ; p2 m33 p002-o000284
    ("n1-272" . 52.789816358936) ; p2 m33 p002-o000283
    ("n1-275" . 57.439545176300) ; p2 m33 p002-o000282
    ("n1-279" . 65.662419081007) ; p2 m34 p002-o000275
    ("n1-284" . 76.060026927764) ; p2 m34 p002-o000274
    ("n1-287" . 81.663615138814) ; p2 m34 p002-o000273
    ("n1-291" . 89.504207274918) ; p2 m34 p002-o000272
    ("n1-296" . 101.461812604252) ; p2 m35 p002-o000265
    ("n1-299" . 108.994914214320) ; p2 m35 p002-o000264
    ("n1-302" . 116.528013472537) ; p2 m35 p002-o000263
    ("n1-331" . 37.242827110380) ; p2 m43 p002-o000262
    ("n1-389" . 96.284205922132) ; p2 m54 p002-o000261
    ("n1-394" . 114.357058956506) ; p2 m55 p002-o000260
    ("n1-400" . 121.123390992275) ; p2 m55 p002-o000259
    ("n1-402" . 124.303939088541) ; p2 m55 p002-o000258
    ("n1-405" . 16.866443744079) ; p3 m56 p003-o000279
    ("n1-408" . 27.169394426249) ; p3 m56 p003-o000278
    ("n1-410" . 40.518178482615) ; p3 m57 p003-o000276
    ("n1-412" . 44.320677715147) ; p3 m57 p003-o000275
    ("n1-416" . 49.988162191105) ; p3 m57 p003-o000274
    ("n1-422" . 65.959298200954) ; p3 m58 p003-o000267
    ("n1-427" . 88.519573977169) ; p3 m59 p003-o000266
    ("n1-433" . 96.466517526361) ; p3 m59 p003-o000265
    ("n1-435" . 100.440003412066) ; p3 m59 p003-o000264
    ("n1-438" . 113.010463410448) ; p3 m60 p003-o000263
    ("n1-441" . 123.865953359541) ; p3 m60 p003-o000262
    ("n1-443" . 18.238637662500) ; p3 m61 p003-o000270
    ("n1-445" . 22.041135348043) ; p3 m61 p003-o000277
    ("n1-449" . 27.551799538303) ; p3 m61 p003-o000273
    ("n1-452" . 36.972624490812) ; p3 m62 p003-o000269
    ("n1-456" . 48.333889546310) ; p3 m62 p003-o000272
    ("n1-460" . 53.800708161425) ; p3 m62 p003-o000271
    ("n1-463" . 62.919477717661) ; p3 m63 p003-o000268
    ("n1-503" . 89.725836391446) ; p3 m69 p003-o000254
    ("n1-523" . 17.394870808541) ; p3 m71 p003-o000261
    ("n1-536" . 46.631137004687) ; p3 m72 p003-o000259
    ("n1-538" . 53.608284341906) ; p3 m72 p003-o000258
    ("n1-542" . 59.908999088516) ; p3 m73 p003-o000257
    ("n1-552" . 89.945187269031) ; p3 m74 p003-o000253
    ("n1-560" . 106.567652525357) ; p3 m75 p003-o000251
    ("n1-573" . 17.771179578851) ; p3 m76 p003-o000260
    ("n1-581" . 35.584789623554) ; p3 m77 p003-o000256
    ("n1-586" . 53.287303593319) ; p3 m77 p003-o000255
    ("n1-595" . 77.707790819894) ; p3 m78 p003-o000252
    ("n1-601" . 89.336252122664) ; p3 m79 p003-o000249
    ("n1-604" . 100.998460148481) ; p3 m79 p003-o000250
    ("n1-627" . 35.648393322125) ; p4 m82 p004-o000281
    ("n1-628" . 35.648393322125) ; p4 m82 p004-o000282
    ("n1-672" . 112.943461515585) ; p4 m85 p004-o000275
    ("n1-691" . 24.947342976491) ; p4 m86 p004-o000283
    ("n1-693" . 24.947342976491) ; p4 m86 p004-o000284
    ("n1-697" . 34.465856096202) ; p4 m87 p004-o000279
    ("n1-699" . 34.465856096202) ; p4 m87 p004-o000280
    ("n1-70" . 73.317475971835) ; p1 m14 p001-o000269
    ("n1-700" . 40.643068749053) ; p4 m87 p004-o000277
    ("n1-702" . 40.643068749053) ; p4 m87 p004-o000278
    ("n1-71" . 73.317475971835) ; p1 m14 p001-o000270
    ("n1-721" . 76.190376673543) ; p4 m88 p004-o000276
    ("n1-724" . 95.406626493273) ; p4 m89 p004-o000272
    ("n1-725" . 95.406626493273) ; p4 m89 p004-o000273
    ("n1-732" . 119.892568110337) ; p4 m90 p004-o000271
    ("n1-733" . 123.452908069590) ; p4 m90 p004-o000274
    ("n1-737" . 25.762531772343) ; p4 m91 p004-o000270
    ("n1-74" . 78.123981589327) ; p1 m14 p001-o000267
    ("n1-745" . 50.965913575463) ; p4 m92 p004-o000265
    ("n1-75" . 78.123981589327) ; p1 m14 p001-o000268
    ("n1-759" . 99.042616121042) ; p4 m94 p004-o000257
    ("n1-760" . 103.102338201761) ; p4 m94 p004-o000256
    ("n1-762" . 109.337694278255) ; p4 m95 p004-o000255
    ("n1-766" . 113.354753765338) ; p4 m95 p004-o000254
    ("n1-772" . 123.614707719841) ; p4 m95 p004-o000253
    ("n1-774" . 10.877813908495) ; p4 m96 p004-o000269
    ("n1-776" . 18.426621185614) ; p4 m96 p004-o000268
    ("n1-781" . 35.268242115816) ; p4 m97 p004-o000267
    ("n1-785" . 41.388527487645) ; p4 m97 p004-o000266
    ("n1-791" . 51.333989452979) ; p4 m97 p004-o000264
    ("n1-794" . 57.099161649461) ; p4 m98 p004-o000263
    ("n1-797" . 63.716884866783) ; p4 m98 p004-o000258
    ("n1-821" . 40.532114725970) ; p4 m102 p004-o000262
    ("n1-822" . 45.151958561122) ; p4 m102 p004-o000261
    ("n1-824" . 54.319460840772) ; p4 m102 p004-o000260
    ("n1-825" . 58.903203749115) ; p4 m102 p004-o000259
    ("n1-836" . 113.426997952290) ; p4 m105 p004-o000252
    ("n1-841" . 17.802767531741) ; p5 m106 p005-o000300
    ("n1-847" . 25.607725107517) ; p5 m106 p005-o000299
    ("n1-849" . 29.510208599107) ; p5 m106 p005-o000296
    ("n1-852" . 41.499328558181) ; p5 m107 p005-o000295
    ("n1-855" . 51.589290872820) ; p5 m107 p005-o000294
    ("n1-857" . 64.696687955861) ; p5 m108 p005-o000290
    ("n1-859" . 68.499184836542) ; p5 m108 p005-o000289
    ("n1-863" . 74.081475846968) ; p5 m108 p005-o000288
    ("n1-869" . 89.740227193080) ; p5 m109 p005-o000287
    ("n1-874" . 111.874542697192) ; p5 m110 p005-o000284
    ("n1-880" . 119.679490865562) ; p5 m110 p005-o000283
    ("n1-882" . 123.581964949747) ; p5 m110 p005-o000282
    ("n1-885" . 16.788041275189) ; p5 m111 p005-o000298
    ("n1-888" . 26.973382727868) ; p5 m111 p005-o000297
    ("n1-890" . 39.985005768152) ; p5 m112 p005-o000291
    ("n1-892" . 43.787508157398) ; p5 m112 p005-o000293
    ("n1-896" . 49.306008718221) ; p5 m112 p005-o000292
    ("n1-901" . 66.710630069593) ; p5 m113 p005-o000281
    ("n1-903" . 70.513125403284) ; p5 m113 p005-o000286
    ("n1-907" . 75.987425259322) ; p5 m113 p005-o000285
    ("n1-912" . 92.283689361379) ; p5 m114 p005-o000280
    ("n1-918" . 113.948168335400) ; p5 m115 p005-o000279
    ("n1-922" . 10.881314169691) ; p5 m116 p005-o000277
    ("n1-931" . 36.629988595400) ; p5 m116 p005-o000276
    ("n1-932" . 40.742179786661) ; p5 m117 p005-o000274
    ("n1-933" . 43.408742407399) ; p5 m117 p005-o000275
    ("n1-939" . 57.293131341240) ; p5 m117 p005-o000269
    ("n1-954" . 94.378976099634) ; p5 m118 p005-o000263
    ("n1-955" . 98.491162587191) ; p5 m119 p005-o000262
    ("n1-956" . 101.697736276685) ; p5 m119 p005-o000278
    ("n1-966" . 125.167917757808) ; p5 m119 p005-o000255
    ("n1-973" . 28.947419035381) ; p5 m120 p005-o000273
    ("n1-975" . 33.413650016778) ; p5 m120 p005-o000272
    ("n1-976" . 37.525838856187) ; p5 m121 p005-o000270
    ("n1-977" . 40.192399125073) ; p5 m121 p005-o000271
    ("n1-983" . 54.099097726126) ; p5 m121 p005-o000268
    ("n1-984" . 55.214726195990) ; p5 m121 p005-o000267
    ("n1-996" . 87.450422021010) ; p5 m122 p005-o000264
    ("n1-998" . 92.988549491572) ; p5 m122 p005-o000261
    ("n1-999" . 97.480731747677) ; p5 m123 p005-o000260
    ("n2-101" . 111.637493354842) ; p4 m90 p004-o000250
    ("n2-115" . 60.724762441790) ; p4 m93 p004-o000249
    ("n2-117" . 67.637217388539) ; p4 m93 p004-o000247
    ("n2-120" . 83.409366588896) ; p4 m94 p004-o000246
    ("n2-123" . 96.593260429687) ; p4 m99 p004-o000244
    ("n2-124" . 97.473252858605) ; p4 m99 p004-o000245
    ("n2-125" . 108.708496986948) ; p4 m100 p004-o000243
    ("n2-131" . 29.927353411187) ; p4 m101 p004-o000248
    ("n2-136" . 65.046951195592) ; p4 m103 p004-o000242
    ("n2-154" . 73.896643728585) ; p7 m156 p007-o000257
    ("n2-16" . 60.114659130581) ; p1 m19 p001-o000260
    ("n2-160" . 10.961248238551) ; p9 m187 p009-o000243
    ("n2-164" . 39.660733439444) ; p9 m188 p009-o000242
    ("n2-172" . 93.941701554618) ; p9 m190 p009-o000241
    ("n2-174" . 22.235151371304) ; p9 m194 p009-o000240
    ("n2-176" . 41.950757206944) ; p9 m195 p009-o000238
    ("n2-183" . 89.096850766812) ; p9 m196 p009-o000237
    ("n2-188" . 113.316188803285) ; p9 m197 p009-o000236
    ("n2-190" . 10.878749945555) ; p9 m198 p009-o000239
    ("n2-201" . 18.451417465849) ; p10 m213 p010-o000144
    ("n2-208" . 90.615088766887) ; p10 m215 p010-o000142
    ("n2-209" . 90.615088766887) ; p10 m215 p010-o000143
    ("n2-218" . 115.019888435671) ; p10 m215 p010-o000139
    ("n2-219" . 113.816768017373) ; p10 m215 p010-o000140
    ("n2-220" . 115.019888435671) ; p10 m215 p010-o000141
    ("n2-235" . 10.882809995829) ; p11 m219 p011-o000162
    ("n2-236" . 10.882809995829) ; p11 m219 p011-o000163
    ("n2-245" . 29.796788749157) ; p11 m219 p011-o000159
    ("n2-246" . 28.593666233667) ; p11 m219 p011-o000160
    ("n2-247" . 29.796788749157) ; p11 m219 p011-o000161
    ("n2-25" . 82.765242093521) ; p1 m20 p001-o000259
    ("n2-254" . 69.481083506412) ; p11 m221 p011-o000157
    ("n2-255" . 69.481083506412) ; p11 m221 p011-o000158
    ("n2-264" . 88.395062259739) ; p11 m221 p011-o000154
    ("n2-265" . 87.191942096101) ; p11 m221 p011-o000155
    ("n2-266" . 88.395062259739) ; p11 m221 p011-o000156
    ("n2-37" . 66.518846659350) ; p1 m24 p001-o000258
    ("n2-57" . 14.005313633093) ; p2 m42 p002-o000257
    ("n2-71" . 57.538228882416) ; p2 m44 p002-o000256
    ("n2-75" . 69.542657231413) ; p2 m44 p002-o000255
    ("n2-79" . 79.754487592147) ; p3 m63 p003-o000248
    ("n2-83" . 101.007145537582) ; p3 m64 p003-o000247
    ("n2-93" . 65.263926702748) ; p4 m88 p004-o000251
    ("n5-1" . 16.494831193948) ; p1 m1 p001-o000257
    ("n5-1006" . 112.897318568971) ; p6 m142 p006-o000122
    ("n5-101" . 115.231978440856) ; p1 m16 p001-o000228
    ("n5-102" . 117.882920766768) ; p1 m16 p001-o000225
    ("n5-104" . 118.363124241469) ; p1 m16 p001-o000226
    ("n5-1040" . 27.483250632384) ; p7 m148 p007-o000256
    ("n5-1063" . 123.879273507917) ; p7 m152 p007-o000255
    ("n5-1077" . 69.519042991947) ; p7 m155 p007-o000254
    ("n5-108" . 15.758452955577) ; p1 m17 p001-o000240
    ("n5-1080" . 78.704887364638) ; p7 m156 p007-o000253
    ("n5-1083" . 85.917252818718) ; p7 m156 p007-o000252
    ("n5-1085" . 99.540998705447) ; p7 m157 p007-o000251
    ("n5-1093" . 121.680262016999) ; p7 m157 p007-o000250
    ("n5-1097" . 16.509328009117) ; p7 m158 p007-o000249
    ("n5-1099" . 22.774435247449) ; p7 m158 p007-o000248
    ("n5-11" . 47.294080078300) ; p1 m3 p001-o000253
    ("n5-110" . 20.204122636471) ; p1 m17 p001-o000239
    ("n5-1102" . 32.437332083653) ; p7 m158 p007-o000246
    ("n5-1104" . 38.702441673837) ; p7 m158 p007-o000245
    ("n5-1109" . 55.790120876721) ; p7 m159 p007-o000244
    ("n5-1113" . 70.325210083876) ; p7 m159 p007-o000241
    ("n5-1114" . 73.498201679956) ; p7 m159 p007-o000240
    ("n5-1115" . 77.051191396437) ; p7 m159 p007-o000239
    ("n5-1119" . 93.203164680151) ; p7 m160 p007-o000238
    ("n5-1121" . 99.078551712661) ; p7 m160 p007-o000237
    ("n5-1137" . 26.511899523995) ; p7 m161 p007-o000247
    ("n5-1141" . 36.920886100659) ; p7 m162 p007-o000243
    ("n5-1149" . 54.851049457470) ; p7 m162 p007-o000242
    ("n5-1153" . 65.764390676093) ; p7 m163 p007-o000236
    ("n5-1155" . 71.635318127011) ; p7 m163 p007-o000235
    ("n5-1163" . 94.341489226496) ; p7 m163 p007-o000234
    ("n5-1165" . 102.053023489074) ; p7 m164 p007-o000233
    ("n5-117" . 39.296835790219) ; p1 m18 p001-o000235
    ("n5-1196" . 69.401299172402) ; p7 m167 p007-o000232
    ("n5-1212" . 108.811133450568) ; p7 m168 p007-o000231
    ("n5-1213" . 113.479472472091) ; p7 m168 p007-o000230
    ("n5-1218" . 19.550069597209) ; p8 m169 p008-o000155
    ("n5-1226" . 33.667977158334) ; p8 m169 p008-o000154
    ("n5-123" . 60.494666658388) ; p1 m19 p001-o000233
    ("n5-1238" . 63.263793588214) ; p8 m170 p008-o000153
    ("n5-124" . 60.494666658388) ; p1 m19 p001-o000234
    ("n5-1242" . 77.555150305159) ; p8 m171 p008-o000152
    ("n5-1246" . 92.859621777359) ; p8 m171 p008-o000151
    ("n5-1250" . 107.150969086892) ; p8 m172 p008-o000150
    ("n5-1287" . 85.470086328410) ; p8 m175 p008-o000147
    ("n5-1288" . 85.470086328410) ; p8 m175 p008-o000148
    ("n5-1291" . 94.503870697932) ; p8 m175 p008-o000149
    ("n5-13" . 54.289315508554) ; p1 m3 p001-o000252
    ("n5-1313" . 39.197424656307) ; p8 m177 p008-o000144
    ("n5-1343" . 22.230292445259) ; p8 m180 p008-o000145
    ("n5-1344" . 22.230292445259) ; p8 m180 p008-o000146
    ("n5-1347" . 34.784830715111) ; p8 m180 p008-o000143
    ("n5-135" . 108.805322730056) ; p1 m21 p001-o000223
    ("n5-1353" . 54.930549577932) ; p8 m181 p008-o000142
    ("n5-1361" . 76.572307310656) ; p8 m181 p008-o000138
    ("n5-1362" . 76.572307310656) ; p8 m181 p008-o000139
    ("n5-1365" . 91.400519110161) ; p8 m182 p008-o000137
    ("n5-137" . 108.805322730056) ; p1 m21 p001-o000224
    ("n5-1371" . 112.849575975212) ; p8 m182 p008-o000136
    ("n5-1373" . 120.453298994414) ; p8 m182 p008-o000134
    ("n5-1374" . 120.453298994414) ; p8 m182 p008-o000135
    ("n5-1377" . 20.350108434484) ; p8 m183 p008-o000141
    ("n5-1383" . 35.349679691881) ; p8 m184 p008-o000140
    ("n5-1395" . 66.244638835980) ; p8 m185 p008-o000133
    ("n5-1407" . 97.139595628227) ; p8 m186 p008-o000132
    ("n5-1419" . 10.258121746523) ; p9 m187 p009-o000235
    ("n5-1431" . 38.957598316244) ; p9 m188 p009-o000234
    ("n5-1456" . 97.472301488089) ; p9 m190 p009-o000228
    ("n5-1457" . 100.461993114110) ; p9 m190 p009-o000227
    ("n5-146" . 16.188994725361) ; p1 m22 p001-o000231
    ("n5-1462" . 114.738226417057) ; p9 m190 p009-o000226
    ("n5-1463" . 117.404801957342) ; p9 m190 p009-o000225
    ("n5-1468" . 13.287801129085) ; p9 m191 p009-o000232
    ("n5-1469" . 15.954361366709) ; p9 m191 p009-o000233
    ("n5-148" . 16.188994725361) ; p1 m22 p001-o000232
    ("n5-1482" . 50.419619629686) ; p9 m192 p009-o000230
    ("n5-1483" . 53.663537828399) ; p9 m192 p009-o000231
    ("n5-1485" . 59.505130583874) ; p9 m192 p009-o000229
    ("n5-1487" . 65.346718635649) ; p9 m192 p009-o000224
    ("n5-1489" . 70.952684968166) ; p9 m192 p009-o000223
    ("n5-1490" . 74.109099537386) ; p9 m192 p009-o000222
    ("n5-1491" . 78.574265843036) ; p9 m193 p009-o000221
    ("n5-1492" . 82.461045018121) ; p9 m193 p009-o000220
    ("n5-1493" . 85.789077125199) ; p9 m193 p009-o000218
    ("n5-1494" . 89.763364633475) ; p9 m193 p009-o000219
    ("n5-1496" . 96.450036526579) ; p9 m193 p009-o000217
    ("n5-1497" . 100.336820405364) ; p9 m193 p009-o000216
    ("n5-1498" . 103.752346734534) ; p9 m193 p009-o000214
    ("n5-1499" . 107.639130613319) ; p9 m193 p009-o000215
    ("n5-15" . 61.140177100093) ; p1 m3 p001-o000251
    ("n5-1500" . 111.290283365446) ; p9 m193 p009-o000213
    ("n5-1501" . 114.941445524973) ; p9 m193 p009-o000212
    ("n5-1503" . 10.877813908495) ; p9 m194 p009-o000211
    ("n5-1515" . 41.806381016378) ; p9 m195 p009-o000208
    ("n5-1527" . 70.845813670675) ; p9 m196 p009-o000194
    ("n5-1552" . 15.324923393128) ; p9 m198 p009-o000210
    ("n5-1553" . 18.567969602032) ; p9 m198 p009-o000209
    ("n5-1558" . 36.362978144428) ; p9 m198 p009-o000206
    ("n5-1559" . 39.606026705184) ; p9 m198 p009-o000207
    ("n5-1578" . 96.901322455736) ; p9 m200 p009-o000193
    ("n5-1579" . 100.586667342119) ; p9 m200 p009-o000192
    ("n5-1580" . 103.948898350232) ; p9 m200 p009-o000190
    ("n5-1581" . 107.075502724809) ; p9 m200 p009-o000191
    ("n5-1582" . 110.673343903497) ; p9 m200 p009-o000189
    ("n5-1583" . 113.799950629925) ; p9 m200 p009-o000188
    ("n5-1585" . 120.760027520430) ; p9 m200 p009-o000187
    ("n5-1586" . 123.886620135747) ; p9 m200 p009-o000186
    ("n5-1587" . 10.877813908495) ; p9 m201 p009-o000205
    ("n5-1588" . 13.836331427110) ; p9 m201 p009-o000204
    ("n5-1590" . 20.137118375574) ; p9 m201 p009-o000203
    ("n5-1591" . 23.654388165255) ; p9 m201 p009-o000201
    ("n5-1592" . 26.468527141453) ; p9 m201 p009-o000202
    ("n5-1593" . 29.680092166254) ; p9 m201 p009-o000200
    ("n5-1594" . 33.122280730026) ; p9 m201 p009-o000199
    ("n5-1595" . 36.333843402975) ; p9 m201 p009-o000198
    ("n5-1599" . 51.286037544399) ; p9 m202 p009-o000197
    ("n5-1600" . 54.815734519570) ; p9 m202 p009-o000195
    ("n5-1601" . 58.114263266867) ; p9 m202 p009-o000196
    ("n5-1611" . 90.619549524404) ; p9 m203 p009-o000183
    ("n5-1612" . 94.149225332907) ; p9 m203 p009-o000185
    ("n5-1613" . 97.525158230245) ; p9 m203 p009-o000184
    ("n5-1623" . 10.878754806746) ; p10 m204 p010-o000137
    ("n5-1624" . 14.408443951757) ; p10 m204 p010-o000136
    ("n5-1625" . 17.455010522778) ; p10 m204 p010-o000138
    ("n5-1637" . 71.889425986776) ; p10 m206 p010-o000134
    ("n5-1649" . 100.016787761616) ; p10 m207 p010-o000133
    ("n5-1661" . 10.877804186961) ; p10 m208 p010-o000135
    ("n5-1676" . 82.534169437890) ; p10 m209 p010-o000132
    ("n5-1688" . 20.697892298541) ; p10 m210 p010-o000131
    ("n5-1701" . 60.421788176977) ; p10 m211 p010-o000129
    ("n5-1714" . 99.733449100892) ; p10 m212 p010-o000128
    ("n5-1718" . 109.037842567221) ; p10 m212 p010-o000127
    ("n5-1728" . 18.071416993598) ; p10 m213 p010-o000130
    ("n5-173" . 91.685498885646) ; p1 m25 p001-o000221
    ("n5-174" . 91.685498885646) ; p1 m25 p001-o000222
    ("n5-18" . 72.853329295674) ; p1 m4 p001-o000249
    ("n5-1834" . 99.674303877982) ; p11 m222 p011-o000145
    ("n5-1835" . 99.674303877982) ; p11 m222 p011-o000147
    ("n5-1837" . 103.985871948897) ; p11 m222 p011-o000146
    ("n5-184" . 120.216937877525) ; p1 m26 p001-o000220
    ("n5-1846" . 10.882802573356) ; p11 m223 p011-o000151
    ("n5-1847" . 10.882802573356) ; p11 m223 p011-o000153
    ("n5-1851" . 21.608568136922) ; p11 m223 p011-o000152
    ("n5-1859" . 54.189778333922) ; p11 m224 p011-o000150
    ("n5-1860" . 59.592588822664) ; p11 m224 p011-o000148
    ("n5-1861" . 59.300097023212) ; p11 m224 p011-o000149
    ("n5-1866" . 89.059653541479) ; p11 m225 p011-o000143
    ("n5-1867" . 89.059653541479) ; p11 m225 p011-o000144
    ("n5-1868" . 100.103695645047) ; p11 m225 p011-o000140
    ("n5-1869" . 99.223701650730) ; p11 m225 p011-o000141
    ("n5-1870" . 100.103695645047) ; p11 m225 p011-o000142
    ("n5-1883" . 13.784063164722) ; p11 m226 p011-o000138
    ("n5-1884" . 18.683967877090) ; p11 m226 p011-o000136
    ("n5-1885" . 17.803970744467) ; p11 m226 p011-o000139
    ("n5-1886" . 18.683967877090) ; p11 m226 p011-o000137
    ("n5-1894" . 33.060561080369) ; p11 m226 p011-o000135
    ("n5-1897" . 37.960463440885) ; p11 m226 p011-o000134
    ("n5-1899" . 46.207870218415) ; p11 m227 p011-o000132
    ("n5-190" . 14.689358676744) ; p2 m27 p002-o000254
    ("n5-1900" . 46.207870218415) ; p11 m227 p011-o000133
    ("n5-1944" . 117.592765035601) ; p11 m229 p011-o000128
    ("n5-1974" . 67.046985579667) ; p11 m231 p011-o000129
    ("n5-1976" . 67.046985579667) ; p11 m231 p011-o000130
    ("n5-198" . 25.499504993748) ; p2 m27 p002-o000252
    ("n5-1986" . 28.021839014608) ; p11 m233 p011-o000131
    ("n5-199" . 25.499504993748) ; p2 m27 p002-o000253
    ("n5-2" . 19.706393866897) ; p1 m1 p001-o000256
    ("n5-202" . 35.702957913709) ; p2 m28 p002-o000248
    ("n5-203" . 35.702957913709) ; p2 m28 p002-o000249
    ("n5-205" . 43.426979257715) ; p2 m28 p002-o000251
    ("n5-206" . 46.633544972661) ; p2 m28 p002-o000247
    ("n5-212" . 60.383730916036) ; p2 m29 p002-o000250
    ("n5-214" . 66.509969210717) ; p2 m29 p002-o000242
    ("n5-215" . 69.716534925663) ; p2 m29 p002-o000239
    ("n5-221" . 83.606921879559) ; p2 m30 p002-o000241
    ("n5-223" . 89.733167229798) ; p2 m30 p002-o000240
    ("n5-224" . 92.939732944745) ; p2 m30 p002-o000238
    ("n5-230" . 107.105329028345) ; p2 m31 p002-o000237
    ("n5-232" . 117.019193589601) ; p2 m31 p002-o000236
    ("n5-233" . 120.225761656401) ; p2 m31 p002-o000235
    ("n5-239" . 16.443320349084) ; p2 m32 p002-o000246
    ("n5-241" . 26.357155157317) ; p2 m32 p002-o000245
    ("n5-242" . 29.563718925538) ; p2 m32 p002-o000244
    ("n5-249" . 49.743211162105) ; p2 m33 p002-o000243
    ("n5-254" . 91.901144367783) ; p2 m34 p002-o000234
    ("n5-256" . 98.635165347506) ; p2 m35 p002-o000233
    ("n5-262" . 19.928406335287) ; p2 m36 p002-o000231
    ("n5-263" . 19.928406335287) ; p2 m36 p002-o000232
    ("n5-264" . 23.607964960417) ; p2 m36 p002-o000229
    ("n5-265" . 23.607964960417) ; p2 m36 p002-o000230
    ("n5-268" . 35.289347634851) ; p2 m37 p002-o000227
    ("n5-269" . 38.500907955948) ; p2 m37 p002-o000226
    ("n5-274" . 54.163119133247) ; p2 m38 p002-o000225
    ("n5-275" . 55.043111562165) ; p2 m38 p002-o000224
    ("n5-278" . 66.558910456625) ; p2 m39 p002-o000221
    ("n5-280" . 73.455431606688) ; p2 m39 p002-o000220
    ("n5-282" . 80.207581269889) ; p2 m39 p002-o000219
    ("n5-285" . 91.755334776242) ; p2 m40 p002-o000218
    ("n5-296" . 20.265162600926) ; p2 m42 p002-o000228
    ("n5-300" . 37.242827110380) ; p2 m43 p002-o000223
    ("n5-308" . 62.696719712216) ; p2 m44 p002-o000222
    ("n5-311" . 80.190930158371) ; p2 m45 p002-o000217
    ("n5-312" . 84.182813776321) ; p2 m45 p002-o000216
    ("n5-321" . 102.133311009555) ; p2 m46 p002-o000214
    ("n5-322" . 103.013308142177) ; p2 m46 p002-o000215
    ("n5-326" . 108.962559787603) ; p2 m46 p002-o000212
    ("n5-327" . 109.842559272077) ; p2 m46 p002-o000213
    ("n5-361" . 103.763031493837) ; p2 m54 p002-o000211
    ("n5-365" . 117.942864062677) ; p2 m55 p002-o000210
    ("n5-366" . 123.923945671845) ; p2 m55 p002-o000209
    ("n5-369" . 16.866454850950) ; p3 m56 p003-o000246
    ("n5-374" . 27.169412317806) ; p3 m56 p003-o000245
    ("n5-387" . 75.614337742313) ; p3 m58 p003-o000244
    ("n5-391" . 92.493113715736) ; p3 m59 p003-o000243
    ("n5-392" . 100.060061856085) ; p3 m59 p003-o000242
    ("n5-395" . 113.010537829966) ; p3 m60 p003-o000241
    ("n5-400" . 123.866034927604) ; p3 m60 p003-o000240
    ("n5-41" . 61.094500137866) ; p1 m9 p001-o000250
    ("n5-417" . 90.711668105450) ; p3 m64 p003-o000239
    ("n5-437" . 40.318426167043) ; p3 m67 p003-o000237
    ("n5-438" . 40.318426167043) ; p3 m67 p003-o000238
    ("n5-46" . 66.409085025185) ; p1 m9 p001-o000248
    ("n5-472" . 38.289699189674) ; p3 m72 p003-o000236
    ("n5-486" . 89.565175037519) ; p3 m74 p003-o000233
    ("n5-49" . 86.763084598653) ; p1 m10 p001-o000247
    ("n5-502" . 17.391179106599) ; p3 m76 p003-o000235
    ("n5-513" . 52.907303121067) ; p3 m77 p003-o000234
    ("n5-521" . 77.707790819894) ; p3 m78 p003-o000232
    ("n5-525" . 88.956242243004) ; p3 m79 p003-o000231
    ("n5-529" . 100.998460148481) ; p3 m79 p003-o000230
    ("n5-564" . 64.278557697950) ; p4 m83 p004-o000234
    ("n5-565" . 64.278557697950) ; p4 m83 p004-o000235
    ("n5-59" . 115.351593628965) ; p1 m11 p001-o000245
    ("n5-61" . 115.794797769428) ; p1 m11 p001-o000246
    ("n5-610" . 24.947342976491) ; p4 m86 p004-o000240
    ("n5-612" . 24.947342976491) ; p4 m86 p004-o000241
    ("n5-616" . 34.465856096202) ; p4 m87 p004-o000237
    ("n5-618" . 34.465856096202) ; p4 m87 p004-o000239
    ("n5-619" . 40.643068749053) ; p4 m87 p004-o000236
    ("n5-621" . 40.643068749053) ; p4 m87 p004-o000238
    ("n5-63" . 15.720803804657) ; p1 m12 p001-o000243
    ("n5-649" . 17.559909664427) ; p4 m91 p004-o000232
    ("n5-65" . 16.164005122898) ; p1 m12 p001-o000244
    ("n5-650" . 17.559909664427) ; p4 m91 p004-o000233
    ("n5-66" . 18.814940863624) ; p1 m12 p001-o000241
    ("n5-68" . 19.295139634622) ; p1 m12 p001-o000242
    ("n5-686" . 41.008524663542) ; p4 m97 p004-o000231
    ("n5-694" . 50.953988980727) ; p4 m97 p004-o000230
    ("n5-698" . 56.719163529061) ; p4 m98 p004-o000229
    ("n5-7" . 34.706283565042) ; p1 m2 p001-o000254
    ("n5-702" . 63.336891450087) ; p4 m98 p004-o000224
    ("n5-71" . 38.124395280078) ; p1 m13 p001-o000237
    ("n5-713" . 97.617631401024) ; p4 m99 p004-o000222
    ("n5-714" . 97.617631401024) ; p4 m99 p004-o000223
    ("n5-717" . 108.744593210053) ; p4 m100 p004-o000221
    ("n5-722" . 23.480108883217) ; p4 m101 p004-o000228
    ("n5-725" . 40.188208124971) ; p4 m102 p004-o000227
    ("n5-727" . 49.735706173169) ; p4 m102 p004-o000226
    ("n5-728" . 54.319460840772) ; p4 m102 p004-o000225
    ("n5-738" . 123.685115110451) ; p4 m105 p004-o000220
    ("n5-742" . 21.705262964795) ; p5 m106 p005-o000251
    ("n5-743" . 29.130225038226) ; p5 m106 p005-o000250
    ("n5-746" . 41.499355886271) ; p5 m107 p005-o000249
    ("n5-751" . 51.589324845339) ; p5 m107 p005-o000248
    ("n5-759" . 89.740286288709) ; p5 m109 p005-o000244
    ("n5-762" . 99.182303294252) ; p5 m109 p005-o000243
    ("n5-766" . 115.777093022723) ; p5 m110 p005-o000241
    ("n5-768" . 123.202052744301) ; p5 m110 p005-o000242
    ("n5-770" . 16.344824879147) ; p5 m111 p005-o000246
    ("n5-771" . 16.788026271668) ; p5 m111 p005-o000247
    ("n5-774" . 26.973358621677) ; p5 m111 p005-o000245
    ("n5-79" . 45.055130466162) ; p1 m13 p001-o000238
    ("n5-8" . 35.586283049517) ; p1 m2 p001-o000255
    ("n5-801" . 24.118421011784) ; p5 m116 p005-o000239
    ("n5-803" . 24.118421011784) ; p5 m116 p005-o000240
    ("n5-812" . 81.801140384769) ; p5 m118 p005-o000236
    ("n5-82" . 60.271152062184) ; p1 m14 p001-o000236
    ("n5-825" . 22.414638359024) ; p5 m120 p005-o000238
    ("n5-837" . 79.355113269421) ; p5 m122 p005-o000235
    ("n5-838" . 79.355113269421) ; p5 m122 p005-o000237
    ("n5-862" . 77.149247863648) ; p5 m126 p005-o000234
    ("n5-863" . 86.937238526984) ; p5 m126 p005-o000233
    ("n5-865" . 111.168197063741) ; p5 m127 p005-o000232
    ("n5-917" . 120.416635974999) ; p6 m134 p006-o000124
    ("n5-95" . 98.020484112723) ; p1 m15 p001-o000229
    ("n5-958" . 113.440003693348) ; p6 m138 p006-o000123
    ("n5-97" . 98.463688253186) ; p1 m15 p001-o000230
    ("n5-99" . 114.788786059652) ; p1 m16 p001-o000227
    ("n6-101" . 22.500527285198) ; p7 m158 p007-o000226
    ("n6-116" . 110.007946202046) ; p7 m160 p007-o000224
    ("n6-126" . 16.468537254416) ; p7 m161 p007-o000225
    ("n6-153" . 114.081358412729) ; p7 m164 p007-o000223
    ("n6-156" . 122.656774448277) ; p7 m164 p007-o000222
    ("n6-16" . 49.752566018570) ; p3 m57 p003-o000229
    ("n6-166" . 43.121151354320) ; p10 m205 p010-o000126
    ("n6-20" . 27.316146140372) ; p3 m61 p003-o000228
    ("n6-24" . 53.565038360317) ; p3 m62 p003-o000227
    ("n6-49" . 73.845900244040) ; p5 m108 p005-o000230
    ("n6-53" . 49.070342934039) ; p5 m112 p005-o000231
    ("n6-62" . 77.149247863648) ; p5 m126 p005-o000229
    ("n6-69" . 120.976070988674) ; p6 m130 p006-o000121
    ("n6-80" . 49.356502220796) ; p7 m149 p007-o000229
    ("n6-84" . 24.987618440438) ; p7 m153 p007-o000228
    ("n6-88" . 48.182040581487) ; p7 m154 p007-o000227
  ))
#(define op47-source-accidental-force-ids '("n1-452" "n1-463" "n1-939" "n1-983" "n6-116" "n5-1373" "n2-172" "n1-1739" "n1-2072" "n1-2189" "n1-2209"))
#(define op47-source-accidental-hide-ids '("n1-1680" "n1-1747" "n1-454" "n2-77" "n6-118"))

#(define op47-positioned-accidentals (make-hash-table))
#(define (op47-source-accidental-positioner nid)
   (lambda (grob)
     (unless (hashq-ref op47-positioned-accidentals grob #f)
       (let* ((target (hash-ref op47-source-accidental-targets nid #f))
              (staff (ly:grob-object grob 'staff-symbol))
              (system (ly:grob-system grob)))
         (when (and target (ly:grob? staff) (ly:grob? system))
           (hashq-set! op47-positioned-accidentals grob #t)
           (concerto-place-columns system)
           (let* ((left (ly:spanner-bound staff LEFT))
                  (space (ly:staff-symbol-staff-space grob))
                  (origin (ly:grob-relative-coordinate left system X))
                  (stencil (ly:grob-property grob 'stencil)))
             (when (ly:stencil? stencil)
               (let* ((extent (stencil-true-extent stencil X))
                      (now (+ (ly:grob-relative-coordinate grob system X) (car extent)))
                      (goal (+ origin (* target space))))
                 (ly:grob-translate-axis! grob (- goal now) X)))))))))
#(define (op47-source-accidental-properties nid music)
   (define (tweak grob property value)
     (set! (ly:music-property music 'tweaks)
       (acons (cons grob property) value (ly:music-property music 'tweaks))))
   (when (member nid op47-source-accidental-force-ids)
     (set! (ly:music-property music 'force-accidental) #t))
   (for-each (lambda (grob)
     (cond
       ((member nid op47-source-accidental-hide-ids)
        (tweak grob 'transparent #t))
       ((hash-ref op47-source-accidental-targets nid #f)
        (tweak grob 'restore-first #f)
        (tweak grob 'after-line-breaking (op47-source-accidental-positioner nid)))))
     '(Accidental AccidentalCautionary)))


% Source-specific event display properties; no pitch or duration is changed.
#(define concerto-cue-note-ids (make-hash-table 211))
#(for-each (lambda (nid) (hash-set! concerto-cue-note-ids nid #t))
  '("n1-162" "n1-163" "n1-164" "n1-196" "n1-197" "n1-198" "n1-213" "n1-214" "n1-215" "n1-241" "n1-242" "n1-243" "n1-244" "n1-253" "n1-254" "n1-255" "n1-256" "n1-396" "n1-412" "n1-429" "n1-445" "n1-456" "n1-475" "n1-512" "n1-553" "n1-574" "n1-623" "n1-624" "n1-683" "n1-684" "n5-605" "n5-606" "n1-798" "n1-799" "n1-800" "n6-41" "n6-43" "n1-843" "n1-859" "n1-876" "n1-892" "n1-903" "n1-922" "n1-923" "n1-924" "n1-941" "n1-942" "n1-943" "n1-944" "n1-945" "n1-946" "n1-947" "n1-967" "n1-968" "n1-985" "n1-986" "n1-987" "n1-988" "n1-989" "n1-990" "n1-991" "n1-1132" "n1-1133" "n1-1145" "n1-1208" "n1-1235" "n1-1252" "n1-1269" "n1-1286" "n1-1297" "n1-1676" "n1-1726" "n1-1754" "n1-1811" "n2-214" "n2-241" "n2-260" "n1-2171" "n1-2172" "n1-2173" "n1-2174" "n1-2191" "n1-2192" "n1-2193" "n1-2194" "n1-2216" "n1-2217" "n1-2218" "n1-2220" "n1-2221" "n1-2227" "n1-2228" "n1-2229" "n1-2231" "n1-2232"))
#(define op47-source-grace-note-ids (make-hash-table 113))
#(for-each (lambda (nid) (hash-set! op47-source-grace-note-ids nid #t))
  '("n1-162" "n1-163" "n1-164" "n1-196" "n1-197" "n1-198" "n1-213" "n1-214" "n1-215" "n1-396" "n1-412" "n1-429" "n1-445" "n1-456" "n1-475" "n1-512" "n1-553" "n1-574" "n1-623" "n1-624" "n1-683" "n1-684" "n5-605" "n5-606" "n1-798" "n1-799" "n1-800" "n6-41" "n6-43" "n1-843" "n1-859" "n1-876" "n1-892" "n1-903" "n1-922" "n1-923" "n1-924" "n1-941" "n1-942" "n1-943" "n1-944" "n1-945" "n1-946" "n1-947" "n1-967" "n1-968" "n1-985" "n1-986" "n1-987" "n1-988" "n1-989" "n1-990" "n1-991" "n1-1145" "n1-1208" "n1-1235" "n1-1252" "n1-1269" "n1-1286" "n1-1297" "n1-1676" "n1-1726" "n1-1754" "n1-1811" "n2-214" "n2-241" "n2-260" "n1-2171" "n1-2172" "n1-2173" "n1-2174" "n1-2191" "n1-2192" "n1-2193" "n1-2194" "n1-2216" "n1-2217" "n1-2218" "n1-2227" "n1-2228" "n1-2229"))
#(define (concerto-source-note-properties nid music)
   (concerto-special-beam-properties nid music)
   (when (hash-ref op47-source-grace-note-ids nid #f)
     (set! (ly:music-property music 'tweaks)
       (acons (cons 'Stem 'thickness) 1.1375 (ly:music-property music 'tweaks))))
   (when (hash-ref concerto-cue-note-ids nid #f)
     (for-each (lambda (grob)
       (set! (ly:music-property music 'tweaks)
         (acons (cons grob 'font-size) -3.08743903697855 (ly:music-property music 'tweaks))))
       '(NoteHead Accidental AccidentalCautionary Flag Dots))))

#(define concerto-spacing-profiles
  '(
    (0 ((0 . 12.9660000) (1/4 . 17.7550000) (3/8 . 21.2020000) (1/2 . 24.1950000) (5/8 . 27.1890000) (3/4 . 31.5417769) (1 . 36.8467769) (9/8 . 40.1617769) (3/2 . 48.7537075) (13/8 . 52.0977075) (7/4 . 55.4047075) (15/8 . 58.7127075) (2 . 62.0197075) (17/8 . 65.3277075) (9/4 . 70.3394063) (19/8 . 73.9694063) (41/16 . 78.3504063) (21/8 . 80.5964063) (3 . 88.0301947) (13/4 . 94.3291947) (27/8 . 98.2441947) (7/2 . 102.1591947) (29/8 . 106.0731947) (15/4 . 111.7280012) (4 . 117.5770012) (33/8 . 121.2330012)) ((0 . 0.0000000) (3/4 . 30.3417769) (3/2 . 46.7897075) (9/4 . 68.7954063) (3 . 86.4861947) (15/4 . 110.1480012) (9/2 . 128.5244784)) 128.5244784)
    (9/2 ((0 . 11.2580000) (1/8 . 15.1870000) (1/4 . 19.1170000) (3/8 . 23.1860000) (5/8 . 29.4730000) (3/4 . 35.1426865) (1 . 39.8876865) (9/8 . 42.8536865) (3/2 . 52.3046885) (7/4 . 62.2096885) (15/8 . 67.2886885) (9/4 . 81.2062916) (5/2 . 88.2582916) (21/8 . 91.7852916) (45/16 . 97.5152916) (23/8 . 99.7192916) (3 . 104.9851094) (51/16 . 110.8301094) (13/4 . 113.0781094) (27/8 . 116.6751094) (57/16 . 122.5201094) (29/8 . 124.7681094)) ((0 . 0.0000000) (3/4 . 33.5626865) (3/2 . 50.7246885) (9/4 . 79.6262916) (3 . 103.4051094) (15/4 . 128.5244784)) 128.5244784)
    (33/4 ((0 . 11.2580000) (3/16 . 15.4370000) (1/4 . 17.0440000) (3/8 . 20.4110000) (9/16 . 24.5900000) (5/8 . 26.1970000) (3/4 . 30.5085987) (15/16 . 39.2395987) (1 . 41.9935987) (9/8 . 45.9355987) (3/2 . 55.7455854) (27/16 . 61.7665854) (7/4 . 64.1795854) (15/8 . 67.2505854) (123/64 . 69.3905854) (63/32 . 71.5305854) (129/64 . 74.1975854) (33/16 . 76.3375854) (135/64 . 79.0035854) (69/32 . 82.3255854) (285/128 . 86.0315854) (9/4 . 90.0885663) (39/16 . 94.5265663) (5/2 . 96.2335663) (21/8 . 99.3435663) (45/16 . 103.7815663) (23/8 . 105.4885663) (3 . 109.9603083) (51/16 . 114.4033083) (13/4 . 116.1123083) (27/8 . 119.4783083) (57/16 . 123.9213083) (29/8 . 125.6303083)) ((0 . 0.0000000) (3/4 . 28.9285987) (3/2 . 54.1655854) (9/4 . 88.5085663) (3 . 108.3803083) (15/4 . 128.5244784)) 128.5244784)
    (12 ((0 . 11.2580000) (3/16 . 16.1710000) (1/4 . 18.0610000) (3/8 . 21.0840000) (9/16 . 24.7710000) (5/8 . 27.4370000) (3/4 . 32.2008763) (15/16 . 37.5258763) (1 . 40.4128763) (9/8 . 43.1678763) (21/16 . 47.6448763) (11/8 . 49.5908763) (3/2 . 54.0859752) (27/16 . 59.3499752) (7/4 . 61.3749752) (15/8 . 65.3139752) (33/16 . 70.5779752) (17/8 . 72.9049752) (9/4 . 77.8843797) (39/16 . 84.2603797) (5/2 . 86.5873797) (21/8 . 90.0143797) (45/16 . 95.5823797) (23/8 . 98.3353797) (3 . 103.5781897) (51/16 . 111.1071897) (13/4 . 113.8601897) (27/8 . 117.6331897) (57/16 . 122.2341897) (29/8 . 124.5921897)) ((0 . 0.0000000) (3/4 . 30.6208763) (3/2 . 52.5059752) (9/4 . 76.3043797) (3 . 101.9981897) (15/4 . 128.5244784)) 128.5244784)
    (63/4 ((0 . 11.2580000) (3/16 . 17.6850000) (1/4 . 20.0110000) (3/8 . 23.4880000) (9/16 . 27.7270000) (5/8 . 33.1670000) (3/4 . 38.3836709) (15/16 . 42.2866709) (1 . 45.7996709) (9/8 . 50.1186709) (21/16 . 55.2086709) (11/8 . 57.5346709) (3/2 . 62.4072806) (27/16 . 67.6342806) (7/4 . 69.9612806) (15/8 . 73.1772806) (33/16 . 77.8442806) (17/8 . 80.5972806) (9/4 . 86.7402779) (39/16 . 93.1812779) (5/2 . 95.5072779) (21/8 . 98.9982779) (3 . 110.4542006) (27/8 . 115.6042006) (55/16 . 118.2702006) (7/2 . 121.0972006) (57/16 . 123.1152006) (29/8 . 125.1342006)) ((0 . 0.0000000) (3/4 . 36.8036709) (3/2 . 60.8272806) (9/4 . 85.1602779) (3 . 104.7242006) (15/4 . 128.5244784)) 128.5244784)
    (39/2 ((0 . 11.2580000) (3/16 . 15.9490000) (1/4 . 18.2760000) (3/8 . 21.1630000) (9/16 . 26.7590000) (5/8 . 29.0860000) (3/4 . 36.9631548) (9/8 . 41.4801548) (19/16 . 44.6871548) (5/4 . 47.5131548) (21/16 . 49.2841548) (11/8 . 51.2311548) (3/2 . 55.8043409) (7/4 . 61.6433409) (15/8 . 64.5633409) (31/16 . 67.7703409) (2 . 70.5963409) (33/16 . 72.4213409) (17/8 . 74.3683409) (9/4 . 79.0275241) (5/2 . 84.8665241) (21/8 . 87.7865241) (43/16 . 90.9935241) (11/4 . 93.8195241) (45/16 . 95.6445241) (23/8 . 97.5915241) (3 . 102.4507073) (13/4 . 108.7607073) (105/32 . 110.7677073) (53/16 . 112.3347073) (107/32 . 113.9007073) (27/8 . 115.0727073) (55/16 . 118.2787073) (7/2 . 121.1057073) (57/16 . 123.2567073) (29/8 . 125.4067073)) ((0 . 0.0000000) (3/4 . 32.1331548) (3/2 . 54.2243409) (9/4 . 77.4475241) (3 . 100.6707073) (15/4 . 128.5244497)) 128.5244497)
    (93/4 ((0 . 12.1380000) (1/4 . 18.0980000) (9/32 . 20.1060000) (5/16 . 21.6720000) (11/32 . 23.2390000) (3/8 . 24.4110000) (7/16 . 27.6170000) (1/2 . 30.4440000) (9/16 . 32.4680000) (5/8 . 34.4910000) (3/4 . 39.2141557) (7/8 . 42.3871557) (15/16 . 45.0541557) (1 . 47.0371557) (17/16 . 49.0201557) (9/8 . 51.0031557) (19/16 . 53.6701557) (5/4 . 55.6531557) (21/16 . 58.6991557) (11/8 . 60.6831557) (23/16 . 62.6661557) (3/2 . 66.9224279) (25/16 . 69.3194279) (13/8 . 71.7164279) (27/16 . 74.1134279) (7/4 . 77.3204279) (29/16 . 79.7174279) (15/8 . 82.9234279) (31/16 . 85.3204279) (2 . 87.7174279) (33/16 . 90.7644279) (17/8 . 93.1614279) (35/16 . 95.5584279) (9/4 . 99.5152440) (37/16 . 102.7222440) (19/8 . 105.0482440) (39/16 . 107.2082440) (5/2 . 110.2552440) (41/16 . 112.5812440) (21/8 . 114.7412440) (43/16 . 117.4082440) (11/4 . 119.5682440) (45/16 . 121.7282440) (23/8 . 123.8882440) (47/16 . 126.0482440)) ((0 . 0.0000000) (3/4 . 37.4341557) (3/2 . 65.1424279) (9/4 . 98.1152440) (3 . 128.5244640)) 128.5244640)
    (105/4 ((0 . 11.2580000) (3/8 . 17.9770000) (1/2 . 21.4240000) (5/8 . 24.8680000) (3/4 . 30.0518938) (1 . 36.5488938) (9/8 . 39.9968938) (5/4 . 43.2448938) (11/8 . 46.4938938) (3/2 . 51.1027138) (7/4 . 56.3027138) (15/8 . 59.5537138) (9/4 . 68.0185241) (19/8 . 71.3125241) (5/2 . 74.5715241) (21/8 . 77.8295241) (11/4 . 81.0875241) (23/8 . 84.3455241) (3 . 89.3081098) (25/8 . 92.8711098) (53/16 . 97.1711098) (27/8 . 99.3761098) (15/4 . 106.7027779) (4 . 112.9177779) (33/8 . 116.7787779) (17/4 . 120.6407779) (35/8 . 124.5027779)) ((0 . 0.0000000) (3/4 . 28.4718938) (3/2 . 49.9027138) (9/4 . 66.0545241) (3 . 87.7641098) (15/4 . 105.1587779) (9/2 . 128.5244640)) 128.5244640)
    (123/4 ((0 . 11.2580000) (1/8 . 15.2650000) (1/4 . 18.2050000) (3/8 . 21.1450000) (1/2 . 26.8910000) (5/8 . 29.8310000) (3/4 . 34.5109492) (7/8 . 38.3579492) (1 . 40.6899492) (9/8 . 43.0219492) (5/4 . 48.7679492) (11/8 . 51.0989492) (3/2 . 54.7907281) (13/8 . 58.4187281) (7/4 . 60.9097281) (15/8 . 63.5767281) (2 . 70.4227281) (17/8 . 72.9147281) (9/4 . 76.8385120) (5/2 . 81.4505120) (21/8 . 85.6785120) (11/4 . 89.1915120) (23/8 . 92.0745120) (3 . 96.6968553) (13/4 . 103.8928553) (27/8 . 106.6658553) (29/8 . 111.1028553) (15/4 . 115.6153394) (33/8 . 121.7403394)) ((0 . 0.0000000) (3/4 . 32.9309492) (3/2 . 53.5907281) (9/4 . 75.5665120) (3 . 95.1168553) (15/4 . 114.0353394) (9/2 . 128.5244784)) 128.5244784)
    (141/4 ((0 . 11.2580000) (1/8 . 14.1920000) (1/4 . 17.1260000) (3/8 . 20.0600000) (5/8 . 24.7550000) (3/4 . 29.7721054) (1 . 33.6451054) (9/8 . 36.4221054) (3/2 . 46.1907025) (9/4 . 53.9724593) (3 . 61.7542197) (13/4 . 66.7402197) (27/8 . 69.2332197) (29/8 . 74.2192197) (15/4 . 78.0718659) (4 . 82.0858659) (33/8 . 84.0928659) (35/8 . 88.1068659) (9/2 . 92.5583194) (19/4 . 97.5443194) (39/8 . 100.0373194) (41/8 . 105.0233194) (21/4 . 108.8759728) (11/2 . 115.2369728) (45/8 . 118.8229728) (23/4 . 122.0029728) (47/8 . 125.1839728)) ((0 . 0.0000000) (3/4 . 28.1921054) (3/2 . 44.6107025) (9/4 . 52.3924593) (3 . 60.1742197) (15/4 . 76.8718659) (9/2 . 90.9783194) (21/4 . 107.6759728) (6 . 128.5244784)) 128.5244784)
    (165/4 ((0 . 10.8780000) (1/4 . 17.7460000) (3/8 . 21.1810000) (5/8 . 28.0490000) (3/4 . 33.2237109) (1 . 41.3977109) (9/8 . 46.7807109) (5/4 . 50.8677109) (11/8 . 54.9557109) (3/2 . 60.7826321) (7/4 . 67.2196321) (15/8 . 70.4376321) (17/8 . 76.8746321) (9/4 . 81.4526208) (5/2 . 89.3996208) (21/8 . 93.3726208) (11/4 . 97.3466208) (23/8 . 101.3196208) (3 . 106.6534750) (13/4 . 113.8904750) (27/8 . 117.5084750) (29/8 . 124.7454750)) ((0 . 0.0000000) (3/4 . 31.6437109) (3/2 . 59.2026321) (9/4 . 80.2526208) (3 . 105.4534750) (15/4 . 128.5244497)) 128.5244497)
    (45 ((0 . 11.2580000) (1/4 . 19.1190000) (3/8 . 24.5010000) (1/2 . 28.4320000) (5/8 . 32.3620000) (3/4 . 37.8526228) (1 . 45.4116228) (9/8 . 50.7946228) (5/4 . 54.6806228) (11/8 . 58.4596228) (3/2 . 63.7994787) (7/4 . 70.5334787) (15/8 . 73.9004787) (17/8 . 80.6344787) (9/4 . 85.3614872) (5/2 . 91.9714872) (21/8 . 95.2764872) (23/8 . 101.8874872) (3 . 106.7502699) (13/4 . 113.9552699) (27/8 . 117.5572699) (29/8 . 124.7622699)) ((0 . 0.0000000) (3/4 . 36.4526228) (3/2 . 62.3994787) (9/4 . 84.1614872) (3 . 105.5502699) (15/4 . 128.5244784)) 128.5244784)
    (195/4 ((0 . 12.7220000) (1/8 . 16.0120000) (1/4 . 19.3010000) (3/8 . 22.5910000) (1/2 . 25.8800000) (5/8 . 29.1700000) (3/4 . 33.8193583) (1 . 41.4343583) (9/8 . 45.2413583) (11/8 . 52.8563583) (3/2 . 58.4034479) (27/16 . 64.1054479) (7/4 . 66.2984479) (15/8 . 69.8074479) (33/16 . 75.5094479) (17/8 . 77.7024479) (9/4 . 82.9515986) (5/2 . 90.6055986) (21/8 . 94.4325986) (23/8 . 102.0875986) (3 . 107.2742761) (13/4 . 114.2762761) (27/8 . 117.8622761) (7/2 . 121.3622761) (29/8 . 124.8632761)) ((0 . 0.0000000) (3/4 . 32.6193583) (3/2 . 56.8234479) (9/4 . 81.3715986) (3 . 106.0742761) (15/4 . 128.5244784)) 128.5244784)
    (105/2 ((0 . 10.8780000) (1/8 . 14.5760000) (1/4 . 18.2750000) (3/8 . 21.9730000) (1/2 . 25.6720000) (5/8 . 29.3700000) (3/4 . 34.8089823) (7/8 . 39.1699823) (1 . 43.5299823) (9/8 . 47.8909823) (11/8 . 54.8679823) (3/2 . 61.1689963) (7/4 . 66.9909963) (15/8 . 71.6809963) (17/8 . 78.6899963) (9/4 . 83.6476374) (5/2 . 91.0606374) (21/8 . 94.7676374) (11/4 . 98.4746374) (23/8 . 102.1806374) (3 . 107.4476484) (13/4 . 113.2336484) (27/8 . 117.9056484) (29/8 . 124.8786484)) ((0 . 0.0000000) (3/4 . 33.2289823) (3/2 . 59.3889963) (9/4 . 82.3536374) (3 . 106.0476484) (15/4 . 128.5244784)) 128.5244784)
    (225/4 ((0 . 10.8780000) (1/4 . 18.8870000) (3/8 . 22.8910000) (1/2 . 26.8960000) (5/8 . 30.9000000) (3/4 . 36.4647876) (1 . 44.0207876) (9/8 . 47.7977876) (11/8 . 54.1677876) (3/2 . 60.4916795) (7/4 . 68.5936795) (15/8 . 72.0516795) (17/8 . 78.9676795) (9/4 . 84.1657005) (5/2 . 90.2167005) (21/8 . 95.0217005) (23/8 . 102.2587005) (3 . 107.6170117) (13/4 . 114.5330117) (27/8 . 117.9910117) (29/8 . 124.9070117)) ((0 . 0.0000000) (3/4 . 35.0647876) (3/2 . 59.2916795) (9/4 . 82.5857005) (3 . 106.0370117) (15/4 . 128.5244784)) 128.5244784)
    (60 ((0 . 11.2580000) (1/4 . 17.3620000) (3/8 . 20.4140000) (5/8 . 26.5170000) (3/4 . 33.1532897) (7/8 . 37.1442897) (1 . 41.1342897) (9/8 . 45.1252897) (5/4 . 49.1152897) (11/8 . 53.1062897) (3/2 . 58.8364191) (7/4 . 65.3944191) (15/8 . 68.6734191) (17/8 . 75.2304191) (9/4 . 80.2495638) (39/16 . 86.5015638) (5/2 . 88.9065638) (21/8 . 92.7535638) (45/16 . 99.0055638) (23/8 . 102.5185638) (3 . 108.1063063) (13/4 . 113.6723063) (27/8 . 118.2353063) (29/8 . 124.9883063)) ((0 . 0.0000000) (3/4 . 29.7292897) (3/2 . 57.2564191) (9/4 . 78.6695638) (3 . 106.5263063) (15/4 . 128.5244497)) 128.5244497)
    (255/4 ((0 . 11.2580000) (1/4 . 18.6010000) (3/8 . 22.7720000) (1/2 . 26.4430000) (5/8 . 30.1140000) (3/4 . 35.7258600) (15/16 . 42.1388600) (1 . 44.4648600) (9/8 . 47.9278600) (5/4 . 51.3908600) (11/8 . 53.6668600) (3/2 . 60.0565842) (7/4 . 66.7595842) (15/8 . 70.6025842) (2 . 73.9545842) (17/8 . 77.3055842) (9/4 . 82.8274908) (19/8 . 85.9644908) (5/2 . 89.5324908) (21/8 . 93.0994908) (11/4 . 96.6664908) (23/8 . 100.2334908) (3 . 105.5411980) (13/4 . 113.1331980) (27/8 . 116.9761980) (7/2 . 120.7721980) (29/8 . 124.5681980)) ((0 . 0.0000000) (3/4 . 33.9458600) (3/2 . 58.4765842) (9/4 . 80.8174908) (3 . 103.9611980) (15/4 . 128.5244784)) 128.5244784)
    (135/2 ((0 . 11.2580000) (1/4 . 18.8200000) (3/8 . 22.9210000) (1/2 . 27.0230000) (5/8 . 31.1240000) (3/4 . 36.9651528) (1 . 44.5481528) (9/8 . 48.3921528) (5/4 . 52.4611528) (11/8 . 56.2531528) (3/2 . 61.6047590) (7/4 . 68.5167590) (15/8 . 72.3607590) (2 . 75.8167590) (17/8 . 79.2727590) (9/4 . 84.2893642) (5/2 . 92.4083642) (21/8 . 96.4683642) (11/4 . 100.5383642) (23/8 . 104.5983642) (3 . 110.2176919) (13/4 . 114.6146919) (27/8 . 119.2906919) (29/8 . 124.8746919)) ((0 . 0.0000000) (3/4 . 35.3851528) (3/2 . 60.2047590) (9/4 . 82.8893642) (3 . 108.8176919) (15/4 . 128.5244784)) 128.5244784)
    (285/4 ((0 . 12.1380000) (1/4 . 19.6870000) (3/8 . 23.6630000) (5/8 . 30.0250000) (3/4 . 36.1486827) (1 . 42.2686827) (9/8 . 46.0936827) (11/8 . 52.2136827) (3/2 . 57.9791679) (7/4 . 64.5971679) (15/8 . 68.7331679) (17/8 . 74.1641679) (9/4 . 81.2267684) (21/8 . 92.6437684) (23/8 . 98.7327684) (3 . 106.1590155) (25/8 . 109.8600155) (13/4 . 113.5610155) (27/8 . 117.2620155) (7/2 . 120.9630155) (29/8 . 124.6640155)) ((0 . 0.0000000) (3/4 . 34.6616827) (3/2 . 56.1991679) (9/4 . 79.6467684) (3 . 102.6990155) (15/4 . 128.5244784)) 128.5244784)
    (75 ((0 . 12.7580000) (3/8 . 24.7400000) (5/8 . 31.1300000) (3/4 . 36.8644591) (7/8 . 41.4484591) (1 . 46.0314591) (9/8 . 50.6154591) (5/4 . 55.1994591) (11/8 . 59.7834591) (3/2 . 65.9269544) (7/4 . 72.7659544) (15/8 . 76.1849544) (17/8 . 83.0239544) (9/4 . 87.8031987) (5/2 . 93.6701987) (21/8 . 96.6031987) (23/8 . 102.4701987) (3 . 107.8482350) (13/4 . 114.6872350) (27/8 . 118.1062350) (29/8 . 124.9452350)) ((0 . 0.0000000) (3/4 . 35.2844591) (3/2 . 64.5269544) (9/4 . 86.6031987) (3 . 106.2682350) (15/4 . 128.5244784)) 128.5244784)
    (315/4 ((0 . 10.8780000) (1/4 . 18.6830000) (3/8 . 22.5850000) (1/2 . 26.4880000) (5/8 . 30.3900000) (3/4 . 35.6526869) (1 . 42.3796869) (9/8 . 45.7426869) (11/8 . 52.4696869) (3/2 . 57.5726076) (7/4 . 65.5766076) (15/8 . 70.9596076) (2 . 74.9616076) (17/8 . 78.9636076) (9/4 . 84.7055571) (5/2 . 91.0005571) (21/8 . 94.1475571) (23/8 . 100.4425571) (3 . 104.9495742) (13/4 . 112.7545742) (27/8 . 116.6565742) (7/2 . 120.5595742) (29/8 . 124.4615742)) ((0 . 0.0000000) (3/4 . 34.4526869) (3/2 . 55.9926076) (9/4 . 83.1255571) (3 . 103.7495742) (15/4 . 128.5244497)) 128.5244497)
    (165/2 ((0 . 10.8780000) (1/4 . 17.6680000) (3/8 . 21.0630000) (5/8 . 27.8530000) (3/4 . 32.9884969) (1 . 40.8654969) (9/8 . 46.2474969) (5/4 . 50.1864969) (11/8 . 54.1244969) (3/2 . 59.8025228) (7/4 . 67.5905228) (15/8 . 72.9735228) (2 . 76.8675228) (17/8 . 80.7615228) (9/4 . 86.3955315) (5/2 . 93.1635315) (21/8 . 96.5475315) (23/8 . 103.3155315) (3 . 108.0600019) (13/4 . 114.8280019) (27/8 . 118.2120019) (29/8 . 124.9800019)) ((0 . 0.0000000) (3/4 . 31.4084969) (3/2 . 58.2225228) (9/4 . 84.8155315) (3 . 106.8600019) (15/4 . 128.5244784)) 128.5244784)
    (345/4 ((0 . 15.0270000) (1/4 . 22.0850000) (3/8 . 25.6140000) (7/16 . 27.9410000) (1/2 . 30.2670000) (9/16 . 32.4730000) (5/8 . 34.6780000) (11/16 . 37.7460000) (3/4 . 41.6221783) (13/16 . 44.2891783) (7/8 . 46.2501783) (15/16 . 48.2111783) (1 . 50.1721783) (17/16 . 52.1331783) (9/8 . 54.0941783) (11/8 . 58.4091783) (3/2 . 71.1772538) (7/4 . 78.3412538) (15/8 . 83.2972538) (31/16 . 85.6232538) (2 . 87.9502538) (33/16 . 90.1882538) (17/8 . 92.4272538) (35/16 . 95.4942538) (9/4 . 99.7511744) (37/16 . 102.9581744) (19/8 . 105.2841744) (39/16 . 107.6111744) (5/2 . 109.9371744) (41/16 . 112.1511744) (21/8 . 114.3651744) (43/16 . 116.5791744) (11/4 . 118.7931744) (45/16 . 121.0071744) (23/8 . 123.2211744) (47/16 . 126.0481744)) ((0 . 0.0000000) (3/4 . 40.2221783) (3/2 . 61.8462538) (9/4 . 97.9711744) (3 . 128.5244784)) 128.5244784)
    (357/4 ((0 . 13.1460000) (1/4 . 18.9550000) (3/8 . 23.5300000) (7/16 . 25.3460000) (1/2 . 27.1610000) (9/16 . 29.8270000) (5/8 . 31.6430000) (11/16 . 34.5290000) (3/4 . 38.4058406) (13/16 . 41.0728406) (7/8 . 43.1818406) (15/16 . 45.2908406) (1 . 47.3998406) (17/16 . 49.5088406) (9/8 . 51.8348406) (11/8 . 56.4748406) (3/2 . 69.3401135) (7/4 . 75.8951135) (15/8 . 80.8511135) (31/16 . 83.1771135) (2 . 85.5041135) (33/16 . 88.7101135) (17/8 . 91.0371135) (35/16 . 94.4841135) (9/4 . 98.7407351) (37/16 . 101.9477351) (19/8 . 104.2737351) (39/16 . 106.2207351) (5/2 . 108.8867351) (41/16 . 111.3367351) (21/8 . 115.4397351) (43/16 . 117.2337351) (11/4 . 119.0277351) (45/16 . 121.9147351) (23/8 . 123.7087351) (47/16 . 126.0627351)) ((0 . 0.0000000) (3/4 . 37.0058406) (3/2 . 60.0091135) (9/4 . 96.9607351) (3 . 128.5244784)) 128.5244784)
    (369/4 ((0 . 10.8780000) (1/16 . 12.9970000) (1/8 . 15.1170000) (3/16 . 17.2360000) (1/4 . 19.3560000) (5/16 . 21.4750000) (3/8 . 23.5940000) (7/16 . 25.7140000) (1/2 . 27.8330000) (9/16 . 30.5000000) (5/8 . 32.6190000) (11/16 . 34.7390000) (3/4 . 38.4152737) (13/16 . 40.5342737) (7/8 . 42.6542737) (15/16 . 44.7732737) (1 . 46.8932737) (17/16 . 49.0122737) (9/8 . 51.1322737) (19/16 . 53.2512737) (5/4 . 55.3702737) (21/16 . 58.0372737) (11/8 . 60.1562737) (23/16 . 62.2762737) (3/2 . 66.3327302) (25/16 . 68.5187302) (13/8 . 70.7057302) (27/16 . 72.8917302) (7/4 . 75.0787302) (29/16 . 77.2647302) (15/8 . 79.4517302) (31/16 . 81.6377302) (2 . 83.8247302) (33/16 . 86.0107302) (17/8 . 88.1977302) (35/16 . 91.0837302) (9/4 . 96.0913611) (37/16 . 98.7453611) (19/8 . 101.3993611) (39/16 . 104.0533611) (5/2 . 106.7073611) (41/16 . 109.7743611) (21/8 . 112.4283611) (43/16 . 115.0823611) (11/4 . 117.7363611) (45/16 . 120.3903611) (23/8 . 123.0443611) (47/16 . 125.7103611)) ((0 . 0.0000000) (3/4 . 37.2152737) (3/2 . 64.7527302) (9/4 . 93.5603611) (3 . 128.5244784)) 128.5244784)
    (381/4 ((0 . 10.8780000) (1/16 . 14.1410000) (1/8 . 17.4040000) (3/16 . 20.6680000) (1/4 . 23.9310000) (5/16 . 27.1940000) (3/8 . 30.4570000) (7/16 . 33.7210000) (1/2 . 36.9840000) (9/16 . 40.2470000) (5/8 . 43.5100000) (11/16 . 46.7740000) (3/4 . 51.3969174) (13/16 . 54.5179174) (7/8 . 57.6399174) (15/16 . 60.7609174) (1 . 63.8829174) (17/16 . 67.0039174) (9/8 . 70.1259174) (19/16 . 73.2469174) (5/4 . 76.3679174) (21/16 . 79.4899174) (11/8 . 82.6109174) (23/16 . 85.7329174) (3/2 . 90.5940280) (25/16 . 93.6580280) (13/8 . 96.7220280) (27/16 . 99.7870280) (7/4 . 102.8510280) (29/16 . 105.9150280) (15/8 . 109.9790280) (31/16 . 113.0430280) (2 . 116.1080280) (33/16 . 119.1720280) (17/8 . 122.2360280) (35/16 . 125.3000280)) ((0 . 0.0000000) (3/4 . 50.1969174) (3/2 . 89.0140280) (9/4 . 128.5244497)) 128.5244497)
    (195/2 ((0 . 11.1010000) (1/16 . 13.6040000) (1/8 . 16.1070000) (3/16 . 19.3140000) (1/4 . 21.8170000) (5/16 . 24.3210000) (3/8 . 27.5270000) (7/16 . 30.0310000) (1/2 . 32.5340000) (9/16 . 35.0370000) (5/8 . 37.5410000) (11/16 . 40.7470000) (3/4 . 45.6949927) (13/16 . 48.9019927) (7/8 . 52.3489927) (15/16 . 55.0199927) (1 . 58.6419927) (17/16 . 60.9679927) (9/8 . 63.2949927) (19/16 . 65.5509927) (5/4 . 67.8069927) (21/16 . 70.4729927) (11/8 . 73.3599927) (23/16 . 75.6159927) (3/2 . 80.4793126) (25/16 . 82.8053126) (13/8 . 85.1323126) (27/16 . 87.0783126) (7/4 . 89.0133126) (29/16 . 91.6793126) (15/8 . 94.5663126) (31/16 . 96.5003126) (2 . 98.4343126) (33/16 . 100.3693126) (17/8 . 102.3033126) (35/16 . 104.6573126) (9/4 . 108.8391019) (19/8 . 111.6171019) (5/2 . 114.7011019) (41/16 . 116.3831019) (21/8 . 117.6691019) (11/4 . 121.6771019) (23/8 . 124.3671019) (47/16 . 126.0481019)) ((0 . 0.0000000) (3/4 . 44.1149927) (3/2 . 78.0923126) (9/4 . 107.2591019) (3 . 128.5244784)) 128.5244784)
    (201/2 ((0 . 10.8780000) (1/8 . 14.6470000) (1/4 . 18.4160000) (5/16 . 20.7710000) (3/8 . 23.4380000) (1/2 . 27.2070000) (9/16 . 29.5630000) (5/8 . 31.9180000) (11/16 . 34.2740000) (3/4 . 40.9986178) (13/16 . 43.3596178) (7/8 . 45.7216178) (15/16 . 48.0826178) (1 . 50.4436178) (17/16 . 52.8046178) (9/8 . 56.3986178) (19/16 . 57.5266178) (5/4 . 59.8886178) (21/16 . 62.2496178) (11/8 . 64.6106178) (23/16 . 66.9716178) (3/2 . 70.6927870) (25/16 . 73.0177870) (13/8 . 75.3417870) (27/16 . 77.6667870) (7/4 . 79.9917870) (29/16 . 82.3167870) (15/8 . 85.8747870) (31/16 . 86.9657870) (2 . 89.2907870) (33/16 . 91.6157870) (17/8 . 93.9397870) (35/16 . 96.2647870) (9/4 . 99.9496943) (37/16 . 102.2906943) (19/8 . 104.6306943) (39/16 . 106.9716943) (5/2 . 109.3126943) (41/16 . 111.6536943) (21/8 . 114.3196943) (43/16 . 116.6606943) (11/4 . 119.0016943) (45/16 . 121.3426943) (23/8 . 123.6826943) (47/16 . 126.0236943)) ((0 . 0.0000000) (3/4 . 36.7896178) (3/2 . 69.4927870) (9/4 . 98.7496943) (3 . 128.5244640)) 128.5244640)
    (207/2 ((0 . 10.8780000) (1/16 . 13.1860000) (1/8 . 15.4940000) (3/16 . 17.8030000) (1/4 . 20.1110000) (5/16 . 22.4190000) (3/8 . 24.7280000) (7/16 . 27.0360000) (1/2 . 29.3440000) (9/16 . 31.6520000) (5/8 . 33.9610000) (11/16 . 36.2690000) (3/4 . 39.9454775) (13/16 . 42.3634775) (7/8 . 44.7814775) (15/16 . 47.2004775) (1 . 49.6184775) (17/16 . 52.0364775) (9/8 . 54.4544775) (19/16 . 56.8734775) (5/4 . 59.2914775) (21/16 . 61.7094775) (11/8 . 64.1274775) (23/16 . 66.5454775) (3/2 . 70.3241474) (25/16 . 72.5931474) (13/8 . 74.8611474) (27/16 . 77.1301474) (7/4 . 79.3981474) (29/16 . 81.6671474) (15/8 . 83.9351474) (31/16 . 86.2041474) (2 . 88.4721474) (33/16 . 90.7411474) (17/8 . 93.0101474) (35/16 . 95.2781474) (9/4 . 98.9548081) (37/16 . 101.3858081) (19/8 . 103.8168081) (39/16 . 106.2488081) (5/2 . 108.6798081) (41/16 . 111.1108081) (21/8 . 113.7778081) (43/16 . 116.2088081) (11/4 . 118.6398081) (45/16 . 121.0708081) (23/8 . 123.5018081) (47/16 . 125.9328081)) ((0 . 0.0000000) (3/4 . 38.7454775) (3/2 . 69.1241474) (9/4 . 97.7548081) (3 . 128.5244784)) 128.5244784)
    (213/2 ((0 . 12.7220000) (1/16 . 15.2300000) (1/8 . 17.7380000) (3/16 . 20.2450000) (1/4 . 22.7530000) (5/16 . 25.2610000) (3/8 . 27.7690000) (7/16 . 30.2760000) (1/2 . 32.7840000) (9/16 . 35.2920000) (5/8 . 37.8000000) (11/16 . 40.3270000) (3/4 . 44.5749455) (1 . 50.8229455) (9/8 . 53.9469455) (11/8 . 60.1949455) (3/2 . 64.6793511) (7/4 . 70.6093511) (15/8 . 73.5733511) (17/8 . 79.5033511) (9/4 . 84.2081900) (5/2 . 91.0831900) (21/8 . 94.5201900) (23/8 . 101.3951900) (3 . 106.1928534) (13/4 . 113.2428534) (27/8 . 117.7898534) (7/2 . 121.3148534) (29/8 . 124.8398534)) ((0 . 0.0000000) (3/4 . 42.9949455) (3/2 . 63.4793511) (9/4 . 82.6281900) (3 . 104.9928534) (15/4 . 128.5244784)) 128.5244784)
    (441/4 ((0 . 11.2580000) (1/4 . 18.1000000) (3/8 . 21.5210000) (5/8 . 28.3630000) (3/4 . 33.5243170) (1 . 41.7913170) (9/8 . 46.3383170) (5/4 . 50.4723170) (11/8 . 54.6053170) (3/2 . 60.4794494) (7/4 . 67.4134494) (15/8 . 70.8814494) (17/8 . 77.8154494) (9/4 . 82.6426714) (5/2 . 89.7636714) (21/8 . 94.3106714) (11/4 . 97.8716714) (23/8 . 101.4326714) (3 . 106.7328618) (13/4 . 113.9438618) (27/8 . 117.5488618) (29/8 . 124.7588618)) ((0 . 0.0000000) (3/4 . 31.9443170) (3/2 . 58.8994494) (9/4 . 81.4426714) (3 . 105.1528618) (15/4 . 128.5244497)) 128.5244497)
    (114 ((0 . 11.2580000) (1/4 . 17.8670000) (3/8 . 22.4140000) (1/2 . 26.1030000) (5/8 . 29.4080000) (3/4 . 34.4522355) (1 . 41.0612355) (9/8 . 45.6082355) (5/4 . 49.2972355) (11/8 . 52.6022355) (3/2 . 57.6466537) (7/4 . 62.8416537) (15/8 . 65.4396537) (17/8 . 70.6346537) (9/4 . 75.0122692) (5/2 . 79.8202692) (21/8 . 82.2242692) (23/8 . 87.0332692) (3 . 96.7933824) (25/8 . 101.1243824) (51/16 . 103.8113824) (13/4 . 106.4993824) (53/16 . 109.1863824) (27/8 . 111.8743824) (55/16 . 114.5613824) (7/2 . 117.2493824) (57/16 . 119.9363824) (29/8 . 122.9893824) (59/16 . 125.6773824)) ((0 . 0.0000000) (3/4 . 32.8722355) (3/2 . 56.0666537) (9/4 . 73.3922692) (3 . 90.9303824) (15/4 . 128.5244784)) 128.5244784)
    (471/4 ((0 . 11.3410000) (1/16 . 14.5270000) (1/8 . 17.7120000) (3/16 . 20.8980000) (1/4 . 24.0840000) (5/16 . 27.2690000) (3/8 . 30.4550000) (7/16 . 33.6400000) (1/2 . 36.8260000) (9/16 . 40.0120000) (5/8 . 43.1970000) (11/16 . 46.3830000) (3/4 . 51.3084602) (7/8 . 56.9934602) (15/16 . 60.5464602) (1 . 64.0994602) (17/16 . 67.6524602) (9/8 . 71.2054602) (19/16 . 74.7584602) (5/4 . 78.3114602) (21/16 . 81.8644602) (11/8 . 85.4174602) (23/16 . 88.9704602) (3/2 . 94.4061608) (25/16 . 97.2921608) (13/8 . 100.6621608) (27/16 . 103.5471608) (7/4 . 106.4331608) (29/16 . 109.3191608) (15/8 . 112.2041608) (2 . 116.8211608) (33/16 . 119.7071608) (17/8 . 122.5931608) (35/16 . 125.4791608)) ((0 . 0.0000000) (3/4 . 49.7284602) (3/2 . 92.6831608) (9/4 . 128.5244784)) 128.5244784)
    (120 ((0 . 11.3410000) (1/8 . 14.5960000) (3/16 . 16.6310000) (1/4 . 18.6650000) (5/16 . 20.6990000) (3/8 . 22.7340000) (7/16 . 24.7680000) (1/2 . 27.8210000) (9/16 . 29.8560000) (5/8 . 31.8900000) (11/16 . 33.9240000) (3/4 . 38.1238818) (13/16 . 40.2648818) (7/8 . 42.4048818) (15/16 . 44.5458818) (1 . 46.6858818) (17/16 . 48.8268818) (9/8 . 50.9668818) (19/16 . 53.1078818) (5/4 . 56.1598818) (21/16 . 58.3008818) (11/8 . 60.4408818) (23/16 . 62.7678818) (3/2 . 66.9673884) (25/16 . 69.6913884) (13/8 . 73.3243884) (27/16 . 76.0483884) (7/4 . 78.7733884) (29/16 . 81.4973884) (15/8 . 84.2213884) (31/16 . 86.9453884) (2 . 89.6693884) (33/16 . 92.3943884) (17/8 . 95.9243884) (35/16 . 98.6483884) (9/4 . 103.2560372) (37/16 . 105.3380372) (19/8 . 107.4200372) (39/16 . 109.5020372) (5/2 . 111.5840372) (41/16 . 114.0270372) (21/8 . 116.4710372) (11/4 . 119.8020372) (45/16 . 121.8840372) (23/8 . 123.9660372) (47/16 . 126.0480372)) ((0 . 0.0000000) (3/4 . 36.4008818) (3/2 . 65.2443884) (9/4 . 101.5330372) (3 . 128.5244784)) 128.5244784)
    (123 ((0 . 10.9610000) (1/16 . 13.2950000) (1/8 . 15.6300000) (3/16 . 17.9640000) (1/4 . 20.2980000) (5/16 . 22.6320000) (3/8 . 24.9660000) (7/16 . 27.3000000) (1/2 . 29.6350000) (9/16 . 31.9690000) (5/8 . 34.3030000) (11/16 . 36.6370000) (3/4 . 40.7112780) (13/16 . 43.0452780) (7/8 . 45.3792780) (15/16 . 47.7142780) (1 . 50.0482780) (17/16 . 52.3822780) (9/8 . 54.7162780) (19/16 . 57.0502780) (5/4 . 59.3842780) (21/16 . 61.7192780) (11/8 . 64.0532780) (23/16 . 66.3872780) (3/2 . 70.6043040) (25/16 . 72.9383040) (13/8 . 75.2723040) (27/16 . 77.6073040) (7/4 . 79.9413040) (29/16 . 82.2753040) (15/8 . 84.6093040) (31/16 . 86.9433040) (2 . 89.2773040) (33/16 . 91.6123040) (17/8 . 93.9463040) (35/16 . 96.2803040) (9/4 . 100.3544559) (37/16 . 102.6884559) (19/8 . 105.0224559) (39/16 . 107.3574559) (5/2 . 109.6914559) (41/16 . 112.0254559) (21/8 . 114.3594559) (43/16 . 116.6934559) (11/4 . 119.0274559) (45/16 . 121.3624559) (23/8 . 123.6964559) (47/16 . 126.0304559)) ((0 . 0.0000000) (3/4 . 39.1312780) (3/2 . 68.8813040) (9/4 . 98.7744559) (3 . 128.5244784)) 128.5244784)
    (126 ((0 . 11.3410000) (1/16 . 13.6940000) (1/8 . 16.0470000) (3/16 . 18.4000000) (1/4 . 20.7530000) (5/16 . 23.1060000) (3/8 . 25.4590000) (7/16 . 27.8120000) (1/2 . 30.1650000) (9/16 . 32.5180000) (5/8 . 34.8710000) (11/16 . 37.2240000) (3/4 . 40.9370461) (13/16 . 43.2900461) (7/8 . 45.6430461) (15/16 . 47.9960461) (1 . 50.3490461) (17/16 . 52.7020461) (9/8 . 55.0550461) (19/16 . 57.4080461) (5/4 . 59.7610461) (21/16 . 62.1140461) (11/8 . 64.4670461) (23/16 . 66.8200461) (3/2 . 70.5328473) (25/16 . 72.8858473) (13/8 . 75.2388473) (27/16 . 77.5918473) (7/4 . 79.9448473) (29/16 . 82.2978473) (15/8 . 84.6508473) (31/16 . 87.0038473) (2 . 89.3568473) (33/16 . 91.7098473) (17/8 . 94.0628473) (35/16 . 96.4158473) (9/4 . 100.1286449) (37/16 . 102.4816449) (19/8 . 104.8346449) (39/16 . 107.1876449) (5/2 . 109.5406449) (41/16 . 111.8936449) (21/8 . 114.2466449) (43/16 . 116.5996449) (11/4 . 118.9526449) (45/16 . 121.3056449) (23/8 . 123.6586449) (47/16 . 126.0116449)) ((0 . 0.0000000) (3/4 . 39.7370461) (3/2 . 69.3328473) (9/4 . 98.9286449) (3 . 128.5244497)) 128.5244497)
    (129 ((0 . 11.3410000) (1/16 . 13.5250000) (1/8 . 15.7080000) (3/16 . 17.8920000) (1/4 . 20.0760000) (5/16 . 22.2590000) (3/8 . 24.4430000) (7/16 . 26.6260000) (1/2 . 28.8100000) (9/16 . 31.1010000) (5/8 . 34.6650000) (11/16 . 37.5930000) (3/4 . 42.0161079) (13/16 . 44.1841079) (7/8 . 46.3511079) (15/16 . 48.6421079) (1 . 52.1901079) (17/16 . 55.1181079) (9/8 . 58.2851079) (19/16 . 60.4531079) (5/4 . 62.6201079) (21/16 . 64.7881079) (11/8 . 66.9551079) (23/16 . 69.1231079) (3/2 . 73.1794629) (25/16 . 75.4374629) (13/8 . 77.6964629) (27/16 . 79.9544629) (7/4 . 82.2134629) (29/16 . 84.4714629) (15/8 . 86.7304629) (31/16 . 88.9884629) (2 . 91.2474629) (33/16 . 93.5054629) (17/8 . 95.7634629) (35/16 . 98.0224629) (9/4 . 102.0789631) (37/16 . 104.2579631) (19/8 . 106.4369631) (39/16 . 108.6159631) (5/2 . 110.7949631) (41/16 . 112.9739631) (21/8 . 115.1529631) (43/16 . 117.3319631) (11/4 . 119.5109631) (45/16 . 121.6899631) (23/8 . 123.8689631) (47/16 . 126.0479631)) ((0 . 0.0000000) (3/4 . 40.4361079) (3/2 . 71.5994629) (9/4 . 100.4989631) (3 . 128.5244640)) 128.5244640)
    (132 ((0 . 11.3410000) (1/16 . 14.2260000) (1/8 . 17.1110000) (3/16 . 19.9960000) (1/4 . 22.8810000) (5/16 . 25.7660000) (3/8 . 28.7560000) (7/16 . 31.6410000) (1/2 . 34.5260000) (9/16 . 37.4110000) (5/8 . 40.7810000) (11/16 . 43.6660000) (3/4 . 48.2905277) (13/16 . 51.0145277) (7/8 . 53.7385277) (15/16 . 56.4625277) (1 . 61.4945277) (17/16 . 64.4225277) (9/8 . 68.1465277) (19/16 . 70.8705277) (5/4 . 73.9165277) (21/16 . 76.6405277) (11/8 . 81.6735277) (23/16 . 84.6015277) (3/2 . 89.5653208) (25/16 . 92.3823208) (13/8 . 96.1993208) (27/16 . 99.0163208) (7/4 . 103.4203208) (29/16 . 106.4103208) (15/8 . 109.2273208) (31/16 . 112.0443208) (2 . 115.8613208) (33/16 . 118.6783208) (17/8 . 122.7303208) (35/16 . 125.5473208)) ((0 . 0.0000000) (3/4 . 46.7105277) (3/2 . 87.9853208) (9/4 . 128.5244784)) 128.5244784)
    (537/4 ((0 . 12.6640000) (1/16 . 15.4520000) (1/8 . 18.2390000) (3/16 . 21.0260000) (1/4 . 23.8130000) (5/16 . 26.6010000) (3/8 . 29.3880000) (7/16 . 32.1750000) (1/2 . 36.3680000) (9/16 . 39.1550000) (5/8 . 43.0250000) (11/16 . 46.0150000) (3/4 . 50.5418116) (13/16 . 53.1438116) (7/8 . 56.5138116) (15/16 . 59.1158116) (1 . 62.1628116) (17/16 . 64.7648116) (9/8 . 67.3668116) (19/16 . 69.9688116) (5/4 . 72.5708116) (21/16 . 75.1728116) (11/8 . 77.7758116) (23/16 . 80.3778116) (3/2 . 84.7197724) (25/16 . 88.0737724) (13/8 . 92.7097724) (27/16 . 96.0637724) (7/4 . 100.6367724) (29/16 . 103.9907724) (15/8 . 107.3447724) (31/16 . 110.6987724) (2 . 114.0527724) (33/16 . 117.4067724) (17/8 . 121.6567724) (35/16 . 125.0107724)) ((0 . 0.0000000) (3/4 . 48.9618116) (3/2 . 83.1397724) (9/4 . 128.5244784)) 128.5244784)
    (273/2 ((0 . 12.2210000) (1/4 . 18.6960000) (3/8 . 21.9330000) (7/16 . 24.2600000) (1/2 . 26.2830000) (9/16 . 28.3060000) (5/8 . 30.3300000) (11/16 . 32.3530000) (3/4 . 36.9326778) (13/16 . 39.3186778) (7/8 . 41.7046778) (15/16 . 44.0906778) (1 . 46.4766778) (17/16 . 48.8626778) (9/8 . 51.2486778) (19/16 . 53.6346778) (5/4 . 56.0206778) (21/16 . 58.4066778) (11/8 . 60.7926778) (23/16 . 63.1786778) (3/2 . 67.8276347) (25/16 . 70.2136347) (13/8 . 72.5996347) (27/16 . 74.9856347) (7/4 . 77.3716347) (29/16 . 79.7576347) (15/8 . 82.1436347) (31/16 . 84.5296347) (2 . 86.9156347) (33/16 . 89.3016347) (17/8 . 91.6876347) (35/16 . 94.0736347) (9/4 . 98.7225917) (37/16 . 101.1095917) (19/8 . 103.4965917) (39/16 . 105.8835917) (5/2 . 109.2695917) (41/16 . 111.6565917) (21/8 . 114.0435917) (43/16 . 116.4305917) (11/4 . 118.8175917) (45/16 . 121.2035917) (23/8 . 123.5905917) (47/16 . 125.9775917)) ((0 . 0.0000000) (3/4 . 34.8296778) (3/2 . 65.7246347) (9/4 . 96.6195917) (3 . 128.5244784)) 128.5244784)
    (279/2 ((0 . 11.8410000) (1/16 . 14.1680000) (1/8 . 16.3100000) (3/16 . 18.4530000) (1/4 . 20.5950000) (5/16 . 22.7380000) (3/8 . 25.0640000) (7/16 . 27.3910000) (1/2 . 29.5340000) (9/16 . 31.6760000) (5/8 . 33.8190000) (11/16 . 35.9610000) (3/4 . 40.5406102) (13/16 . 42.8676102) (7/8 . 45.0096102) (15/16 . 47.1526102) (1 . 49.2946102) (17/16 . 51.4376102) (9/8 . 53.7636102) (19/16 . 56.0906102) (5/4 . 58.2326102) (21/16 . 60.3756102) (11/8 . 62.5176102) (23/16 . 64.6606102) (3/2 . 68.7171017) (25/16 . 70.6641017) (13/8 . 72.5471017) (27/16 . 74.4311017) (7/4 . 77.6951017) (29/16 . 79.5791017) (15/8 . 81.5261017) (31/16 . 83.4101017) (2 . 85.2931017) (33/16 . 87.1771017) (17/8 . 89.0611017) (35/16 . 90.9451017) (9/4 . 95.5246967) (37/16 . 98.6756967) (19/8 . 101.6646967) (39/16 . 104.1846967) (5/2 . 106.7046967) (41/16 . 109.7486967) (21/8 . 112.7916967) (43/16 . 115.6186967) (11/4 . 118.2846967) (45/16 . 120.8046967) (23/8 . 123.3246967) (47/16 . 125.8446967)) ((0 . 0.0000000) (3/4 . 38.4376102) (3/2 . 67.1371017) (9/4 . 93.4216967) (3 . 128.5244497)) 128.5244497)
    (285/2 ((0 . 11.3410000) (1/16 . 14.1680000) (1/8 . 16.8340000) (3/16 . 19.2560000) (1/4 . 21.6780000) (5/16 . 24.1000000) (3/8 . 26.5210000) (7/16 . 28.9430000) (1/2 . 31.3650000) (9/16 . 33.7860000) (5/8 . 36.2080000) (11/16 . 38.6300000) (3/4 . 42.7915128) (13/16 . 45.7125128) (7/8 . 48.6335128) (15/16 . 51.6225128) (1 . 54.5435128) (17/16 . 57.4645128) (9/8 . 60.3855128) (19/16 . 63.3055128) (5/4 . 66.2265128) (21/16 . 69.1475128) (11/8 . 72.0685128) (23/16 . 74.9895128) (3/2 . 79.6899625) (25/16 . 83.3409625) (13/8 . 86.9919625) (27/16 . 90.6429625) (7/4 . 94.2949625) (29/16 . 97.9459625) (15/8 . 101.5969625) (31/16 . 105.2479625) (2 . 108.8989625) (33/16 . 112.5499625) (17/8 . 116.2019625) (35/16 . 119.8529625)) ((0 . 0.0000000) (3/4 . 41.2115128) (3/2 . 78.0699625) (9/4 . 128.5244784)) 128.5244784)
    (579/4 ((0 . 12.1380000) (1/16 . 14.4640000) (1/8 . 16.6730000) (3/16 . 19.0270000) (1/4 . 23.1150000) (5/16 . 25.3230000) (3/8 . 27.6500000) (7/16 . 29.9770000) (1/2 . 32.1850000) (9/16 . 34.3930000) (5/8 . 36.6020000) (11/16 . 38.8100000) (3/4 . 43.0663862) (13/16 . 45.3933862) (7/8 . 47.6183862) (15/16 . 49.8433862) (1 . 52.0693862) (17/16 . 54.2943862) (9/8 . 56.6213862) (19/16 . 58.9473862) (5/4 . 61.1733862) (21/16 . 63.3983862) (11/8 . 65.6233862) (23/16 . 67.8493862) (3/2 . 72.1058111) (25/16 . 74.4328111) (13/8 . 76.6578111) (27/16 . 78.8828111) (7/4 . 81.1088111) (29/16 . 83.3338111) (15/8 . 85.6608111) (31/16 . 87.9868111) (2 . 90.2128111) (33/16 . 92.4378111) (17/8 . 94.6628111) (35/16 . 96.8888111) (9/4 . 100.9452395) (37/16 . 103.0262395) (19/8 . 105.1072395) (39/16 . 107.1882395) (5/2 . 111.1492395) (41/16 . 113.2302395) (21/8 . 115.3122395) (43/16 . 117.5582395) (11/4 . 119.8042395) (45/16 . 121.8852395) (23/8 . 123.9672395) (47/16 . 126.0482395)) ((0 . 0.0000000) (3/4 . 41.2863862) (3/2 . 70.3258111) (9/4 . 99.3652395) (3 . 128.5244784)) 128.5244784)
    (591/4 ((0 . 12.9620000) (1/16 . 16.2050000) (1/8 . 19.4480000) (3/16 . 22.6910000) (1/4 . 25.9340000) (5/16 . 30.0850000) (3/8 . 34.2360000) (7/16 . 37.4790000) (1/2 . 40.7220000) (9/16 . 43.9650000) (5/8 . 47.2080000) (11/16 . 50.4510000) (3/4 . 55.4338330) (13/16 . 58.0188330) (7/8 . 60.6048330) (15/16 . 63.1898330) (1 . 65.7748330) (17/16 . 68.3608330) (9/8 . 70.9458330) (19/16 . 73.5308330) (5/4 . 76.1168330) (21/16 . 78.7018330) (11/8 . 81.2868330) (23/16 . 83.8728330) (3/2 . 88.0177686) (25/16 . 91.3797686) (13/8 . 94.7417686) (27/16 . 98.1047686) (7/4 . 101.4667686) (29/16 . 104.8287686) (15/8 . 108.1907686) (31/16 . 111.5537686) (2 . 114.9157686) (33/16 . 118.2777686) (17/8 . 121.6397686) (35/16 . 125.0017686)) ((0 . 0.0000000) (3/4 . 53.8538330) (3/2 . 86.6177686) (9/4 . 128.5244784)) 128.5244784)
    (150 ((0 . 11.7580000) (1/16 . 14.9520000) (1/8 . 18.1460000) (3/16 . 21.3400000) (1/4 . 24.5340000) (5/16 . 27.7290000) (3/8 . 31.1760000) (7/16 . 34.3820000) (1/2 . 37.8290000) (9/16 . 41.0240000) (5/8 . 44.2180000) (11/16 . 47.4120000) (3/4 . 52.8690404) (13/16 . 56.0760404) (7/8 . 58.9940404) (15/16 . 61.9130404) (1 . 64.8310404) (17/16 . 67.7500404) (9/8 . 70.6680404) (19/16 . 73.5870404) (5/4 . 76.5050404) (21/16 . 79.4240404) (11/8 . 82.3420404) (23/16 . 85.2610404) (3/2 . 92.2025485) (25/16 . 95.4095485) (13/8 . 98.4055485) (27/16 . 101.4015485) (7/4 . 104.3965485) (29/16 . 107.3925485) (15/8 . 110.3885485) (31/16 . 113.3845485) (2 . 116.3805485) (33/16 . 119.3765485) (17/8 . 122.3725485) (35/16 . 125.3685485)) ((0 . 0.0000000) (3/4 . 50.7660404) (3/2 . 88.3395485) (9/4 . 128.5244784)) 128.5244784)
    (609/4 ((0 . 12.4620000) (1/16 . 15.6680000) (1/8 . 18.3350000) (3/16 . 20.7330000) (1/4 . 23.1300000) (5/16 . 25.5280000) (3/8 . 27.9260000) (7/16 . 30.3230000) (1/2 . 32.7210000) (9/16 . 35.1180000) (5/8 . 37.5160000) (11/16 . 40.0440000) (3/4 . 44.3811257) (13/16 . 46.9081257) (7/8 . 49.0751257) (15/16 . 51.2411257) (1 . 53.4081257) (17/16 . 55.5741257) (9/8 . 57.9011257) (19/16 . 60.2271257) (5/4 . 62.3941257) (21/16 . 64.5601257) (11/8 . 66.7261257) (23/16 . 68.8931257) (3/2 . 73.1493792) (25/16 . 75.4763792) (13/8 . 77.5623792) (27/16 . 79.6483792) (7/4 . 81.7343792) (29/16 . 83.8203792) (15/8 . 86.3493792) (31/16 . 88.6753792) (2 . 90.7613792) (33/16 . 92.8473792) (17/8 . 94.9343792) (35/16 . 97.0203792) (9/4 . 101.2767195) (37/16 . 103.6037195) (19/8 . 105.6787195) (39/16 . 107.7547195) (5/2 . 109.8297195) (41/16 . 111.9057195) (21/8 . 114.2327195) (43/16 . 116.5587195) (11/4 . 118.6347195) (45/16 . 120.7097195) (23/8 . 122.7857195) (47/16 . 124.8617195)) ((0 . 0.0000000) (3/4 . 42.6011257) (3/2 . 71.3693792) (9/4 . 99.4967195) (3 . 128.5244497)) 128.5244497)
    (621/4 ((0 . 12.1380000) (1/16 . 16.7520000) (1/8 . 21.3670000) (3/16 . 25.9810000) (1/4 . 30.5960000) (5/16 . 35.2100000) (3/8 . 39.8250000) (7/16 . 44.4390000) (1/2 . 49.0540000) (9/16 . 53.6680000) (5/8 . 58.2830000) (11/16 . 62.8970000) (3/4 . 69.2516807) (13/16 . 74.1776807) (7/8 . 79.1036807) (15/16 . 84.0296807) (1 . 88.9556807) (17/16 . 93.8816807) (9/8 . 98.8076807) (19/16 . 103.7336807) (5/4 . 108.6606807) (21/16 . 113.5866807) (11/8 . 118.5126807) (23/16 . 123.4386807)) ((0 . 0.0000000) (3/4 . 67.6716807) (3/2 . 128.5244784)) 128.5244784)
    (627/4 ((0 . 12.6380000) (1/16 . 15.7820000) (1/8 . 18.9270000) (3/16 . 22.1940000) (1/4 . 25.3380000) (5/16 . 28.4830000) (3/8 . 31.6270000) (7/16 . 34.7720000) (1/2 . 37.9160000) (9/16 . 41.0610000) (5/8 . 44.2060000) (11/16 . 47.3500000) (3/4 . 52.6546490) (13/16 . 55.6526490) (7/8 . 58.6506490) (15/16 . 61.9176490) (1 . 64.9156490) (17/16 . 67.9136490) (9/8 . 70.9116490) (19/16 . 73.9096490) (5/4 . 76.9076490) (21/16 . 79.9056490) (11/8 . 82.9036490) (23/16 . 85.9026490) (3/2 . 91.9402983) (25/16 . 94.9512983) (13/8 . 97.9622983) (27/16 . 101.2292983) (7/4 . 104.2402983) (29/16 . 107.2512983) (15/8 . 110.2982983) (31/16 . 113.3092983) (2 . 116.3202983) (33/16 . 119.3312983) (17/8 . 122.3422983) (35/16 . 125.3532983)) ((0 . 0.0000000) (3/4 . 50.6546490) (3/2 . 89.0602983) (9/4 . 128.5244784)) 128.5244784)
    (159 ((0 . 11.2580000) (1/8 . 19.5670000) (1/4 . 25.3760000) (3/8 . 29.9980000) (1/2 . 36.9930000) (5/8 . 42.8010000) (3/4 . 50.8500615) (7/8 . 58.4330615) (1 . 64.6370615) (9/8 . 70.8400615) (5/4 . 77.0440615) (11/8 . 83.2470615) (3/2 . 92.5407295) (13/8 . 98.1527295) (7/4 . 104.1957295) (15/8 . 110.2377295) (2 . 116.2797295) (17/8 . 122.3217295)) ((0 . 0.0000000) (3/4 . 49.2700615) (3/2 . 90.1107295) (9/4 . 128.5244784)) 128.5244784)
    (645/4 ((0 . 11.2580000) (1/8 . 17.3570000) (1/4 . 23.4570000) (3/8 . 29.5560000) (1/2 . 35.6560000) (11/16 . 45.5680000) (3/4 . 51.1197766) (7/8 . 57.4137766) (1 . 63.7077766) (9/8 . 68.8147766) (5/4 . 75.1087766) (11/8 . 81.4027766) (3/2 . 90.6234461) (13/8 . 96.9134461) (7/4 . 103.2034461) (15/8 . 109.4944461) (2 . 115.7844461) (17/8 . 122.0744461)) ((0 . 0.0000000) (3/4 . 49.5397766) (3/2 . 89.0434461) (9/4 . 128.5244784)) 128.5244784)
    (327/2 ((0 . 12.8080000) (1/8 . 17.0480000) (1/4 . 21.7180000) (3/8 . 26.3870000) (1/2 . 31.0570000) (5/8 . 35.7260000) (3/4 . 42.3359631) (7/8 . 46.7489631) (1 . 51.1629631) (9/8 . 55.5759631) (5/4 . 59.9899631) (11/8 . 64.4029631) (3/2 . 71.4067034) (13/8 . 75.6467034) (7/4 . 80.3157034) (15/8 . 84.9857034) (2 . 89.6547034) (17/8 . 94.3247034) (9/4 . 100.9342340) (19/8 . 105.4812340) (5/2 . 109.8402340) (41/16 . 112.5642340) (21/8 . 115.2882340) (11/4 . 119.6472340) (23/8 . 124.0062340)) ((0 . 0.0000000) (3/4 . 40.5559631) (3/2 . 68.9767034) (9/4 . 99.1542340) (3 . 128.5244497)) 128.5244497)
    (333/2 ((0 . 12.3780000) (1/8 . 17.6240000) (1/4 . 22.8690000) (5/16 . 26.1470000) (3/8 . 30.5570000) (1/2 . 35.8020000) (11/16 . 44.3260000) (3/4 . 49.3438872) (7/8 . 55.0698872) (1 . 60.7958872) (17/16 . 64.3748872) (9/8 . 68.5668872) (5/4 . 74.2928872) (23/16 . 83.5978872) (3/2 . 90.3196022) (27/16 . 100.5006022) (7/4 . 104.1056022) (15/8 . 109.8736022) (2 . 115.6416022) (17/8 . 121.4096022)) ((0 . 0.0000000) (3/4 . 47.7638872) (3/2 . 87.3366022) (9/4 . 128.5244784)) 128.5244784)
    (675/4 ((0 . 13.8570000) (1/8 . 19.9440000) (1/4 . 24.8440000) (3/8 . 29.7440000) (1/2 . 34.6440000) (5/8 . 39.5440000) (3/4 . 47.7034965) (7/8 . 51.6414965) (1 . 55.5784965) (9/8 . 59.5164965) (5/4 . 63.4544965) (11/8 . 67.3914965) (3/2 . 72.8895644) (13/8 . 76.8675644) (7/4 . 80.8465644) (15/8 . 84.8245644) (2 . 88.8025644) (17/8 . 92.7815644) (9/4 . 98.6426523) (19/8 . 103.3986523) (5/2 . 108.1546523) (21/8 . 112.9106523) (11/4 . 118.8526523) (23/8 . 123.6086523)) ((0 . 0.0000000) (3/4 . 44.6034965) (3/2 . 71.4895644) (9/4 . 96.9196523) (3 . 128.5244784)) 128.5244784)
    (687/4 ((0 . 11.2580000) (1/8 . 16.7660000) (1/4 . 22.2740000) (3/8 . 27.7820000) (1/2 . 32.1030000) (5/8 . 37.6110000) (3/4 . 50.5063410) (1 . 62.5303410) (9/8 . 68.5423410) (19/16 . 72.3003410) (5/4 . 76.0573410) (21/16 . 79.8153410) (11/8 . 83.5723410) (23/16 . 87.3303410) (3/2 . 92.6474747) (25/16 . 96.2924747) (13/8 . 99.9364747) (27/16 . 103.5814747) (7/4 . 107.2254747) (29/16 . 110.8704747) (15/8 . 114.5154747) (17/8 . 122.5334747)) ((0 . 0.0000000) (3/4 . 44.4653410) (3/2 . 91.2474747) (9/4 . 128.5244784)) 128.5244784)
    (174 ((0 . 15.7190000) (1/4 . 24.5620000) (3/8 . 29.5170000) (7/16 . 32.2810000) (1/2 . 35.0440000) (9/16 . 37.8080000) (5/8 . 40.5710000) (11/16 . 43.6380000) (3/4 . 47.9617786) (13/16 . 50.6287786) (7/8 . 53.0617786) (15/16 . 55.4957786) (1 . 57.9297786) (17/16 . 60.3637786) (9/8 . 62.7977786) (11/8 . 68.1517786) (3/2 . 73.7862950) (25/16 . 76.1272950) (13/8 . 78.4672950) (27/16 . 80.8082950) (7/4 . 83.1492950) (15/8 . 89.0912950) (17/8 . 94.2412950) (35/16 . 96.5812950) (9/4 . 100.2824690) (37/16 . 102.7434690) (19/8 . 105.2054690) (39/16 . 107.8764690) (5/2 . 111.7044690) (21/8 . 118.0264690) (23/8 . 123.4414690) (47/16 . 125.9034690)) ((0 . 0.0000000) (3/4 . 46.5617786) (3/2 . 72.2062950) (9/4 . 99.0824690) (3 . 128.5244784)) 128.5244784)
    (177 ((0 . 12.0290000) (1/8 . 16.7010000) (3/16 . 19.6210000) (1/4 . 22.5410000) (5/16 . 25.4600000) (3/8 . 28.3800000) (7/16 . 31.3000000) (1/2 . 34.2200000) (9/16 . 37.1400000) (5/8 . 40.0590000) (11/16 . 42.9790000) (3/4 . 47.8602288) (13/16 . 50.4292288) (7/8 . 52.9982288) (15/16 . 55.5682288) (1 . 58.1372288) (17/16 . 60.7062288) (9/8 . 63.2752288) (19/16 . 65.8452288) (5/4 . 68.4142288) (21/16 . 70.9832288) (11/8 . 73.5532288) (23/16 . 76.1222288) (3/2 . 80.4313931) (15/8 . 89.9603931) (9/4 . 98.8509801) (21/8 . 106.9619801) (3 . 116.8120107)) ((0 . 0.0000000) (3/4 . 46.5662288) (3/2 . 78.8513931) (9/4 . 97.2709801) (3 . 115.2320107) (15/4 . 128.5244497)) 128.5244497)
  ))
#(define concerto-repair-note-column-nids '("n2-9" "n5-229" "n5-238" "n2-50" "n2-59" "n5-296" "n2-66" "n5-302" "n2-73" "n5-378" "n6-15" "n6-19" "n6-23" "n5-755" "n6-48" "n5-778" "n6-52" "n5-783" "n6-56" "n5-915" "n2-138" "n5-934" "n2-139" "n5-946" "n5-1044" "n6-79" "n5-1067" "n6-83" "n5-1072" "n6-87" "n6-116" "n6-125" "n6-142"))
#(define concerto-note-targets (make-hash-table 6007))
#(for-each (lambda (item) (hash-set! concerto-note-targets (car item) (cdr item)))
  '(("n1-1" 0 12.965626228)
    ("n1-2" 0 17.754827658)
    ("n1-3" 0 21.202017221)
    ("n1-4" 0 21.202017221)
    ("n1-5" 0 24.195270581)
    ("n1-6" 0 24.195270581)
    ("n1-7" 0 27.188523942)
    ("n1-8" 0 27.188523942)
    ("n5-1" 0 17.754827658)
    ("n5-2" 0 21.202017221)
    ("n5-3" 0 24.195270581)
    ("n5-4" 0 27.188523942)
    ("n1-9" 0 31.541775439)
    ("n1-10" 0 31.541775439)
    ("n1-11" 0 36.846282425)
    ("n1-12" 0 36.846282425)
    ("n1-13" 0 36.846282425)
    ("n1-14" 0 40.161594805)
    ("n1-15" 0 40.161594805)
    ("n1-16" 0 40.161594805)
    ("n5-5" 0 31.541775439)
    ("n5-6" 0 36.846282425)
    ("n5-7" 0 36.846282425)
    ("n5-8" 0 36.846282425)
    ("n5-9" 0 40.161594805)
    ("n5-10" 0 40.161594805)
    ("n1-17" 0 48.753612967)
    ("n2-1" 0 48.789703932)
    ("n2-2" 0 48.789703932)
    ("n2-3" 0 58.712551754)
    ("n2-4" 0 58.712551754)
    ("n2-5" 0 58.712551754)
    ("n5-11" 0 48.789703932)
    ("n5-12" 0 52.097322265)
    ("n5-13" 0 55.404937010)
    ("n5-14" 0 58.712551754)
    ("n5-15" 0 62.020173676)
    ("n5-16" 0 65.327781244)
    ("n1-18" 0 70.339304381)
    ("n2-6" 0 70.339304381)
    ("n2-7" 0 70.339304381)
    ("n2-8" 0 70.339304381)
    ("n5-17" 0 70.375398935)
    ("n5-18" 0 73.968956613)
    ("n5-19" 0 78.350795227)
    ("n5-20" 0 80.596767879)
    ("n1-19" 0 88.030099912)
    ("n2-9" 0 90.191976345)
    ("n2-10" 0 90.191976345)
    ("n2-11" 0 94.329572036)
    ("n2-12" 0 98.244176737)
    ("n2-13" 0 102.158781438)
    ("n2-14" 0 106.073393317)
    ("n5-21" 0 88.066187288)
    ("n5-22" 0 94.329572036)
    ("n5-23" 0 98.244176737)
    ("n5-24" 0 102.158781438)
    ("n5-25" 0 106.073393317)
    ("n1-20" 0 111.728000965)
    ("n1-21" 0 111.728000965)
    ("n1-22" 0 117.576940713)
    ("n1-23" 0 118.763503407)
    ("n1-24" 0 117.576940713)
    ("n1-25" 0 121.232517289)
    ("n1-26" 0 121.232517289)
    ("n1-27" 0 121.232517289)
    ("n5-26" 0 111.728000965)
    ("n5-27" 0 117.576940713)
    ("n5-28" 0 121.232517289)
    ("n1-28" 9/2 11.257813394)
    ("n1-29" 9/2 11.257813394)
    ("n1-30" 9/2 11.257813394)
    ("n1-31" 9/2 15.187328900)
    ("n1-32" 9/2 19.116844405)
    ("n1-33" 9/2 23.185943701)
    ("n1-34" 9/2 29.473171381)
    ("n5-29" 9/2 11.257813394)
    ("n5-30" 9/2 23.185943701)
    ("n5-31" 9/2 29.473171381)
    ("n5-32" 9/2 30.659734075)
    ("n6-1" 9/2 15.187328900)
    ("n6-2" 9/2 15.187328900)
    ("n6-3" 9/2 19.116844405)
    ("n6-4" 9/2 20.303407099)
    ("n6-5" 9/2 23.185943701)
    ("n6-6" 9/2 23.185943701)
    ("n6-7" 9/2 29.473171381)
    ("n1-35" 9/2 35.142686244)
    ("n1-36" 9/2 39.887917847)
    ("n1-37" 9/2 42.853685804)
    ("n5-33" 9/2 35.142686244)
    ("n5-34" 9/2 35.142686244)
    ("n5-35" 9/2 39.887917847)
    ("n5-36" 9/2 39.887917847)
    ("n5-37" 9/2 42.853685804)
    ("n5-38" 9/2 42.853685804)
    ("n6-8" 9/2 35.142686244)
    ("n6-9" 9/2 39.887917847)
    ("n6-10" 9/2 42.853685804)
    ("n1-38" 9/2 52.304688311)
    ("n1-39" 9/2 52.304688311)
    ("n5-39" 9/2 52.304688311)
    ("n5-40" 9/2 52.304688311)
    ("n5-41" 9/2 62.210120457)
    ("n5-42" 9/2 63.396683151)
    ("n5-43" 9/2 63.396683151)
    ("n5-44" 9/2 67.289081341)
    ("n5-45" 9/2 67.289081341)
    ("n5-46" 9/2 67.289081341)
    ("n1-40" 9/2 81.206291416)
    ("n1-41" 9/2 81.206291416)
    ("n1-42" 9/2 97.515022255)
    ("n1-43" 9/2 97.515022255)
    ("n1-44" 9/2 99.718892968)
    ("n1-45" 9/2 99.718892968)
    ("n5-47" 9/2 81.206291416)
    ("n5-48" 9/2 81.206291416)
    ("n5-49" 9/2 88.258710713)
    ("n5-50" 9/2 88.258710713)
    ("n5-51" 9/2 88.258710713)
    ("n5-52" 9/2 91.784916773)
    ("n5-53" 9/2 91.784916773)
    ("n5-54" 9/2 91.784916773)
    ("n1-46" 9/2 110.829943494)
    ("n1-47" 9/2 110.829943494)
    ("n1-48" 9/2 113.077961672)
    ("n1-49" 9/2 113.077961672)
    ("n1-50" 9/2 122.519633711)
    ("n1-51" 9/2 122.519633711)
    ("n1-52" 9/2 124.767659066)
    ("n1-53" 9/2 124.767659066)
    ("n5-55" 9/2 104.985109152)
    ("n5-56" 9/2 104.985109152)
    ("n5-57" 9/2 113.077961672)
    ("n5-58" 9/2 113.077961672)
    ("n5-59" 9/2 116.674799368)
    ("n5-60" 9/2 116.674799368)
    ("n5-61" 9/2 116.674799368)
    ("n1-54" 33/4 15.436726906)
    ("n1-55" 33/4 15.436726906)
    ("n1-56" 33/4 17.044003956)
    ("n1-57" 33/4 17.044003956)
    ("n1-58" 33/4 24.589680197)
    ("n1-59" 33/4 24.589680197)
    ("n1-60" 33/4 26.196953658)
    ("n1-61" 33/4 26.196953658)
    ("n5-62" 33/4 11.257813394)
    ("n5-63" 33/4 17.044003956)
    ("n5-64" 33/4 17.044003956)
    ("n5-65" 33/4 17.044003956)
    ("n5-66" 33/4 20.410764891)
    ("n5-67" 33/4 20.410764891)
    ("n5-68" 33/4 20.410764891)
    ("n1-62" 33/4 30.508594860)
    ("n1-63" 33/4 30.508594860)
    ("n5-69" 33/4 30.508594860)
    ("n5-70" 33/4 30.508594860)
    ("n5-71" 33/4 39.240017380)
    ("n5-72" 33/4 40.426580074)
    ("n5-73" 33/4 40.426580074)
    ("n5-74" 33/4 41.993147578)
    ("n5-75" 33/4 43.179706683)
    ("n5-76" 33/4 43.179706683)
    ("n5-77" 33/4 45.935126435)
    ("n5-78" 33/4 45.935126435)
    ("n5-79" 33/4 45.935126435)
    ("n1-64" 33/4 55.745585191)
    ("n1-65" 33/4 55.745585191)
    ("n1-66" 33/4 69.390984402)
    ("n1-67" 33/4 69.390984402)
    ("n1-68" 33/4 71.530912705)
    ("n1-69" 33/4 71.530912705)
    ("n1-70" 33/4 74.197474110)
    ("n1-71" 33/4 74.197474110)
    ("n1-72" 33/4 76.337416768)
    ("n1-73" 33/4 76.337416768)
    ("n1-74" 33/4 79.003978174)
    ("n1-75" 33/4 79.003978174)
    ("n1-76" 33/4 82.325509669)
    ("n1-77" 33/4 82.325509669)
    ("n1-78" 33/4 86.032001888)
    ("n1-79" 33/4 86.032001888)
    ("n5-80" 33/4 55.745585191)
    ("n5-81" 33/4 55.745585191)
    ("n5-82" 33/4 61.766772541)
    ("n5-83" 33/4 61.766772541)
    ("n5-84" 33/4 61.766772541)
    ("n5-85" 33/4 64.179846684)
    ("n5-86" 33/4 64.179846684)
    ("n5-87" 33/4 64.179846684)
    ("n5-88" 33/4 67.251041744)
    ("n5-89" 33/4 67.251041744)
    ("n5-90" 33/4 67.251041744)
    ("n1-80" 33/4 90.088566059)
    ("n1-81" 33/4 90.088566059)
    ("n1-82" 33/4 94.526882708)
    ("n1-83" 33/4 94.526882708)
    ("n1-84" 33/4 96.233927573)
    ("n1-85" 33/4 96.233927573)
    ("n1-86" 33/4 103.782002821)
    ("n1-87" 33/4 103.782002821)
    ("n1-88" 33/4 105.489040509)
    ("n1-89" 33/4 105.489040509)
    ("n5-91" 33/4 90.088566059)
    ("n5-92" 33/4 90.088566059)
    ("n5-93" 33/4 96.233927573)
    ("n5-94" 33/4 96.233927573)
    ("n5-95" 33/4 99.343686172)
    ("n5-96" 33/4 99.343686172)
    ("n5-97" 33/4 99.343686172)
    ("n1-90" 33/4 109.960315240)
    ("n1-91" 33/4 109.960315240)
    ("n1-92" 33/4 114.403175109)
    ("n1-93" 33/4 114.403175109)
    ("n1-94" 33/4 116.111985585)
    ("n1-95" 33/4 116.111985585)
    ("n1-96" 33/4 123.921615362)
    ("n1-97" 33/4 123.921615362)
    ("n1-98" 33/4 125.630397129)
    ("n1-99" 33/4 125.630397129)
    ("n5-98" 33/4 109.960315240)
    ("n5-99" 33/4 116.111985585)
    ("n5-100" 33/4 116.111985585)
    ("n5-101" 33/4 116.111985585)
    ("n5-102" 33/4 119.478748315)
    ("n5-103" 33/4 119.478748315)
    ("n5-104" 33/4 119.478748315)
    ("n1-100" 12 11.257813394)
    ("n1-101" 12 11.257813394)
    ("n1-102" 12 16.170968286)
    ("n1-103" 12 18.060644487)
    ("n1-104" 12 18.060644487)
    ("n1-105" 12 21.084123179)
    ("n1-106" 12 21.084123179)
    ("n1-107" 12 24.770834807)
    ("n1-108" 12 24.770834807)
    ("n1-109" 12 27.437399801)
    ("n1-110" 12 27.437399801)
    ("n5-105" 12 11.257813394)
    ("n5-106" 12 11.257813394)
    ("n5-107" 12 18.060644487)
    ("n5-108" 12 16.874081793)
    ("n5-109" 12 18.060644487)
    ("n5-110" 12 21.084123179)
    ("n5-111" 12 21.084123179)
    ("n5-112" 12 21.084123179)
    ("n1-111" 12 37.525899303)
    ("n1-112" 12 40.412462359)
    ("n1-113" 12 40.412462359)
    ("n1-114" 12 40.412462359)
    ("n1-115" 12 47.644396257)
    ("n1-116" 12 47.644396257)
    ("n1-117" 12 47.644396257)
    ("n1-118" 12 49.590954216)
    ("n1-119" 12 49.590954216)
    ("n1-120" 12 49.590954216)
    ("n5-113" 12 32.200879644)
    ("n5-114" 12 32.200879644)
    ("n5-115" 12 40.412462359)
    ("n5-116" 12 40.412462359)
    ("n5-117" 12 40.412462359)
    ("n5-118" 12 43.167480183)
    ("n5-119" 12 43.167480183)
    ("n5-120" 12 43.167480183)
    ("n1-121" 12 54.085974986)
    ("n1-122" 12 54.085974986)
    ("n1-123" 12 54.085974986)
    ("n1-124" 12 59.350023630)
    ("n1-125" 12 61.374663245)
    ("n1-126" 12 65.314352548)
    ("n2-15" 12 62.561225939)
    ("n2-16" 12 62.561225939)
    ("n2-17" 12 62.561225939)
    ("n2-18" 12 70.578401192)
    ("n2-19" 12 70.578401192)
    ("n2-20" 12 70.578401192)
    ("n2-21" 12 72.904960372)
    ("n2-22" 12 72.904960372)
    ("n2-23" 12 72.904960372)
    ("n5-121" 12 54.085974986)
    ("n5-122" 12 54.085974986)
    ("n5-123" 12 61.374663245)
    ("n5-124" 12 61.374663245)
    ("n5-125" 12 65.314352548)
    ("n5-126" 12 65.314352548)
    ("n1-127" 12 77.884379525)
    ("n1-128" 12 95.581943233)
    ("n1-129" 12 95.581943233)
    ("n1-130" 12 96.768498750)
    ("n1-131" 12 98.335069842)
    ("n1-132" 12 98.335069842)
    ("n1-133" 12 99.521625359)
    ("n2-24" 12 84.260863890)
    ("n2-25" 12 84.260863890)
    ("n2-26" 12 84.260863890)
    ("n2-27" 12 86.587423070)
    ("n2-28" 12 86.587423070)
    ("n2-29" 12 86.587423070)
    ("n5-127" 12 77.884379525)
    ("n5-128" 12 77.884379525)
    ("n5-129" 12 86.587423070)
    ("n5-130" 12 86.587423070)
    ("n5-131" 12 90.013907967)
    ("n5-132" 12 90.013907967)
    ("n1-134" 12 103.578189531)
    ("n1-135" 12 103.578189531)
    ("n1-136" 12 103.578189531)
    ("n1-137" 12 111.107503362)
    ("n1-138" 12 111.107503362)
    ("n1-139" 12 111.107503362)
    ("n1-140" 12 113.860629972)
    ("n1-141" 12 113.860629972)
    ("n1-142" 12 113.860629972)
    ("n1-143" 12 117.633397217)
    ("n1-144" 12 117.633397217)
    ("n1-145" 12 117.633397217)
    ("n1-146" 12 122.233748195)
    ("n1-147" 12 122.233748195)
    ("n1-148" 12 124.591729518)
    ("n1-149" 12 124.591729518)
    ("n5-133" 12 103.578189531)
    ("n5-134" 12 103.578189531)
    ("n5-135" 12 109.920947845)
    ("n5-136" 12 111.107503362)
    ("n5-137" 12 111.107503362)
    ("n5-138" 12 112.674067277)
    ("n5-139" 12 113.860629972)
    ("n5-140" 12 113.860629972)
    ("n5-141" 12 117.633397217)
    ("n5-142" 12 117.633397217)
    ("n5-143" 12 117.633397217)
    ("n1-150" 63/4 17.684619481)
    ("n1-151" 63/4 17.684619481)
    ("n1-152" 63/4 17.684619481)
    ("n1-153" 63/4 20.011182249)
    ("n1-154" 63/4 20.011182249)
    ("n1-155" 63/4 20.011182249)
    ("n1-156" 63/4 23.487988868)
    ("n1-157" 63/4 23.487988868)
    ("n1-158" 63/4 23.487988868)
    ("n1-159" 63/4 27.727473261)
    ("n1-160" 63/4 27.727473261)
    ("n1-161" 63/4 27.727473261)
    ("n1-162" 63/4 30.054036029)
    ("n1-163" 63/4 30.054036029)
    ("n1-164" 63/4 30.054036029)
    ("n1-165" 63/4 33.166862916)
    ("n1-166" 63/4 33.166862916)
    ("n1-167" 63/4 33.166862916)
    ("n5-144" 63/4 11.257813394)
    ("n5-145" 63/4 11.257813394)
    ("n5-146" 63/4 17.684619481)
    ("n5-147" 63/4 17.684619481)
    ("n5-148" 63/4 17.684619481)
    ("n5-149" 63/4 20.011182249)
    ("n5-150" 63/4 20.011182249)
    ("n5-151" 63/4 20.011182249)
    ("n5-152" 63/4 23.487988868)
    ("n5-153" 63/4 23.487988868)
    ("n5-154" 63/4 23.487988868)
    ("n1-168" 63/4 38.383670687)
    ("n1-169" 63/4 38.383670687)
    ("n1-170" 63/4 38.383670687)
    ("n1-171" 63/4 43.473458501)
    ("n1-172" 63/4 43.473458501)
    ("n1-173" 63/4 42.286892218)
    ("n1-174" 63/4 43.473458501)
    ("n1-175" 63/4 46.986583963)
    ("n1-176" 63/4 46.986583963)
    ("n1-177" 63/4 45.800021269)
    ("n1-178" 63/4 46.986583963)
    ("n1-179" 63/4 50.118760804)
    ("n2-30" 63/4 55.208545029)
    ("n2-31" 63/4 55.208545029)
    ("n2-32" 63/4 55.208545029)
    ("n2-33" 63/4 57.535111386)
    ("n2-34" 63/4 57.535111386)
    ("n2-35" 63/4 57.535111386)
    ("n5-155" 63/4 38.383670687)
    ("n5-156" 63/4 38.383670687)
    ("n5-157" 63/4 43.473458501)
    ("n5-158" 63/4 43.473458501)
    ("n5-159" 63/4 46.986583963)
    ("n5-160" 63/4 46.986583963)
    ("n5-161" 63/4 50.118760804)
    ("n5-162" 63/4 50.118760804)
    ("n1-180" 63/4 62.407287584)
    ("n1-181" 63/4 79.030419282)
    ("n1-182" 63/4 77.843863765)
    ("n1-183" 63/4 79.030419282)
    ("n1-184" 63/4 81.783545892)
    ("n1-185" 63/4 80.596990375)
    ("n1-186" 63/4 81.783545892)
    ("n2-36" 63/4 67.634473706)
    ("n2-37" 63/4 67.634473706)
    ("n2-38" 63/4 67.634473706)
    ("n2-39" 63/4 69.961032885)
    ("n2-40" 63/4 69.961032885)
    ("n2-41" 63/4 69.961032885)
    ("n5-163" 63/4 62.407287584)
    ("n5-164" 63/4 62.407287584)
    ("n5-165" 63/4 67.634473706)
    ("n5-166" 63/4 67.634473706)
    ("n5-167" 63/4 69.961032885)
    ("n5-168" 63/4 69.961032885)
    ("n5-169" 63/4 73.177761702)
    ("n5-170" 63/4 73.177761702)
    ("n1-187" 63/4 86.740277655)
    ("n1-188" 63/4 86.740277655)
    ("n1-189" 63/4 86.740277655)
    ("n1-190" 63/4 93.181120711)
    ("n1-191" 63/4 93.181120711)
    ("n1-192" 63/4 95.507687068)
    ("n1-193" 63/4 95.507687068)
    ("n1-194" 63/4 98.998537835)
    ("n1-195" 63/4 98.998537835)
    ("n5-171" 63/4 86.740277655)
    ("n5-172" 63/4 86.740277655)
    ("n5-173" 63/4 93.181120711)
    ("n5-174" 63/4 93.181120711)
    ("n5-175" 63/4 95.507687068)
    ("n5-176" 63/4 95.507687068)
    ("n5-177" 63/4 98.998537835)
    ("n5-178" 63/4 98.998537835)
    ("n1-196" 63/4 106.099210002)
    ("n1-197" 63/4 108.185803919)
    ("n1-198" 63/4 109.282385023)
    ("n1-199" 63/4 110.453983083)
    ("n1-200" 63/4 115.603805277)
    ("n1-201" 63/4 118.270366682)
    ("n1-202" 63/4 121.096924069)
    ("n1-203" 63/4 123.115692666)
    ("n1-204" 63/4 125.134461264)
    ("n5-179" 63/4 109.267420389)
    ("n5-180" 63/4 110.453983083)
    ("n5-181" 63/4 110.453983083)
    ("n5-182" 63/4 115.603805277)
    ("n5-183" 63/4 118.270366682)
    ("n5-184" 63/4 121.096924069)
    ("n5-185" 63/4 123.115692666)
    ("n5-186" 63/4 125.134461264)
    ("n1-205" 39/2 11.257810879)
    ("n1-206" 39/2 11.257810879)
    ("n1-207" 39/2 15.949349977)
    ("n1-208" 39/2 15.949349977)
    ("n1-209" 39/2 18.275912226)
    ("n1-210" 39/2 18.275912226)
    ("n1-211" 39/2 21.163012934)
    ("n1-212" 39/2 21.163012934)
    ("n5-187" 39/2 11.257810879)
    ("n5-188" 39/2 11.257810879)
    ("n5-189" 39/2 15.949349977)
    ("n5-190" 39/2 15.949349977)
    ("n5-191" 39/2 15.949349977)
    ("n5-192" 39/2 18.275912226)
    ("n5-193" 39/2 18.275912226)
    ("n5-194" 39/2 18.275912226)
    ("n5-195" 39/2 21.163012934)
    ("n5-196" 39/2 21.163012934)
    ("n5-197" 39/2 21.163012934)
    ("n5-198" 39/2 26.759488726)
    ("n5-199" 39/2 26.759488726)
    ("n5-200" 39/2 29.086050974)
    ("n5-201" 39/2 29.086050974)
    ("n1-213" 39/2 32.608154430)
    ("n1-214" 39/2 33.704746055)
    ("n1-215" 39/2 35.791339506)
    ("n1-216" 39/2 36.962933716)
    ("n1-217" 39/2 41.480386072)
    ("n1-218" 39/2 44.686947552)
    ("n1-219" 39/2 47.513511484)
    ("n1-220" 39/2 49.284379938)
    ("n1-221" 39/2 51.230944639)
    ("n5-202" 39/2 36.962933716)
    ("n5-203" 39/2 36.962933716)
    ("n5-204" 39/2 41.480386072)
    ("n5-205" 39/2 44.686947552)
    ("n5-206" 39/2 47.513511484)
    ("n5-207" 39/2 49.284379938)
    ("n5-208" 39/2 51.230944639)
    ("n1-222" 39/2 55.804340312)
    ("n1-223" 39/2 55.804340312)
    ("n1-224" 39/2 61.643689906)
    ("n1-225" 39/2 64.563364703)
    ("n1-226" 39/2 67.769929771)
    ("n1-227" 39/2 70.596486526)
    ("n1-228" 39/2 72.421281480)
    ("n1-229" 39/2 74.367846181)
    ("n5-209" 39/2 55.804340312)
    ("n5-210" 39/2 55.804340312)
    ("n5-211" 39/2 61.643689906)
    ("n5-212" 39/2 61.643689906)
    ("n5-213" 39/2 64.563364703)
    ("n5-214" 39/2 67.769929771)
    ("n5-215" 39/2 70.596486526)
    ("n5-216" 39/2 72.421281480)
    ("n5-217" 39/2 74.367846181)
    ("n1-230" 39/2 79.027523535)
    ("n1-231" 39/2 79.027523535)
    ("n1-232" 39/2 84.866873129)
    ("n1-233" 39/2 87.786540749)
    ("n1-234" 39/2 90.993098640)
    ("n1-235" 39/2 93.819662572)
    ("n1-236" 39/2 95.644457526)
    ("n1-237" 39/2 97.591029404)
    ("n5-218" 39/2 79.027523535)
    ("n5-219" 39/2 79.027523535)
    ("n5-220" 39/2 84.866873129)
    ("n5-221" 39/2 84.866873129)
    ("n5-222" 39/2 87.786540749)
    ("n5-223" 39/2 90.993098640)
    ("n5-224" 39/2 93.819662572)
    ("n5-225" 39/2 95.644457526)
    ("n5-226" 39/2 97.591029404)
    ("n1-238" 39/2 102.450701690)
    ("n1-239" 39/2 102.450701690)
    ("n1-240" 39/2 102.450701690)
    ("n1-241" 39/2 108.760234955)
    ("n1-242" 39/2 110.767828075)
    ("n1-243" 39/2 112.334384463)
    ("n1-244" 39/2 113.900955205)
    ("n1-245" 39/2 115.072545826)
    ("n1-246" 39/2 118.279096540)
    ("n1-247" 39/2 121.105667650)
    ("n1-248" 39/2 123.256411637)
    ("n1-249" 39/2 125.407169979)
    ("n5-227" 39/2 102.450701690)
    ("n5-228" 39/2 102.450701690)
    ("n5-229" 39/2 108.365269188)
    ("n5-230" 39/2 108.365269188)
    ("n5-231" 39/2 115.072545826)
    ("n5-232" 39/2 118.279096540)
    ("n5-233" 39/2 121.105667650)
    ("n5-234" 39/2 123.256411637)
    ("n5-235" 39/2 125.407169979)
    ("n1-250" 93/4 12.137812822)
    ("n1-251" 93/4 12.137812822)
    ("n1-252" 93/4 12.137812822)
    ("n1-253" 93/4 18.098303688)
    ("n1-254" 93/4 20.105899052)
    ("n1-255" 93/4 21.672462967)
    ("n1-256" 93/4 23.239023293)
    ("n1-257" 93/4 24.410617765)
    ("n1-258" 93/4 27.617179961)
    ("n1-259" 93/4 30.443740936)
    ("n1-260" 93/4 32.467569518)
    ("n1-261" 93/4 34.491394511)
    ("n5-236" 93/4 12.137812822)
    ("n5-237" 93/4 12.137812822)
    ("n5-238" 93/4 17.703336039)
    ("n5-239" 93/4 17.703336039)
    ("n5-240" 93/4 24.410617765)
    ("n5-241" 93/4 27.617179961)
    ("n5-242" 93/4 30.443740936)
    ("n5-243" 93/4 32.467569518)
    ("n5-244" 93/4 34.491394511)
    ("n1-262" 93/4 39.214157631)
    ("n1-263" 93/4 39.214157631)
    ("n1-264" 93/4 39.214157631)
    ("n1-265" 93/4 42.387212684)
    ("n1-266" 93/4 45.053774089)
    ("n1-267" 93/4 45.053774089)
    ("n1-268" 93/4 47.036939777)
    ("n1-269" 93/4 49.020094699)
    ("n1-270" 93/4 51.003253210)
    ("n1-271" 93/4 51.003253210)
    ("n1-272" 93/4 53.669821793)
    ("n1-273" 93/4 55.652976715)
    ("n1-274" 93/4 58.699539341)
    ("n1-275" 93/4 58.699539341)
    ("n1-276" 93/4 60.682701441)
    ("n1-277" 93/4 62.665863540)
    ("n5-245" 93/4 39.214157631)
    ("n5-246" 93/4 39.214157631)
    ("n5-247" 93/4 51.003253210)
    ("n5-248" 93/4 51.003253210)
    ("n5-249" 93/4 51.003253210)
    ("n1-278" 93/4 66.922429865)
    ("n1-279" 93/4 66.922429865)
    ("n1-280" 93/4 69.319441250)
    ("n1-281" 93/4 71.716452634)
    ("n1-282" 93/4 74.113471196)
    ("n1-283" 93/4 74.113471196)
    ("n1-284" 93/4 77.320036981)
    ("n1-285" 93/4 79.717048365)
    ("n1-286" 93/4 82.923606973)
    ("n1-287" 93/4 82.923606973)
    ("n1-288" 93/4 85.320625534)
    ("n1-289" 93/4 87.717636919)
    ("n1-290" 93/4 90.764206723)
    ("n1-291" 93/4 90.764206723)
    ("n1-292" 93/4 93.161225284)
    ("n1-293" 93/4 95.558236669)
    ("n5-250" 93/4 66.922429865)
    ("n5-251" 93/4 66.922429865)
    ("n5-252" 93/4 66.922429865)
    ("n5-253" 93/4 82.923606973)
    ("n5-254" 93/4 93.161225284)
    ("n6-11" 93/4 82.923606973)
    ("n6-12" 93/4 82.923606973)
    ("n1-294" 93/4 99.515251932)
    ("n1-295" 93/4 99.515251932)
    ("n1-296" 93/4 102.721810540)
    ("n1-297" 93/4 105.048376897)
    ("n1-298" 93/4 107.208344173)
    ("n1-299" 93/4 110.254913976)
    ("n1-300" 93/4 112.581480333)
    ("n1-301" 93/4 114.741454787)
    ("n1-302" 93/4 117.408016192)
    ("n1-303" 93/4 119.567990645)
    ("n1-304" 93/4 121.727965099)
    ("n1-305" 93/4 123.887939552)
    ("n1-306" 93/4 126.047914005)
    ("n5-255" 93/4 99.515251932)
    ("n5-256" 93/4 99.515251932)
    ("n5-257" 93/4 99.515251932)
    ("n5-258" 105/4 11.257813394)
    ("n5-259" 105/4 11.257813394)
    ("n5-260" 105/4 17.976844331)
    ("n5-261" 105/4 17.976844331)
    ("n5-262" 105/4 21.424032100)
    ("n5-263" 105/4 21.424032100)
    ("n5-264" 105/4 24.867964970)
    ("n5-265" 105/4 24.867964970)
    ("n1-307" 105/4 30.051897199)
    ("n1-308" 105/4 36.549347483)
    ("n1-309" 105/4 39.996535251)
    ("n1-310" 105/4 39.996535251)
    ("n1-311" 105/4 43.245260393)
    ("n1-312" 105/4 43.245260393)
    ("n1-313" 105/4 46.493985535)
    ("n1-314" 105/4 46.493985535)
    ("n5-266" 105/4 30.051897199)
    ("n5-267" 105/4 30.051897199)
    ("n5-268" 105/4 36.549347483)
    ("n5-269" 105/4 39.996535251)
    ("n5-270" 105/4 43.245260393)
    ("n5-271" 105/4 46.493985535)
    ("n1-315" 105/4 51.102712402)
    ("n1-316" 105/4 51.102712402)
    ("n1-317" 105/4 56.303116494)
    ("n1-318" 105/4 56.303116494)
    ("n1-319" 105/4 56.303116494)
    ("n1-320" 105/4 59.553363220)
    ("n1-321" 105/4 59.553363220)
    ("n1-322" 105/4 59.553363220)
    ("n5-272" 105/4 51.102712402)
    ("n5-273" 105/4 56.303116494)
    ("n5-274" 105/4 56.303116494)
    ("n5-275" 105/4 56.303116494)
    ("n5-276" 105/4 59.553363220)
    ("n5-277" 105/4 59.553363220)
    ("n1-323" 105/4 68.018429609)
    ("n2-42" 105/4 68.054524163)
    ("n2-43" 105/4 68.054524163)
    ("n2-44" 105/4 77.829315414)
    ("n2-45" 105/4 77.829315414)
    ("n2-46" 105/4 77.829315414)
    ("n5-278" 105/4 68.054524163)
    ("n5-279" 105/4 71.312795090)
    ("n5-280" 105/4 74.571058841)
    ("n5-281" 105/4 77.829315414)
    ("n5-282" 105/4 81.087579164)
    ("n5-283" 105/4 84.345850092)
    ("n1-324" 105/4 89.308022235)
    ("n2-47" 105/4 89.308022235)
    ("n2-48" 105/4 89.308022235)
    ("n2-49" 105/4 89.308022235)
    ("n5-284" 105/4 89.344116788)
    ("n5-285" 105/4 92.870947272)
    ("n5-286" 105/4 97.171452920)
    ("n5-287" 105/4 99.375725561)
    ("n1-325" 105/4 106.702690268)
    ("n2-50" 105/4 108.864566701)
    ("n2-51" 105/4 108.864566701)
    ("n2-52" 105/4 112.917549408)
    ("n2-53" 105/4 116.779286247)
    ("n2-54" 105/4 120.641023085)
    ("n2-55" 105/4 124.502745569)
    ("n5-288" 105/4 106.738777644)
    ("n5-289" 105/4 112.917549408)
    ("n5-290" 105/4 116.779286247)
    ("n5-291" 105/4 120.641023085)
    ("n5-292" 105/4 124.502745569)
    ("n1-326" 123/4 11.257813394)
    ("n1-327" 123/4 15.265313662)
    ("n1-328" 123/4 16.451876357)
    ("n1-329" 123/4 21.145160583)
    ("n2-56" 123/4 11.257813394)
    ("n2-57" 123/4 15.265313662)
    ("n2-58" 123/4 18.205238020)
    ("n2-59" 123/4 23.234849703)
    ("n2-60" 123/4 23.234849703)
    ("n2-61" 123/4 26.891100945)
    ("n2-62" 123/4 29.831027096)
    ("n5-293" 123/4 11.257813394)
    ("n5-294" 123/4 15.265313662)
    ("n5-295" 123/4 18.205238020)
    ("n5-296" 123/4 21.145160583)
    ("n5-297" 123/4 26.891100945)
    ("n5-298" 123/4 29.831027096)
    ("n1-330" 123/4 34.510949017)
    ("n1-331" 123/4 38.358449716)
    ("n1-332" 123/4 38.358449716)
    ("n1-333" 123/4 43.021623448)
    ("n2-63" 123/4 34.510949017)
    ("n2-64" 123/4 38.358449716)
    ("n2-65" 123/4 40.690032993)
    ("n2-66" 123/4 45.111307186)
    ("n2-67" 123/4 45.111307186)
    ("n2-68" 123/4 48.767558427)
    ("n2-69" 123/4 51.099141704)
    ("n5-299" 123/4 34.510949017)
    ("n5-300" 123/4 38.358449716)
    ("n5-301" 123/4 40.690032993)
    ("n5-302" 123/4 43.021623448)
    ("n5-303" 123/4 48.767558427)
    ("n5-304" 123/4 51.099141704)
    ("n1-334" 123/4 54.790726707)
    ("n1-335" 123/4 58.418232932)
    ("n1-336" 123/4 58.418232932)
    ("n1-337" 123/4 63.576725282)
    ("n2-70" 123/4 54.790726707)
    ("n2-71" 123/4 58.418232932)
    ("n2-72" 123/4 60.910156700)
    ("n2-73" 123/4 65.666405431)
    ("n2-74" 123/4 65.666405431)
    ("n2-75" 123/4 70.422654163)
    ("n2-76" 123/4 72.914585108)
    ("n5-305" 123/4 54.790726707)
    ("n5-306" 123/4 58.418232932)
    ("n5-307" 123/4 60.910156700)
    ("n5-308" 123/4 63.576725282)
    ("n5-309" 123/4 70.422654163)
    ("n5-310" 123/4 72.914585108)
    ("n1-338" 123/4 76.838699709)
    ("n1-339" 123/4 76.838699709)
    ("n1-340" 123/4 76.838699709)
    ("n1-341" 123/4 81.450936267)
    ("n1-342" 123/4 81.450936267)
    ("n1-343" 123/4 81.450936267)
    ("n1-344" 123/4 85.678434598)
    ("n1-345" 123/4 85.678434598)
    ("n1-346" 123/4 85.678434598)
    ("n1-347" 123/4 89.191556472)
    ("n1-348" 123/4 89.191556472)
    ("n1-349" 123/4 89.191556472)
    ("n1-350" 123/4 92.074204321)
    ("n1-351" 123/4 92.074204321)
    ("n1-352" 123/4 92.074204321)
    ("n5-311" 123/4 81.450936267)
    ("n5-312" 123/4 85.678434598)
    ("n5-313" 123/4 86.864997292)
    ("n5-314" 123/4 89.191556472)
    ("n5-315" 123/4 89.191556472)
    ("n5-316" 123/4 92.074204321)
    ("n5-317" 123/4 92.074204321)
    ("n6-13" 123/4 76.802605155)
    ("n1-353" 123/4 96.696855116)
    ("n1-354" 123/4 96.696855116)
    ("n1-355" 123/4 96.696855116)
    ("n1-356" 123/4 103.893315295)
    ("n1-357" 123/4 103.893315295)
    ("n1-358" 123/4 103.893315295)
    ("n1-359" 123/4 106.666100481)
    ("n1-360" 123/4 106.666100481)
    ("n1-361" 123/4 106.666100481)
    ("n1-362" 123/4 111.102558215)
    ("n1-363" 123/4 111.102558215)
    ("n1-364" 123/4 111.102558215)
    ("n5-318" 123/4 96.696855116)
    ("n5-319" 123/4 96.696855116)
    ("n5-320" 123/4 103.893315295)
    ("n5-321" 123/4 103.893315295)
    ("n5-322" 123/4 103.893315295)
    ("n5-323" 123/4 106.666100481)
    ("n5-324" 123/4 106.666100481)
    ("n5-325" 123/4 111.102558215)
    ("n5-326" 123/4 111.102558215)
    ("n5-327" 123/4 111.102558215)
    ("n6-14" 123/4 96.696855116)
    ("n1-365" 123/4 115.615346347)
    ("n1-366" 123/4 115.615346347)
    ("n1-367" 123/4 115.615346347)
    ("n5-328" 123/4 115.615346347)
    ("n5-329" 123/4 115.615346347)
    ("n5-330" 123/4 121.739908097)
    ("n5-331" 123/4 121.739908097)
    ("n1-368" 141/4 14.191897238)
    ("n1-369" 141/4 17.125982876)
    ("n1-370" 141/4 20.060068514)
    ("n1-371" 141/4 24.754603382)
    ("n5-332" 141/4 11.257813394)
    ("n5-333" 141/4 11.257813394)
    ("n5-334" 141/4 14.191897238)
    ("n5-335" 141/4 17.125982876)
    ("n5-336" 141/4 20.060068514)
    ("n5-337" 141/4 24.754603382)
    ("n1-372" 141/4 29.772101607)
    ("n1-373" 141/4 33.644651022)
    ("n5-338" 141/4 29.772101607)
    ("n5-339" 141/4 33.644651022)
    ("n5-340" 141/4 36.422155271)
    ("n5-341" 141/4 36.422155271)
    ("n1-374" 141/4 46.190702286)
    ("n1-375" 141/4 46.190702286)
    ("n5-342" 141/4 46.190702286)
    ("n5-343" 141/4 46.190702286)
    ("n5-344" 141/4 46.190702286)
    ("n5-345" 141/4 46.190702286)
    ("n1-376" 141/4 53.972459086)
    ("n1-377" 141/4 53.972459086)
    ("n5-346" 141/4 53.972459086)
    ("n5-347" 141/4 53.972459086)
    ("n5-348" 141/4 53.972459086)
    ("n5-349" 141/4 53.972459086)
    ("n1-378" 141/4 61.754219474)
    ("n1-379" 141/4 61.754219474)
    ("n1-380" 141/4 66.740098181)
    ("n1-381" 141/4 69.233048301)
    ("n1-382" 141/4 74.218927008)
    ("n5-350" 141/4 61.754219474)
    ("n5-351" 141/4 61.754219474)
    ("n5-352" 141/4 61.754219474)
    ("n5-353" 141/4 61.754219474)
    ("n1-383" 141/4 78.071871675)
    ("n1-384" 141/4 82.085975044)
    ("n1-385" 141/4 84.093023139)
    ("n1-386" 141/4 88.107126507)
    ("n1-387" 141/4 92.558319201)
    ("n1-388" 141/4 97.544197909)
    ("n1-389" 141/4 97.544197909)
    ("n1-390" 141/4 100.037140851)
    ("n1-391" 141/4 105.023033912)
    ("n1-392" 141/4 105.023033912)
    ("n5-354" 141/4 92.558319201)
    ("n5-355" 141/4 97.544197909)
    ("n5-356" 141/4 97.544197909)
    ("n5-357" 141/4 97.544197909)
    ("n5-358" 141/4 100.037140851)
    ("n5-359" 141/4 105.023033912)
    ("n5-360" 141/4 105.023033912)
    ("n5-361" 141/4 105.023033912)
    ("n1-393" 141/4 108.875971403)
    ("n1-394" 141/4 115.237046142)
    ("n1-395" 141/4 115.237046142)
    ("n1-396" 141/4 116.978613736)
    ("n1-397" 141/4 118.822859533)
    ("n1-398" 141/4 118.822859533)
    ("n1-399" 141/4 122.003400491)
    ("n1-400" 141/4 122.003400491)
    ("n1-401" 141/4 125.183941450)
    ("n1-402" 141/4 125.183941450)
    ("n5-362" 141/4 108.875971403)
    ("n5-363" 141/4 115.237046142)
    ("n5-364" 141/4 115.237046142)
    ("n5-365" 141/4 118.822859533)
    ("n5-366" 141/4 125.183941450)
    ("n5-367" 141/4 125.183941450)
    ("n1-403" 165/4 10.877811537)
    ("n1-404" 165/4 17.746444215)
    ("n1-405" 165/4 17.746444215)
    ("n1-406" 165/4 21.180762349)
    ("n1-407" 165/4 28.049393233)
    ("n1-408" 165/4 28.049393233)
    ("n5-368" 165/4 10.877811537)
    ("n5-369" 165/4 17.746444215)
    ("n5-370" 165/4 17.746444215)
    ("n5-371" 165/4 17.746444215)
    ("n5-372" 165/4 21.180762349)
    ("n5-373" 165/4 28.049393233)
    ("n5-374" 165/4 28.049393233)
    ("n1-409" 165/4 33.223710336)
    ("n1-410" 165/4 41.398181086)
    ("n1-411" 165/4 41.398181086)
    ("n1-412" 165/4 44.936677451)
    ("n1-413" 165/4 46.780930014)
    ("n1-414" 165/4 46.780930014)
    ("n1-415" 165/4 50.868161800)
    ("n1-416" 165/4 50.868161800)
    ("n1-417" 165/4 54.955397175)
    ("n1-418" 165/4 54.955397175)
    ("n5-375" 165/4 33.223710336)
    ("n5-376" 165/4 41.398181086)
    ("n5-377" 165/4 41.398181086)
    ("n5-378" 165/4 46.780930014)
    ("n6-15" 165/4 46.780930014)
    ("n6-16" 165/4 50.868161800)
    ("n6-17" 165/4 54.955397175)
    ("n7-1" 165/4 46.780930014)
    ("n1-419" 165/4 60.782624342)
    ("n1-420" 165/4 60.782624342)
    ("n1-421" 165/4 67.219295959)
    ("n1-422" 165/4 67.219295959)
    ("n1-423" 165/4 70.437624591)
    ("n1-424" 165/4 76.874289031)
    ("n1-425" 165/4 76.874289031)
    ("n5-379" 165/4 60.782624342)
    ("n5-380" 165/4 60.782624342)
    ("n5-381" 165/4 67.219295959)
    ("n5-382" 165/4 67.219295959)
    ("n5-383" 165/4 67.219295959)
    ("n5-384" 165/4 70.437624591)
    ("n5-385" 165/4 76.874289031)
    ("n5-386" 165/4 76.874289031)
    ("n5-387" 165/4 76.874289031)
    ("n6-18" 165/4 60.782624342)
    ("n1-426" 165/4 81.452619084)
    ("n1-427" 165/4 89.399570030)
    ("n1-428" 165/4 89.399570030)
    ("n1-429" 165/4 91.528803707)
    ("n1-430" 165/4 93.373049092)
    ("n1-431" 165/4 93.373049092)
    ("n1-432" 165/4 97.346520977)
    ("n1-433" 165/4 97.346520977)
    ("n1-434" 165/4 101.320000038)
    ("n1-435" 165/4 101.320000038)
    ("n5-388" 165/4 81.452619084)
    ("n5-389" 165/4 89.399570030)
    ("n5-390" 165/4 89.399570030)
    ("n5-391" 165/4 93.373049092)
    ("n5-392" 165/4 101.320000038)
    ("n5-393" 165/4 101.320000038)
    ("n1-436" 165/4 106.653466167)
    ("n1-437" 165/4 113.890462021)
    ("n1-438" 165/4 113.890462021)
    ("n1-439" 165/4 117.508959947)
    ("n1-440" 165/4 124.745941447)
    ("n1-441" 165/4 124.745941447)
    ("n5-394" 165/4 106.653466167)
    ("n5-395" 165/4 113.890462021)
    ("n5-396" 165/4 113.890462021)
    ("n5-397" 165/4 113.890462021)
    ("n5-398" 165/4 117.508959947)
    ("n5-399" 165/4 124.745941447)
    ("n5-400" 165/4 124.745941447)
    ("n1-442" 45 11.257813394)
    ("n1-443" 45 19.118635137)
    ("n1-444" 45 19.118635137)
    ("n1-445" 45 22.657135882)
    ("n1-446" 45 24.501388856)
    ("n1-447" 45 24.501388856)
    ("n1-448" 45 28.431797934)
    ("n1-449" 45 28.431797934)
    ("n1-450" 45 32.362210600)
    ("n1-451" 45 32.362210600)
    ("n5-401" 45 11.257813394)
    ("n5-402" 45 19.118635137)
    ("n5-403" 45 19.118635137)
    ("n5-404" 45 24.501388856)
    ("n6-19" 45 25.501388858)
    ("n6-20" 45 28.431797934)
    ("n6-21" 45 32.362210600)
    ("n7-2" 45 24.501388856)
    ("n1-452" 45 37.852619967)
    ("n1-453" 45 37.852619967)
    ("n1-454" 45 45.411392955)
    ("n1-455" 45 45.411392955)
    ("n1-456" 45 48.949890111)
    ("n1-457" 45 50.794143085)
    ("n1-458" 45 50.794143085)
    ("n1-459" 45 54.680706144)
    ("n1-460" 45 54.680706144)
    ("n1-461" 45 58.460090843)
    ("n1-462" 45 58.460090843)
    ("n5-405" 45 37.852619967)
    ("n5-406" 45 37.852619967)
    ("n5-407" 45 45.411392955)
    ("n5-408" 45 45.411392955)
    ("n5-409" 45 50.794143085)
    ("n6-22" 45 37.852619967)
    ("n6-23" 45 51.794146676)
    ("n6-24" 45 54.680706144)
    ("n6-25" 45 58.460090843)
    ("n7-3" 45 50.794143085)
    ("n1-463" 45 63.799479422)
    ("n1-464" 45 63.799479422)
    ("n1-465" 45 70.533478581)
    ("n1-466" 45 80.634484498)
    ("n2-77" 45 70.533478581)
    ("n2-78" 45 73.900478161)
    ("n2-79" 45 80.634484498)
    ("n5-410" 45 63.799479422)
    ("n5-411" 45 63.799479422)
    ("n5-412" 45 70.533478581)
    ("n5-413" 45 70.533478581)
    ("n5-414" 45 80.634484498)
    ("n5-415" 45 80.634484498)
    ("n6-26" 45 63.799479422)
    ("n6-27" 45 73.900478161)
    ("n1-467" 45 85.361478626)
    ("n1-468" 45 91.971748613)
    ("n1-469" 45 101.887142828)
    ("n2-80" 45 85.361478626)
    ("n2-81" 45 91.971748613)
    ("n2-82" 45 95.276880018)
    ("n2-83" 45 101.887142828)
    ("n5-416" 45 91.971748613)
    ("n5-417" 45 91.971748613)
    ("n5-418" 45 101.887142828)
    ("n5-419" 45 103.073705523)
    ("n6-28" 45 85.361478626)
    ("n6-29" 45 95.276880018)
    ("n1-470" 45 106.750261296)
    ("n1-471" 45 106.750261296)
    ("n1-472" 45 113.955011236)
    ("n1-473" 45 117.557375441)
    ("n1-474" 45 124.762103849)
    ("n2-84" 45 106.750261296)
    ("n2-85" 45 113.955011236)
    ("n2-86" 45 124.762103849)
    ("n5-420" 45 106.750261296)
    ("n5-421" 45 113.955011236)
    ("n5-422" 45 113.955011236)
    ("n5-423" 45 113.955011236)
    ("n5-424" 45 117.557375441)
    ("n5-425" 45 124.762103849)
    ("n5-426" 45 124.762103849)
    ("n5-427" 45 124.762103849)
    ("n1-475" 195/4 10.877813967)
    ("n1-476" 195/4 12.722063353)
    ("n1-477" 195/4 16.011612878)
    ("n1-478" 195/4 19.301158814)
    ("n1-479" 195/4 22.590710133)
    ("n1-480" 195/4 25.880259657)
    ("n1-481" 195/4 29.169809182)
    ("n2-87" 195/4 12.722063353)
    ("n2-88" 195/4 19.301158814)
    ("n2-89" 195/4 22.590710133)
    ("n2-90" 195/4 25.880259657)
    ("n5-428" 195/4 12.722063353)
    ("n5-429" 195/4 19.301158814)
    ("n5-430" 195/4 19.301158814)
    ("n5-431" 195/4 19.301158814)
    ("n5-432" 195/4 22.590710133)
    ("n5-433" 195/4 29.169809182)
    ("n5-434" 195/4 29.169809182)
    ("n1-482" 195/4 33.819356843)
    ("n1-483" 195/4 41.434051627)
    ("n1-484" 195/4 41.434051627)
    ("n1-485" 195/4 41.434051627)
    ("n1-486" 195/4 52.856097392)
    ("n1-487" 195/4 52.856097392)
    ("n1-488" 195/4 52.856097392)
    ("n2-91" 195/4 33.819356843)
    ("n2-92" 195/4 33.819356843)
    ("n5-435" 195/4 33.819356843)
    ("n5-436" 195/4 33.819356843)
    ("n5-437" 195/4 41.434051627)
    ("n5-438" 195/4 41.434051627)
    ("n5-439" 195/4 45.241399019)
    ("n5-440" 195/4 52.856097392)
    ("n5-441" 195/4 52.856097392)
    ("n1-489" 195/4 58.403447730)
    ("n1-490" 195/4 64.105482860)
    ("n1-491" 195/4 66.298580472)
    ("n1-492" 195/4 66.298580472)
    ("n1-493" 195/4 66.298580472)
    ("n1-494" 195/4 69.807525168)
    ("n1-495" 195/4 75.509560298)
    ("n1-496" 195/4 75.509560298)
    ("n1-497" 195/4 77.702650733)
    ("n1-498" 195/4 77.702650733)
    ("n1-499" 195/4 77.702650733)
    ("n5-442" 195/4 58.403447730)
    ("n5-443" 195/4 66.298580472)
    ("n5-444" 195/4 66.298580472)
    ("n5-445" 195/4 69.807525168)
    ("n5-446" 195/4 75.509560298)
    ("n5-447" 195/4 75.509560298)
    ("n5-448" 195/4 77.702650733)
    ("n5-449" 195/4 77.702650733)
    ("n1-500" 195/4 82.951598374)
    ("n1-501" 195/4 82.951598374)
    ("n1-502" 195/4 82.951598374)
    ("n1-503" 195/4 90.605825630)
    ("n1-504" 195/4 90.605825630)
    ("n1-505" 195/4 91.792381147)
    ("n1-506" 195/4 102.087166514)
    ("n1-507" 195/4 102.087166514)
    ("n1-508" 195/4 102.087166514)
    ("n5-450" 195/4 82.951598374)
    ("n5-451" 195/4 82.951598374)
    ("n5-452" 195/4 82.951598374)
    ("n5-453" 195/4 90.605825630)
    ("n5-454" 195/4 90.605825630)
    ("n5-455" 195/4 94.432932081)
    ("n5-456" 195/4 102.087166514)
    ("n5-457" 195/4 102.087166514)
    ("n5-458" 195/4 102.087166514)
    ("n1-509" 195/4 107.274289044)
    ("n1-510" 195/4 114.276036727)
    ("n1-511" 195/4 114.276036727)
    ("n1-512" 195/4 116.017589966)
    ("n1-513" 195/4 117.861850118)
    ("n1-514" 195/4 121.362713193)
    ("n1-515" 195/4 124.863604978)
    ("n1-516" 195/4 124.863604978)
    ("n5-459" 195/4 107.274289044)
    ("n5-460" 195/4 114.276036727)
    ("n5-461" 195/4 114.276036727)
    ("n5-462" 195/4 114.276036727)
    ("n5-463" 195/4 117.861850118)
    ("n5-464" 195/4 124.863604978)
    ("n5-465" 195/4 124.863604978)
    ("n5-466" 195/4 124.863604978)
    ("n1-517" 105/2 10.877813967)
    ("n1-518" 105/2 10.877813967)
    ("n1-519" 105/2 14.576341197)
    ("n1-520" 105/2 14.576341197)
    ("n1-521" 105/2 18.274872014)
    ("n1-522" 105/2 18.274872014)
    ("n1-523" 105/2 18.274872014)
    ("n1-524" 105/2 21.973399244)
    ("n1-525" 105/2 21.973399244)
    ("n1-526" 105/2 29.370457291)
    ("n1-527" 105/2 29.370457291)
    ("n1-528" 105/2 29.370457291)
    ("n5-467" 105/2 10.877813967)
    ("n5-468" 105/2 10.877813967)
    ("n5-469" 105/2 10.877813967)
    ("n5-470" 105/2 14.576341197)
    ("n6-30" 105/2 14.576341197)
    ("n6-31" 105/2 18.274872014)
    ("n6-32" 105/2 21.973399244)
    ("n6-33" 105/2 25.671928267)
    ("n6-34" 105/2 29.370457291)
    ("n1-529" 105/2 34.808985672)
    ("n1-530" 105/2 34.808985672)
    ("n1-531" 105/2 34.808985672)
    ("n1-532" 105/2 43.530417415)
    ("n1-533" 105/2 43.530417415)
    ("n1-534" 105/2 43.530417415)
    ("n1-535" 105/2 47.891133286)
    ("n1-536" 105/2 49.077699569)
    ("n1-537" 105/2 47.891133286)
    ("n1-538" 105/2 54.868284421)
    ("n1-539" 105/2 54.868284421)
    ("n1-540" 105/2 54.868284421)
    ("n5-471" 105/2 34.808985672)
    ("n5-472" 105/2 39.169701543)
    ("n5-473" 105/2 43.530417415)
    ("n5-474" 105/2 47.891133286)
    ("n1-541" 105/2 61.168998215)
    ("n1-542" 105/2 61.168998215)
    ("n1-543" 105/2 61.168998215)
    ("n1-544" 105/2 66.990649935)
    ("n1-545" 105/2 68.177212629)
    ("n1-546" 105/2 68.177212629)
    ("n1-547" 105/2 78.689527074)
    ("n1-548" 105/2 78.689527074)
    ("n1-549" 105/2 78.689527074)
    ("n5-475" 105/2 61.168998215)
    ("n5-476" 105/2 66.990649935)
    ("n5-477" 105/2 68.177212629)
    ("n5-478" 105/2 68.177212629)
    ("n5-479" 105/2 71.681319837)
    ("n5-480" 105/2 78.689527074)
    ("n5-481" 105/2 78.689527074)
    ("n5-482" 105/2 78.689527074)
    ("n1-550" 105/2 91.060807921)
    ("n1-551" 105/2 91.060807921)
    ("n1-552" 105/2 91.060807921)
    ("n1-553" 105/2 92.923269661)
    ("n1-554" 105/2 94.767522635)
    ("n1-555" 105/2 94.767522635)
    ("n1-556" 105/2 94.767522635)
    ("n1-557" 105/2 98.474222995)
    ("n1-558" 105/2 102.180944887)
    ("n1-559" 105/2 102.180944887)
    ("n5-483" 105/2 83.647392847)
    ("n5-484" 105/2 91.060807921)
    ("n5-485" 105/2 91.060807921)
    ("n5-486" 105/2 91.060807921)
    ("n5-487" 105/2 94.767522635)
    ("n5-488" 105/2 102.180944887)
    ("n5-489" 105/2 102.180944887)
    ("n5-490" 105/2 102.180944887)
    ("n1-560" 105/2 107.447656303)
    ("n1-561" 105/2 107.447656303)
    ("n1-562" 105/2 113.233364192)
    ("n1-563" 105/2 114.419926886)
    ("n1-564" 105/2 114.419926886)
    ("n1-565" 105/2 124.878332762)
    ("n1-566" 105/2 124.878332762)
    ("n1-567" 105/2 124.878332762)
    ("n5-491" 105/2 107.447656303)
    ("n5-492" 105/2 113.233364192)
    ("n5-493" 105/2 114.419926886)
    ("n5-494" 105/2 114.419926886)
    ("n5-495" 105/2 117.906062178)
    ("n5-496" 105/2 124.878332762)
    ("n5-497" 105/2 124.878332762)
    ("n5-498" 105/2 124.878332762)
    ("n1-568" 225/4 10.877813967)
    ("n1-569" 225/4 10.877813967)
    ("n1-570" 225/4 10.877813967)
    ("n1-571" 225/4 18.886807119)
    ("n1-572" 225/4 18.886807119)
    ("n1-573" 225/4 18.886807119)
    ("n1-574" 225/4 21.047050720)
    ("n1-575" 225/4 22.891301900)
    ("n1-576" 225/4 22.891301900)
    ("n1-577" 225/4 22.891301900)
    ("n1-578" 225/4 26.895798476)
    ("n1-579" 225/4 30.900295052)
    ("n1-580" 225/4 30.900295052)
    ("n5-499" 225/4 10.877813967)
    ("n5-500" 225/4 18.886807119)
    ("n5-501" 225/4 18.886807119)
    ("n5-502" 225/4 18.886807119)
    ("n5-503" 225/4 22.891301900)
    ("n5-504" 225/4 30.900295052)
    ("n5-505" 225/4 30.900295052)
    ("n5-506" 225/4 30.900295052)
    ("n1-581" 225/4 36.464788329)
    ("n1-582" 225/4 36.464788329)
    ("n1-583" 225/4 44.020417667)
    ("n1-584" 225/4 44.020417667)
    ("n1-585" 225/4 54.167300773)
    ("n1-586" 225/4 55.353863468)
    ("n1-587" 225/4 55.353863468)
    ("n5-507" 225/4 36.464788329)
    ("n5-508" 225/4 44.020417667)
    ("n5-509" 225/4 44.020417667)
    ("n5-510" 225/4 47.798234130)
    ("n5-511" 225/4 55.353863468)
    ("n5-512" 225/4 54.167300773)
    ("n5-513" 225/4 55.353863468)
    ("n1-588" 225/4 60.491678068)
    ("n1-589" 225/4 61.678240762)
    ("n1-590" 225/4 61.678240762)
    ("n1-591" 225/4 68.594062019)
    ("n1-592" 225/4 68.594062019)
    ("n1-593" 225/4 68.594062019)
    ("n1-594" 225/4 78.967790315)
    ("n1-595" 225/4 78.967790315)
    ("n1-596" 225/4 78.967790315)
    ("n5-514" 225/4 61.678240762)
    ("n5-515" 225/4 68.594062019)
    ("n5-516" 225/4 68.594062019)
    ("n5-517" 225/4 68.594062019)
    ("n5-518" 225/4 72.051976236)
    ("n5-519" 225/4 78.967790315)
    ("n5-520" 225/4 78.967790315)
    ("n5-521" 225/4 78.967790315)
    ("n1-597" 225/4 84.165707479)
    ("n1-598" 225/4 84.165707479)
    ("n1-599" 225/4 84.165707479)
    ("n1-600" 225/4 90.216242737)
    ("n1-601" 225/4 91.402812609)
    ("n1-602" 225/4 91.402812609)
    ("n1-603" 225/4 102.258459537)
    ("n1-604" 225/4 102.258459537)
    ("n1-605" 225/4 102.258459537)
    ("n5-522" 225/4 84.165707479)
    ("n5-523" 225/4 91.402812609)
    ("n5-524" 225/4 90.216242737)
    ("n5-525" 225/4 91.402812609)
    ("n5-526" 225/4 95.021354408)
    ("n5-527" 225/4 102.258459537)
    ("n5-528" 225/4 102.258459537)
    ("n5-529" 225/4 102.258459537)
    ("n1-606" 225/4 107.617018637)
    ("n1-607" 225/4 107.617018637)
    ("n1-608" 225/4 107.617018637)
    ("n1-609" 225/4 114.532839894)
    ("n1-610" 225/4 114.532839894)
    ("n1-611" 225/4 114.532839894)
    ("n1-612" 225/4 124.906568191)
    ("n1-613" 225/4 124.906568191)
    ("n1-614" 225/4 124.906568191)
    ("n5-530" 225/4 107.617018637)
    ("n5-531" 225/4 113.346262845)
    ("n5-532" 225/4 114.532839894)
    ("n5-533" 225/4 114.532839894)
    ("n5-534" 225/4 117.990754111)
    ("n5-535" 225/4 117.990754111)
    ("n5-536" 225/4 124.906568191)
    ("n5-537" 225/4 123.720005497)
    ("n5-538" 225/4 124.906568191)
    ("n5-539" 225/4 124.906568191)
    ("n1-615" 60 11.257810879)
    ("n1-616" 60 11.257810879)
    ("n1-617" 60 11.257810879)
    ("n1-618" 60 17.361636096)
    ("n1-619" 60 17.361636096)
    ("n1-620" 60 17.361636096)
    ("n1-621" 60 26.517373921)
    ("n1-622" 60 26.517373921)
    ("n5-540" 60 11.257810879)
    ("n5-541" 60 11.257810879)
    ("n5-542" 60 17.361636096)
    ("n5-543" 60 17.361636096)
    ("n5-544" 60 17.361636096)
    ("n5-545" 60 17.361636096)
    ("n5-546" 60 20.413550498)
    ("n5-547" 60 20.413550498)
    ("n5-548" 60 26.517373921)
    ("n5-549" 60 26.517373921)
    ("n5-550" 60 26.517373921)
    ("n5-551" 60 26.517373921)
    ("n1-623" 60 31.309285499)
    ("n1-624" 60 31.309285499)
    ("n1-625" 60 33.153538061)
    ("n1-626" 60 33.153538061)
    ("n1-627" 60 37.144016512)
    ("n1-628" 60 37.144016512)
    ("n1-629" 60 41.134498552)
    ("n1-630" 60 41.134498552)
    ("n1-631" 60 41.134498552)
    ("n1-632" 60 45.124980592)
    ("n1-633" 60 45.124980592)
    ("n1-634" 60 45.124980592)
    ("n1-635" 60 49.115455455)
    ("n1-636" 60 49.115455455)
    ("n1-637" 60 49.115455455)
    ("n1-638" 60 53.105941084)
    ("n1-639" 60 53.105941084)
    ("n1-640" 60 53.105941084)
    ("n5-552" 60 33.153538061)
    ("n5-553" 60 33.153538061)
    ("n5-554" 60 41.134498552)
    ("n5-555" 60 41.134498552)
    ("n5-556" 60 41.134498552)
    ("n5-557" 60 41.134498552)
    ("n5-558" 60 45.124980592)
    ("n5-559" 60 45.124980592)
    ("n5-560" 60 53.105941084)
    ("n5-561" 60 53.105941084)
    ("n1-641" 60 58.836418504)
    ("n1-642" 60 58.836418504)
    ("n1-643" 60 58.836418504)
    ("n1-644" 60 65.394134964)
    ("n1-645" 60 65.394134964)
    ("n1-646" 60 65.394134964)
    ("n1-647" 60 75.230713242)
    ("n1-648" 60 75.230713242)
    ("n1-649" 60 75.230713242)
    ("n5-562" 60 58.836418504)
    ("n5-563" 60 58.836418504)
    ("n5-564" 60 65.394134964)
    ("n5-565" 60 65.394134964)
    ("n5-566" 60 68.672989605)
    ("n5-567" 60 68.672989605)
    ("n5-568" 60 75.230713242)
    ("n5-569" 60 75.230713242)
    ("n5-570" 60 75.230713242)
    ("n5-571" 60 75.230713242)
    ("n1-650" 60 80.249563264)
    ("n1-651" 60 80.249563264)
    ("n1-652" 60 80.249563264)
    ("n1-653" 60 86.501635217)
    ("n1-654" 60 86.501635217)
    ("n1-655" 60 86.501635217)
    ("n1-656" 60 88.906268338)
    ("n1-657" 60 88.906268338)
    ("n1-658" 60 88.906268338)
    ("n1-659" 60 92.753692816)
    ("n1-660" 60 92.753692816)
    ("n1-661" 60 92.753692816)
    ("n1-662" 60 99.005757592)
    ("n1-663" 60 99.005757592)
    ("n1-664" 60 99.005757592)
    ("n1-665" 60 102.518885859)
    ("n1-666" 60 102.518885859)
    ("n1-667" 60 102.518885859)
    ("n5-572" 60 80.249563264)
    ("n5-573" 60 80.249563264)
    ("n5-574" 60 86.501635217)
    ("n5-575" 60 86.501635217)
    ("n5-576" 60 86.501635217)
    ("n5-577" 60 88.906268338)
    ("n5-578" 60 88.906268338)
    ("n5-579" 60 88.906268338)
    ("n5-580" 60 88.906268338)
    ("n5-581" 60 92.753692816)
    ("n5-582" 60 92.753692816)
    ("n5-583" 60 99.005757592)
    ("n5-584" 60 99.005757592)
    ("n5-585" 60 99.005757592)
    ("n5-586" 60 102.518885859)
    ("n5-587" 60 102.518885859)
    ("n5-588" 60 101.332323430)
    ("n5-589" 60 102.518885859)
    ("n1-668" 60 108.106312894)
    ("n1-669" 60 108.106312894)
    ("n1-670" 60 108.106312894)
    ("n1-671" 60 114.859021720)
    ("n1-672" 60 114.859021720)
    ("n1-673" 60 113.672459291)
    ("n1-674" 60 114.859021720)
    ("n1-675" 60 124.988088549)
    ("n1-676" 60 124.988088549)
    ("n1-677" 60 124.988088549)
    ("n1-678" 60 124.988088549)
    ("n5-590" 60 108.106312894)
    ("n5-591" 60 108.106312894)
    ("n5-592" 60 114.859021720)
    ("n5-593" 60 114.859021720)
    ("n5-594" 60 118.235386900)
    ("n5-595" 60 118.235386900)
    ("n5-596" 60 124.988088549)
    ("n5-597" 60 124.988088549)
    ("n5-598" 60 124.988088549)
    ("n5-599" 60 124.988088549)
    ("n1-679" 255/4 11.257813394)
    ("n1-680" 255/4 11.257813394)
    ("n1-681" 255/4 11.257813394)
    ("n1-682" 255/4 11.257813394)
    ("n1-683" 255/4 16.756456899)
    ("n1-684" 255/4 16.756456899)
    ("n1-685" 255/4 18.600706285)
    ("n1-686" 255/4 18.600706285)
    ("n1-687" 255/4 18.600706285)
    ("n1-688" 255/4 22.771520233)
    ("n1-689" 255/4 22.771520233)
    ("n1-690" 255/4 22.771520233)
    ("n1-691" 255/4 26.442965781)
    ("n1-692" 255/4 26.442965781)
    ("n1-693" 255/4 26.442965781)
    ("n1-694" 255/4 30.114414918)
    ("n1-695" 255/4 30.114414918)
    ("n1-696" 255/4 30.114414918)
    ("n5-600" 255/4 11.257813394)
    ("n5-601" 255/4 11.257813394)
    ("n5-602" 255/4 18.600706285)
    ("n5-603" 255/4 18.600706285)
    ("n5-604" 255/4 18.600706285)
    ("n5-605" 255/4 20.927270847)
    ("n5-606" 255/4 20.927270847)
    ("n5-607" 255/4 22.771520233)
    ("n5-608" 255/4 22.771520233)
    ("n5-609" 255/4 22.771520233)
    ("n5-610" 255/4 26.442965781)
    ("n5-611" 255/4 26.442965781)
    ("n5-612" 255/4 26.442965781)
    ("n5-613" 255/4 30.114414918)
    ("n5-614" 255/4 30.114414918)
    ("n5-615" 255/4 30.114414918)
    ("n1-697" 255/4 35.725858389)
    ("n1-698" 255/4 35.725858389)
    ("n1-699" 255/4 35.725858389)
    ("n1-700" 255/4 42.138688512)
    ("n1-701" 255/4 42.138688512)
    ("n1-702" 255/4 42.138688512)
    ("n1-703" 255/4 44.465254869)
    ("n1-704" 255/4 44.465254869)
    ("n1-705" 255/4 44.465254869)
    ("n1-706" 255/4 47.928085525)
    ("n1-707" 255/4 47.928085525)
    ("n1-708" 255/4 47.928085525)
    ("n1-709" 255/4 51.390919769)
    ("n1-710" 255/4 51.390919769)
    ("n1-711" 255/4 51.390919769)
    ("n1-712" 255/4 53.667187730)
    ("n1-713" 255/4 54.853750424)
    ("n1-714" 255/4 54.853750424)
    ("n5-616" 255/4 35.725858389)
    ("n5-617" 255/4 35.725858389)
    ("n5-618" 255/4 35.725858389)
    ("n5-619" 255/4 42.138688512)
    ("n5-620" 255/4 42.138688512)
    ("n5-621" 255/4 42.138688512)
    ("n5-622" 255/4 44.465254869)
    ("n5-623" 255/4 44.465254869)
    ("n5-624" 255/4 44.465254869)
    ("n5-625" 255/4 47.928085525)
    ("n5-626" 255/4 47.928085525)
    ("n5-627" 255/4 47.928085525)
    ("n5-628" 255/4 51.390919769)
    ("n5-629" 255/4 51.390919769)
    ("n5-630" 255/4 51.390919769)
    ("n5-631" 255/4 53.667187730)
    ("n5-632" 255/4 54.853750424)
    ("n5-633" 255/4 54.853750424)
    ("n1-715" 255/4 60.056584026)
    ("n1-716" 255/4 60.056584026)
    ("n1-717" 255/4 60.056584026)
    ("n1-718" 255/4 66.759555794)
    ("n1-719" 255/4 70.603026449)
    ("n1-720" 255/4 73.954515921)
    ("n1-721" 255/4 77.306005394)
    ("n2-93" 255/4 66.759555794)
    ("n2-94" 255/4 66.759555794)
    ("n2-95" 255/4 70.603026449)
    ("n2-96" 255/4 70.603026449)
    ("n5-634" 255/4 60.056584026)
    ("n5-635" 255/4 60.056584026)
    ("n5-636" 255/4 60.056584026)
    ("n5-637" 255/4 66.759555794)
    ("n5-638" 255/4 66.759555794)
    ("n5-639" 255/4 70.603026449)
    ("n5-640" 255/4 70.603026449)
    ("n1-722" 255/4 82.827488806)
    ("n1-723" 255/4 82.827488806)
    ("n1-724" 255/4 96.666631580)
    ("n1-725" 255/4 96.666631580)
    ("n1-726" 255/4 100.233913227)
    ("n1-727" 255/4 100.233913227)
    ("n2-97" 255/4 82.397483458)
    ("n2-98" 255/4 85.964772283)
    ("n2-99" 255/4 89.532053930)
    ("n2-100" 255/4 93.099335578)
    ("n5-641" 255/4 82.397483458)
    ("n5-642" 255/4 82.397483458)
    ("n1-728" 255/4 105.541197821)
    ("n1-729" 255/4 105.541197821)
    ("n1-730" 255/4 113.133126265)
    ("n1-731" 255/4 116.976589742)
    ("n1-732" 255/4 120.772553964)
    ("n1-733" 255/4 124.568518186)
    ("n2-101" 255/4 113.133126265)
    ("n2-102" 255/4 113.133126265)
    ("n2-103" 255/4 116.976589742)
    ("n2-104" 255/4 116.976589742)
    ("n5-643" 255/4 113.133126265)
    ("n5-644" 255/4 113.133126265)
    ("n5-645" 255/4 116.976589742)
    ("n5-646" 255/4 116.976589742)
    ("n1-734" 135/2 11.257813394)
    ("n1-735" 135/2 18.819911257)
    ("n1-736" 135/2 22.921220402)
    ("n1-737" 135/2 27.022531341)
    ("n1-738" 135/2 31.123842280)
    ("n2-105" 135/2 11.257813394)
    ("n2-106" 135/2 11.257813394)
    ("n2-107" 135/2 18.819911257)
    ("n2-108" 135/2 18.819911257)
    ("n2-109" 135/2 22.921220402)
    ("n2-110" 135/2 22.921220402)
    ("n5-647" 135/2 11.257813394)
    ("n5-648" 135/2 11.257813394)
    ("n5-649" 135/2 18.819911257)
    ("n5-650" 135/2 18.819911257)
    ("n5-651" 135/2 22.921220402)
    ("n5-652" 135/2 22.921220402)
    ("n1-739" 135/2 36.965152577)
    ("n1-740" 135/2 44.548374977)
    ("n1-741" 135/2 44.548374977)
    ("n1-742" 135/2 48.391849221)
    ("n1-743" 135/2 48.391849221)
    ("n1-744" 135/2 52.461533465)
    ("n1-745" 135/2 52.461533465)
    ("n1-746" 135/2 56.253148253)
    ("n1-747" 135/2 56.253148253)
    ("n2-111" 135/2 36.965152577)
    ("n2-112" 135/2 36.965152577)
    ("n2-113" 135/2 44.548374977)
    ("n2-114" 135/2 48.391849221)
    ("n5-653" 135/2 36.965152577)
    ("n5-654" 135/2 36.965152577)
    ("n5-655" 135/2 44.548374977)
    ("n5-656" 135/2 44.548374977)
    ("n5-657" 135/2 48.391849221)
    ("n5-658" 135/2 48.391849221)
    ("n5-659" 135/2 52.461533465)
    ("n5-660" 135/2 52.461533465)
    ("n5-661" 135/2 56.253148253)
    ("n5-662" 135/2 56.253148253)
    ("n1-748" 135/2 61.604759744)
    ("n1-749" 135/2 68.517214855)
    ("n1-750" 135/2 72.360685510)
    ("n1-751" 135/2 75.816920243)
    ("n1-752" 135/2 79.273140621)
    ("n2-115" 135/2 61.604759744)
    ("n2-116" 135/2 68.517214855)
    ("n2-117" 135/2 68.517214855)
    ("n2-118" 135/2 72.360685510)
    ("n2-119" 135/2 72.360685510)
    ("n5-663" 135/2 61.604759744)
    ("n5-664" 135/2 61.604759744)
    ("n5-665" 135/2 68.517214855)
    ("n5-666" 135/2 68.517214855)
    ("n5-667" 135/2 72.360685510)
    ("n5-668" 135/2 72.360685510)
    ("n1-753" 135/2 84.289364879)
    ("n1-754" 135/2 92.408823585)
    ("n1-755" 135/2 92.408823585)
    ("n1-756" 135/2 96.468545760)
    ("n1-757" 135/2 96.468545760)
    ("n1-758" 135/2 100.538237182)
    ("n1-759" 135/2 100.538237182)
    ("n1-760" 135/2 104.597966535)
    ("n1-761" 135/2 104.597966535)
    ("n2-120" 135/2 84.289364879)
    ("n2-121" 135/2 92.408823585)
    ("n2-122" 135/2 96.468545760)
    ("n5-669" 135/2 84.289364879)
    ("n5-670" 135/2 84.289364879)
    ("n5-671" 135/2 92.408823585)
    ("n5-672" 135/2 96.468545760)
    ("n6-35" 135/2 92.408823585)
    ("n6-36" 135/2 96.468545760)
    ("n6-37" 135/2 100.538237182)
    ("n6-38" 135/2 104.597966535)
    ("n1-762" 135/2 110.217692589)
    ("n1-763" 135/2 110.217692589)
    ("n1-764" 135/2 115.801324091)
    ("n1-765" 135/2 114.614747042)
    ("n1-766" 135/2 115.801324091)
    ("n1-767" 135/2 119.291091087)
    ("n1-768" 135/2 119.291091087)
    ("n1-769" 135/2 119.291091087)
    ("n1-770" 135/2 124.874701057)
    ("n1-771" 135/2 124.874701057)
    ("n1-772" 135/2 124.874701057)
    ("n5-673" 135/2 110.217692589)
    ("n5-674" 135/2 119.291091087)
    ("n6-39" 135/2 119.291091087)
    ("n1-773" 285/4 12.137812822)
    ("n1-774" 285/4 13.324375516)
    ("n1-775" 285/4 19.686621947)
    ("n1-776" 285/4 19.686621947)
    ("n1-777" 285/4 23.663028433)
    ("n1-778" 285/4 23.663028433)
    ("n1-779" 285/4 30.025273069)
    ("n1-780" 285/4 30.025273069)
    ("n5-675" 285/4 13.324375516)
    ("n5-676" 285/4 19.686621947)
    ("n5-677" 285/4 23.663028433)
    ("n5-678" 285/4 30.025273069)
    ("n6-40" 285/4 13.288282756)
    ("n1-781" 285/4 36.148241463)
    ("n1-782" 285/4 36.148241463)
    ("n1-783" 285/4 42.268525552)
    ("n1-784" 285/4 42.268525552)
    ("n1-785" 285/4 43.455088246)
    ("n1-786" 285/4 46.093704902)
    ("n1-787" 285/4 46.093704902)
    ("n1-788" 285/4 46.093704902)
    ("n1-789" 285/4 52.213988992)
    ("n1-790" 285/4 52.213988992)
    ("n1-791" 285/4 52.213988992)
    ("n5-679" 285/4 36.148241463)
    ("n5-680" 285/4 36.148241463)
    ("n5-681" 285/4 34.961678768)
    ("n5-682" 285/4 36.148241463)
    ("n5-683" 285/4 42.268525552)
    ("n5-684" 285/4 42.268525552)
    ("n5-685" 285/4 42.268525552)
    ("n5-686" 285/4 42.268525552)
    ("n5-687" 285/4 46.093704902)
    ("n5-688" 285/4 46.093704902)
    ("n5-689" 285/4 46.093704902)
    ("n5-690" 285/4 46.093704902)
    ("n5-691" 285/4 52.213988992)
    ("n5-692" 285/4 52.213988992)
    ("n5-693" 285/4 52.213988992)
    ("n5-694" 285/4 52.213988992)
    ("n1-792" 285/4 57.979162676)
    ("n1-793" 285/4 57.979162676)
    ("n1-794" 285/4 59.165725370)
    ("n1-795" 285/4 64.596889860)
    ("n1-796" 285/4 64.596889860)
    ("n1-797" 285/4 64.596889860)
    ("n1-798" 285/4 66.888718169)
    ("n1-799" 285/4 66.888718169)
    ("n1-800" 285/4 66.888718169)
    ("n1-801" 285/4 68.732971144)
    ("n1-802" 285/4 68.732971144)
    ("n1-803" 285/4 68.732971144)
    ("n1-804" 285/4 74.164128456)
    ("n1-805" 285/4 75.350691150)
    ("n1-806" 285/4 75.350691150)
    ("n5-695" 285/4 57.979162676)
    ("n5-696" 285/4 57.979162676)
    ("n5-697" 285/4 57.979162676)
    ("n5-698" 285/4 57.979162676)
    ("n5-699" 285/4 64.596889860)
    ("n5-700" 285/4 64.596889860)
    ("n5-701" 285/4 64.596889860)
    ("n5-702" 285/4 64.596889860)
    ("n5-703" 285/4 68.732971144)
    ("n5-704" 285/4 67.546401272)
    ("n5-705" 285/4 68.732971144)
    ("n5-706" 285/4 68.732971144)
    ("n5-707" 285/4 74.164128456)
    ("n5-708" 285/4 75.350691150)
    ("n5-709" 285/4 75.350691150)
    ("n1-807" 285/4 81.226768203)
    ("n1-808" 285/4 81.226768203)
    ("n1-809" 285/4 81.226768203)
    ("n1-810" 285/4 92.644044663)
    ("n1-811" 285/4 92.644044663)
    ("n2-123" 285/4 98.733265474)
    ("n2-124" 285/4 98.733265474)
    ("n5-710" 285/4 81.226768203)
    ("n5-711" 285/4 81.226768203)
    ("n5-712" 285/4 81.226768203)
    ("n5-713" 285/4 98.733265474)
    ("n5-714" 285/4 98.733265474)
    ("n1-812" 285/4 106.159362806)
    ("n1-813" 285/4 109.860206504)
    ("n1-814" 285/4 113.561064555)
    ("n1-815" 285/4 117.261915430)
    ("n1-816" 285/4 120.962780659)
    ("n1-817" 285/4 124.663631533)
    ("n2-125" 285/4 109.824119127)
    ("n2-126" 285/4 123.477068839)
    ("n2-127" 285/4 124.663631533)
    ("n5-715" 285/4 106.123268253)
    ("n5-716" 285/4 106.123268253)
    ("n5-717" 285/4 109.860206504)
    ("n5-718" 285/4 113.561064555)
    ("n5-719" 285/4 117.261915430)
    ("n5-720" 285/4 120.962780659)
    ("n5-721" 285/4 124.663631533)
    ("n6-41" 285/4 104.279015279)
    ("n6-42" 285/4 106.123268253)
    ("n1-818" 75 12.758156112)
    ("n1-819" 75 24.740105272)
    ("n2-128" 75 12.758156112)
    ("n2-129" 75 12.758156112)
    ("n2-130" 75 24.740105272)
    ("n2-131" 75 31.130477678)
    ("n5-722" 75 24.740105272)
    ("n5-723" 75 31.130477678)
    ("n6-43" 75 10.877813967)
    ("n6-44" 75 12.722063353)
    ("n1-820" 75 36.864462481)
    ("n1-821" 75 41.448205228)
    ("n1-822" 75 46.031958741)
    ("n1-823" 75 50.615705077)
    ("n1-824" 75 55.199458590)
    ("n1-825" 75 59.783201337)
    ("n2-132" 75 36.864462481)
    ("n2-133" 75 41.412114263)
    ("n2-134" 75 58.596638642)
    ("n2-135" 75 59.783201337)
    ("n5-724" 75 36.864462481)
    ("n5-725" 75 41.448205228)
    ("n5-726" 75 46.031958741)
    ("n5-727" 75 50.615705077)
    ("n5-728" 75 55.199458590)
    ("n5-729" 75 59.783201337)
    ("n6-45" 75 36.828367928)
    ("n1-826" 75 65.926955140)
    ("n1-827" 75 72.765699560)
    ("n1-828" 75 76.185071770)
    ("n1-829" 75 83.023823368)
    ("n2-136" 75 65.926955140)
    ("n2-137" 75 65.926955140)
    ("n5-730" 75 65.926955140)
    ("n6-46" 75 65.926955140)
    ("n6-47" 75 65.926955140)
    ("n1-830" 75 87.803190126)
    ("n1-831" 75 93.670166385)
    ("n1-832" 75 96.603643749)
    ("n1-833" 75 102.470605653)
    ("n1-834" 75 107.848241970)
    ("n1-835" 75 114.686979213)
    ("n1-836" 75 114.686979213)
    ("n1-837" 75 118.106351423)
    ("n1-838" 75 124.945095843)
    ("n1-839" 75 124.945095843)
    ("n5-731" 75 107.848241970)
    ("n5-732" 75 114.686979213)
    ("n5-733" 75 114.686979213)
    ("n5-734" 75 114.686979213)
    ("n5-735" 75 118.106351423)
    ("n5-736" 75 124.945095843)
    ("n5-737" 75 124.945095843)
    ("n5-738" 75 124.945095843)
    ("n1-840" 315/4 10.877811537)
    ("n1-841" 315/4 18.682768953)
    ("n1-842" 315/4 18.682768953)
    ("n1-843" 315/4 20.740997790)
    ("n1-844" 315/4 22.585246763)
    ("n1-845" 315/4 22.585246763)
    ("n1-846" 315/4 26.487728162)
    ("n1-847" 315/4 26.487728162)
    ("n1-848" 315/4 30.390205973)
    ("n1-849" 315/4 30.390205973)
    ("n5-739" 315/4 10.877811537)
    ("n5-740" 315/4 18.682768953)
    ("n5-741" 315/4 18.682768953)
    ("n5-742" 315/4 22.585246763)
    ("n5-743" 315/4 30.390205973)
    ("n5-744" 315/4 30.390205973)
    ("n1-850" 315/4 35.652685205)
    ("n1-851" 315/4 42.379326148)
    ("n1-852" 315/4 42.379326148)
    ("n1-853" 315/4 45.742646619)
    ("n1-854" 315/4 52.469294738)
    ("n1-855" 315/4 52.469294738)
    ("n5-745" 315/4 35.652685205)
    ("n5-746" 315/4 42.379326148)
    ("n5-747" 315/4 42.379326148)
    ("n5-748" 315/4 42.379326148)
    ("n5-749" 315/4 45.742646619)
    ("n5-750" 315/4 52.469294738)
    ("n5-751" 315/4 52.469294738)
    ("n1-856" 315/4 57.572607001)
    ("n1-857" 315/4 65.576689103)
    ("n1-858" 315/4 65.576689103)
    ("n1-859" 315/4 69.115189057)
    ("n1-860" 315/4 70.959434442)
    ("n1-861" 315/4 70.959434442)
    ("n1-862" 315/4 74.961479082)
    ("n1-863" 315/4 74.961479082)
    ("n1-864" 315/4 78.963516544)
    ("n1-865" 315/4 78.963516544)
    ("n5-752" 315/4 57.572607001)
    ("n5-753" 315/4 65.576689103)
    ("n5-754" 315/4 65.576689103)
    ("n5-755" 315/4 70.959434442)
    ("n6-48" 315/4 70.959434442)
    ("n6-49" 315/4 74.961479082)
    ("n6-50" 315/4 78.963516544)
    ("n7-4" 315/4 70.959434442)
    ("n1-866" 315/4 84.705556564)
    ("n1-867" 315/4 84.705556564)
    ("n1-868" 315/4 91.000232857)
    ("n1-869" 315/4 91.000232857)
    ("n1-870" 315/4 94.147563826)
    ("n1-871" 315/4 100.442240119)
    ("n1-872" 315/4 100.442240119)
    ("n5-756" 315/4 84.705556564)
    ("n5-757" 315/4 84.705556564)
    ("n5-758" 315/4 91.000232857)
    ("n5-759" 315/4 91.000232857)
    ("n5-760" 315/4 94.147563826)
    ("n5-761" 315/4 100.442240119)
    ("n5-762" 315/4 100.442240119)
    ("n6-51" 315/4 84.705556564)
    ("n1-873" 315/4 104.949572510)
    ("n1-874" 315/4 112.754542485)
    ("n1-875" 315/4 112.754542485)
    ("n1-876" 315/4 114.812756968)
    ("n1-877" 315/4 116.657016707)
    ("n1-878" 315/4 116.657016707)
    ("n1-879" 315/4 120.559490929)
    ("n1-880" 315/4 120.559490929)
    ("n1-881" 315/4 124.461965151)
    ("n1-882" 315/4 124.461965151)
    ("n5-763" 315/4 104.949572510)
    ("n5-764" 315/4 112.754542485)
    ("n5-765" 315/4 112.754542485)
    ("n5-766" 315/4 116.657016707)
    ("n5-767" 315/4 124.461965151)
    ("n5-768" 315/4 124.461965151)
    ("n1-883" 165/2 10.877813967)
    ("n1-884" 165/2 17.668039958)
    ("n1-885" 165/2 17.668039958)
    ("n1-886" 165/2 21.063152953)
    ("n1-887" 165/2 27.853384327)
    ("n1-888" 165/2 27.853384327)
    ("n5-769" 165/2 10.877813967)
    ("n5-770" 165/2 17.668039958)
    ("n5-771" 165/2 17.668039958)
    ("n5-772" 165/2 21.063152953)
    ("n5-773" 165/2 27.853384327)
    ("n5-774" 165/2 27.853384327)
    ("n1-889" 165/2 32.988496680)
    ("n1-890" 165/2 40.865007963)
    ("n1-891" 165/2 40.865007963)
    ("n1-892" 165/2 44.403508708)
    ("n1-893" 165/2 46.247758093)
    ("n1-894" 165/2 46.247758093)
    ("n1-895" 165/2 50.186015529)
    ("n1-896" 165/2 50.186015529)
    ("n1-897" 165/2 54.124272965)
    ("n1-898" 165/2 54.124272965)
    ("n5-775" 165/2 32.988496680)
    ("n5-776" 165/2 40.865007963)
    ("n5-777" 165/2 40.865007963)
    ("n5-778" 165/2 46.247758093)
    ("n6-52" 165/2 46.247758093)
    ("n6-53" 165/2 50.186015529)
    ("n6-54" 165/2 54.124272965)
    ("n7-5" 165/2 46.247758093)
    ("n1-899" 165/2 59.802522581)
    ("n1-900" 165/2 59.802522581)
    ("n1-901" 165/2 67.590627687)
    ("n1-902" 165/2 67.590627687)
    ("n1-903" 165/2 71.129121254)
    ("n1-904" 165/2 72.973374229)
    ("n1-905" 165/2 72.973374229)
    ("n1-906" 165/2 76.867430370)
    ("n1-907" 165/2 76.867430370)
    ("n1-908" 165/2 80.761479335)
    ("n1-909" 165/2 80.761479335)
    ("n5-779" 165/2 59.802522581)
    ("n5-780" 165/2 59.802522581)
    ("n5-781" 165/2 67.590627687)
    ("n5-782" 165/2 67.590627687)
    ("n5-783" 165/2 72.973374229)
    ("n6-55" 165/2 59.802522581)
    ("n6-56" 165/2 72.973374229)
    ("n6-57" 165/2 76.867430370)
    ("n6-58" 165/2 80.761479335)
    ("n7-6" 165/2 72.973374229)
    ("n1-910" 165/2 86.395531245)
    ("n1-911" 165/2 86.395531245)
    ("n1-912" 165/2 93.163694270)
    ("n1-913" 165/2 93.163694270)
    ("n1-914" 165/2 103.315931629)
    ("n1-915" 165/2 103.315931629)
    ("n5-784" 165/2 86.395531245)
    ("n5-785" 165/2 86.395531245)
    ("n5-786" 165/2 93.163694270)
    ("n5-787" 165/2 93.163694270)
    ("n5-788" 165/2 96.547761427)
    ("n5-789" 165/2 103.315931629)
    ("n5-790" 165/2 103.315931629)
    ("n6-59" 165/2 86.395531245)
    ("n1-916" 165/2 108.060007689)
    ("n1-917" 165/2 108.060007689)
    ("n1-918" 165/2 114.828170714)
    ("n1-919" 165/2 114.828170714)
    ("n1-920" 165/2 124.980408073)
    ("n1-921" 165/2 124.980408073)
    ("n5-791" 165/2 108.060007689)
    ("n5-792" 165/2 114.828170714)
    ("n5-793" 165/2 114.828170714)
    ("n5-794" 165/2 118.212230694)
    ("n5-795" 165/2 124.980408073)
    ("n5-796" 165/2 124.980408073)
    ("n1-922" 345/4 11.662249673)
    ("n1-923" 345/4 12.758843337)
    ("n1-924" 345/4 13.855438795)
    ("n1-925" 345/4 15.027031473)
    ("n1-926" 345/4 25.614043484)
    ("n1-927" 345/4 27.940609841)
    ("n1-928" 345/4 30.267172610)
    ("n1-929" 345/4 32.472798168)
    ("n1-930" 345/4 34.678427315)
    ("n1-931" 345/4 37.745617451)
    ("n5-797" 345/4 15.027031473)
    ("n5-798" 345/4 22.085041873)
    ("n5-799" 345/4 22.085041873)
    ("n5-800" 345/4 22.085041873)
    ("n5-801" 345/4 25.614043484)
    ("n5-802" 345/4 25.614043484)
    ("n5-803" 345/4 25.614043484)
    ("n1-932" 345/4 41.622178967)
    ("n1-933" 345/4 44.288740372)
    ("n1-934" 345/4 46.249853860)
    ("n1-935" 345/4 48.210963759)
    ("n1-936" 345/4 50.172077247)
    ("n1-937" 345/4 52.133194323)
    ("n1-938" 345/4 54.094300633)
    ("n1-939" 345/4 58.408751742)
    ("n1-940" 345/4 58.408751742)
    ("n5-804" 345/4 41.622178967)
    ("n5-805" 345/4 50.172077247)
    ("n5-806" 345/4 54.094300633)
    ("n5-807" 345/4 58.408751742)
    ("n6-60" 345/4 54.094300633)
    ("n1-941" 345/4 63.426253555)
    ("n1-942" 345/4 64.522849014)
    ("n1-943" 345/4 65.619437295)
    ("n1-944" 345/4 66.716039930)
    ("n1-945" 345/4 67.812628211)
    ("n1-946" 345/4 68.909223670)
    ("n1-947" 345/4 70.005819128)
    ("n1-948" 345/4 71.177410011)
    ("n1-949" 345/4 83.296768243)
    ("n1-950" 345/4 85.623327423)
    ("n1-951" 345/4 87.949893780)
    ("n1-952" 345/4 90.188653263)
    ("n1-953" 345/4 92.427419924)
    ("n1-954" 345/4 95.494610060)
    ("n5-808" 345/4 71.177410011)
    ("n5-809" 345/4 78.341457582)
    ("n5-810" 345/4 78.341457582)
    ("n5-811" 345/4 78.341457582)
    ("n5-812" 345/4 83.296768243)
    ("n5-813" 345/4 83.296768243)
    ("n5-814" 345/4 83.296768243)
    ("n1-955" 345/4 99.751176385)
    ("n1-956" 345/4 102.957727815)
    ("n1-957" 345/4 105.284294172)
    ("n1-958" 345/4 107.610860529)
    ("n1-959" 345/4 109.937412531)
    ("n1-960" 345/4 112.151403213)
    ("n1-961" 345/4 114.365393894)
    ("n1-962" 345/4 116.579384575)
    ("n1-963" 345/4 118.793375256)
    ("n1-964" 345/4 121.007365938)
    ("n1-965" 345/4 123.221342264)
    ("n1-966" 345/4 126.047914005)
    ("n5-815" 345/4 99.751176385)
    ("n5-816" 345/4 109.937412531)
    ("n5-817" 345/4 114.365393894)
    ("n5-818" 345/4 114.365393894)
    ("n5-819" 345/4 123.221342264)
    ("n5-820" 345/4 123.221342264)
    ("n1-967" 357/4 10.877813967)
    ("n1-968" 357/4 11.974407631)
    ("n1-969" 357/4 13.146000309)
    ("n1-970" 357/4 23.530263062)
    ("n1-971" 357/4 25.345555701)
    ("n1-972" 357/4 27.160855518)
    ("n1-973" 357/4 29.827416923)
    ("n1-974" 357/4 31.642713151)
    ("n1-975" 357/4 34.529276208)
    ("n5-821" 357/4 13.146000309)
    ("n5-822" 357/4 18.954948239)
    ("n5-823" 357/4 18.954948239)
    ("n5-824" 357/4 18.954948239)
    ("n5-825" 357/4 23.530263062)
    ("n5-826" 357/4 23.530263062)
    ("n5-827" 357/4 23.530263062)
    ("n1-976" 357/4 38.405837724)
    ("n1-977" 357/4 41.072399129)
    ("n1-978" 357/4 43.181393345)
    ("n1-979" 357/4 45.290391149)
    ("n1-980" 357/4 47.399378188)
    ("n1-981" 357/4 49.508375992)
    ("n1-982" 357/4 51.834935172)
    ("n1-983" 357/4 56.474718141)
    ("n1-984" 357/4 56.474718141)
    ("n5-828" 357/4 38.405837724)
    ("n5-829" 357/4 47.399378188)
    ("n5-830" 357/4 51.834935172)
    ("n5-831" 357/4 56.474718141)
    ("n6-61" 357/4 51.834935172)
    ("n1-985" 357/4 61.589113268)
    ("n1-986" 357/4 62.685708726)
    ("n1-987" 357/4 63.782304185)
    ("n1-988" 357/4 64.878892466)
    ("n1-989" 357/4 65.975487924)
    ("n1-990" 357/4 67.072083382)
    ("n1-991" 357/4 68.168678841)
    ("n1-992" 357/4 69.340269724)
    ("n1-993" 357/4 80.850728842)
    ("n1-994" 357/4 83.177295199)
    ("n1-995" 357/4 85.503861556)
    ("n1-996" 357/4 88.710420164)
    ("n1-997" 357/4 91.036979343)
    ("n1-998" 357/4 94.484170700)
    ("n5-832" 357/4 69.340269724)
    ("n5-833" 357/4 75.895418181)
    ("n5-834" 357/4 75.895418181)
    ("n5-835" 357/4 75.895418181)
    ("n5-836" 357/4 80.850728842)
    ("n5-837" 357/4 80.850728842)
    ("n5-838" 357/4 80.850728842)
    ("n1-999" 357/4 98.740729848)
    ("n1-1000" 357/4 101.947295633)
    ("n1-1001" 357/4 104.273861990)
    ("n1-1002" 357/4 106.220419949)
    ("n1-1003" 357/4 108.886981354)
    ("n1-1004" 357/4 111.336544801)
    ("n1-1005" 357/4 115.439545990)
    ("n1-1006" 357/4 117.233780483)
    ("n1-1007" 357/4 119.028029330)
    ("n1-1008" 357/4 121.914588798)
    ("n1-1009" 357/4 123.708837645)
    ("n1-1010" 357/4 126.062986299)
    ("n5-839" 357/4 98.740729848)
    ("n5-840" 357/4 108.886981354)
    ("n5-841" 357/4 115.439545990)
    ("n5-842" 357/4 115.439545990)
    ("n5-843" 357/4 115.439545990)
    ("n5-844" 357/4 115.439545990)
    ("n1-1011" 369/4 10.877813967)
    ("n1-1012" 369/4 12.997245746)
    ("n1-1013" 369/4 15.116681114)
    ("n1-1014" 369/4 17.236111098)
    ("n1-1015" 369/4 19.355546466)
    ("n1-1016" 369/4 21.474980039)
    ("n1-1017" 369/4 23.594413612)
    ("n1-1018" 369/4 25.713847186)
    ("n1-1019" 369/4 27.833280759)
    ("n1-1020" 369/4 30.499842164)
    ("n1-1021" 369/4 32.619275738)
    ("n1-1022" 369/4 34.738709311)
    ("n5-845" 369/4 10.877813967)
    ("n5-846" 369/4 15.116681114)
    ("n5-847" 369/4 15.116681114)
    ("n5-848" 369/4 15.116681114)
    ("n5-849" 369/4 23.594413612)
    ("n5-850" 369/4 27.833280759)
    ("n5-851" 369/4 27.833280759)
    ("n5-852" 369/4 27.833280759)
    ("n1-1023" 369/4 38.415272261)
    ("n1-1024" 369/4 40.534705835)
    ("n1-1025" 369/4 42.654139408)
    ("n1-1026" 369/4 44.773572981)
    ("n1-1027" 369/4 46.893002966)
    ("n1-1028" 369/4 49.012436539)
    ("n1-1029" 369/4 51.131870112)
    ("n1-1030" 369/4 53.251307274)
    ("n1-1031" 369/4 55.370737259)
    ("n1-1032" 369/4 58.037298664)
    ("n1-1033" 369/4 60.156735826)
    ("n1-1034" 369/4 62.276172988)
    ("n5-853" 369/4 38.415272261)
    ("n5-854" 369/4 42.654139408)
    ("n5-855" 369/4 42.654139408)
    ("n5-856" 369/4 42.654139408)
    ("n5-857" 369/4 51.131870112)
    ("n5-858" 369/4 55.370737259)
    ("n5-859" 369/4 55.370737259)
    ("n5-860" 369/4 55.370737259)
    ("n1-1035" 369/4 66.332729982)
    ("n1-1036" 369/4 68.519181431)
    ("n1-1037" 369/4 70.705632879)
    ("n1-1038" 369/4 72.892084327)
    ("n1-1039" 369/4 75.078528598)
    ("n1-1040" 369/4 77.264980047)
    ("n1-1041" 369/4 79.451438673)
    ("n1-1042" 369/4 81.637882944)
    ("n1-1043" 369/4 83.824334392)
    ("n1-1044" 369/4 86.010785841)
    ("n1-1045" 369/4 88.197244466)
    ("n1-1046" 369/4 91.083796757)
    ("n5-861" 369/4 66.332729982)
    ("n5-862" 369/4 79.451438673)
    ("n5-863" 369/4 88.197244466)
    ("n6-62" 369/4 78.264868801)
    ("n6-63" 369/4 79.451438673)
    ("n6-64" 369/4 79.451438673)
    ("n1-1047" 369/4 96.091300616)
    ("n1-1048" 369/4 98.745237182)
    ("n1-1049" 369/4 101.399180924)
    ("n1-1050" 369/4 104.053124667)
    ("n1-1051" 369/4 106.707075587)
    ("n1-1052" 369/4 109.774251369)
    ("n1-1053" 369/4 112.428202289)
    ("n1-1054" 369/4 115.082146032)
    ("n1-1055" 369/4 117.736089774)
    ("n1-1056" 369/4 120.390033517)
    ("n1-1057" 369/4 123.043977260)
    ("n1-1058" 369/4 125.710538665)
    ("n5-864" 369/4 96.091300616)
    ("n5-865" 369/4 112.428202289)
    ("n6-65" 369/4 94.796461438)
    ("n6-66" 369/4 96.055206062)
    ("n6-67" 369/4 96.055206062)
    ("n1-1059" 381/4 10.877811537)
    ("n1-1060" 381/4 14.141069947)
    ("n1-1061" 381/4 17.404328357)
    ("n1-1062" 381/4 20.667588561)
    ("n1-1063" 381/4 23.930846971)
    ("n1-1064" 381/4 27.194105380)
    ("n1-1065" 381/4 30.457367379)
    ("n1-1066" 381/4 33.720625789)
    ("n1-1067" 381/4 36.983884199)
    ("n1-1068" 381/4 40.247146197)
    ("n1-1069" 381/4 43.510401018)
    ("n1-1070" 381/4 46.773659428)
    ("n5-866" 381/4 10.877811537)
    ("n5-867" 381/4 17.404328357)
    ("n5-868" 381/4 17.404328357)
    ("n5-869" 381/4 17.404328357)
    ("n5-870" 381/4 30.457367379)
    ("n5-871" 381/4 36.983884199)
    ("n5-872" 381/4 36.983884199)
    ("n5-873" 381/4 36.983884199)
    ("n1-1071" 381/4 51.396919259)
    ("n1-1072" 381/4 54.518351011)
    ("n1-1073" 381/4 57.639771996)
    ("n1-1074" 381/4 60.761200158)
    ("n1-1075" 381/4 63.882628321)
    ("n1-1076" 381/4 67.004049306)
    ("n1-1077" 381/4 70.125477468)
    ("n1-1078" 381/4 73.246898453)
    ("n1-1079" 381/4 76.368326616)
    ("n1-1080" 381/4 79.489754778)
    ("n1-1081" 381/4 82.611175763)
    ("n1-1082" 381/4 85.732603926)
    ("n5-874" 381/4 51.396919259)
    ("n5-875" 381/4 57.639771996)
    ("n5-876" 381/4 57.639771996)
    ("n5-877" 381/4 57.639771996)
    ("n5-878" 381/4 70.125477468)
    ("n5-879" 381/4 76.368326616)
    ("n5-880" 381/4 76.368326616)
    ("n5-881" 381/4 76.368326616)
    ("n1-1083" 381/4 90.594034646)
    ("n1-1084" 381/4 93.658238348)
    ("n1-1085" 381/4 96.722427695)
    ("n1-1086" 381/4 99.786638575)
    ("n1-1087" 381/4 102.850842277)
    ("n1-1088" 381/4 105.915031624)
    ("n1-1089" 381/4 109.979238693)
    ("n1-1090" 381/4 113.043442395)
    ("n1-1091" 381/4 116.107653275)
    ("n1-1092" 381/4 119.171835445)
    ("n1-1093" 381/4 122.236046324)
    ("n1-1094" 381/4 125.300257203)
    ("n5-882" 381/4 90.594034646)
    ("n5-883" 381/4 109.979238693)
    ("n5-884" 381/4 109.979238693)
    ("n6-68" 381/4 109.979238693)
    ("n6-69" 381/4 122.236046324)
    ("n1-1095" 195/2 11.100625525)
    ("n1-1096" 195/2 13.604018590)
    ("n1-1097" 195/2 16.107411656)
    ("n1-1098" 195/2 19.313975646)
    ("n1-1099" 195/2 21.817365123)
    ("n1-1100" 195/2 24.320758188)
    ("n1-1101" 195/2 27.527320384)
    ("n1-1102" 195/2 30.030713450)
    ("n1-1103" 195/2 32.534106515)
    ("n1-1104" 195/2 35.037499580)
    ("n1-1105" 195/2 37.540892646)
    ("n1-1106" 195/2 40.747458431)
    ("n5-885" 195/2 11.064530971)
    ("n5-886" 195/2 11.064530971)
    ("n6-70" 195/2 11.100625525)
    ("n6-71" 195/2 27.527320384)
    ("n1-1107" 195/2 45.694988917)
    ("n1-1108" 195/2 48.901551113)
    ("n1-1109" 195/2 52.348742470)
    ("n1-1110" 195/2 55.020026528)
    ("n1-1111" 195/2 58.641833990)
    ("n1-1112" 195/2 60.968393170)
    ("n1-1113" 195/2 63.294959527)
    ("n1-1114" 195/2 65.550851183)
    ("n1-1115" 195/2 67.806735662)
    ("n1-1116" 195/2 70.473297068)
    ("n1-1117" 195/2 73.359856536)
    ("n1-1118" 195/2 75.615748192)
    ("n5-887" 195/2 45.694988917)
    ("n5-888" 195/2 58.641833990)
    ("n5-889" 195/2 58.641833990)
    ("n5-890" 195/2 59.828396684)
    ("n5-891" 195/2 63.294959527)
    ("n5-892" 195/2 63.294959527)
    ("n5-893" 195/2 64.481522221)
    ("n5-894" 195/2 70.473297068)
    ("n5-895" 195/2 70.473297068)
    ("n5-896" 195/2 70.473297068)
    ("n5-897" 195/2 73.359856536)
    ("n5-898" 195/2 74.546426407)
    ("n5-899" 195/2 73.359856536)
    ("n1-1119" 195/2 80.478873837)
    ("n1-1120" 195/2 82.805440194)
    ("n1-1121" 195/2 85.131999374)
    ("n1-1122" 195/2 87.078564510)
    ("n1-1123" 195/2 89.012899556)
    ("n1-1124" 195/2 91.679460962)
    ("n1-1125" 195/2 94.566027607)
    ("n1-1126" 195/2 96.500355476)
    ("n1-1127" 195/2 98.434697700)
    ("n1-1128" 195/2 100.369025570)
    ("n1-1129" 195/2 102.303367794)
    ("n1-1130" 195/2 104.657516447)
    ("n5-900" 195/2 79.292311143)
    ("n5-901" 195/2 80.478873837)
    ("n5-902" 195/2 80.478873837)
    ("n5-903" 195/2 89.012899556)
    ("n5-904" 195/2 90.199462251)
    ("n5-905" 195/2 89.012899556)
    ("n5-906" 195/2 89.012899556)
    ("n5-907" 195/2 94.566027607)
    ("n5-908" 195/2 95.752590301)
    ("n5-909" 195/2 94.566027607)
    ("n5-910" 195/2 94.566027607)
    ("n1-1131" 195/2 108.839108880)
    ("n1-1132" 195/2 114.701592160)
    ("n1-1133" 195/2 116.382841872)
    ("n1-1134" 195/2 117.669140083)
    ("n1-1135" 195/2 124.366664294)
    ("n1-1136" 195/2 126.047914005)
    ("n5-911" 195/2 108.839108880)
    ("n5-912" 195/2 108.839108880)
    ("n5-913" 195/2 111.616602363)
    ("n5-914" 195/2 111.616602363)
    ("n5-915" 195/2 114.306626305)
    ("n5-916" 195/2 117.669140083)
    ("n5-917" 195/2 121.676633174)
    ("n5-918" 195/2 121.676633174)
    ("n5-919" 195/2 124.366664294)
    ("n1-1137" 201/2 10.877813967)
    ("n1-1138" 201/2 18.415849991)
    ("n1-1139" 201/2 20.771489725)
    ("n1-1140" 201/2 23.438049336)
    ("n1-1141" 201/2 27.207070040)
    ("n1-1142" 201/2 29.562707980)
    ("n1-1143" 201/2 31.918345919)
    ("n1-1144" 201/2 34.273980270)
    ("n5-920" 201/2 10.877813967)
    ("n5-921" 201/2 14.646832876)
    ("n5-922" 201/2 14.646832876)
    ("n5-923" 201/2 18.415849991)
    ("n5-924" 201/2 23.438049336)
    ("n5-925" 201/2 27.207070040)
    ("n5-926" 201/2 27.207070040)
    ("n5-927" 201/2 31.918345919)
    ("n1-1145" 201/2 39.154618484)
    ("n1-1146" 201/2 40.998867870)
    ("n1-1147" 201/2 40.998867870)
    ("n1-1148" 201/2 56.398954747)
    ("n1-1149" 201/2 56.398954747)
    ("n1-1150" 201/2 59.888147561)
    ("n1-1151" 201/2 59.888147561)
    ("n1-1152" 201/2 64.610462101)
    ("n1-1153" 201/2 64.610462101)
    ("n2-138" 201/2 55.165825844)
    ("n5-928" 201/2 40.998867870)
    ("n5-929" 201/2 43.360028728)
    ("n5-930" 201/2 45.721185998)
    ("n5-931" 201/2 48.082346857)
    ("n5-932" 201/2 50.443507715)
    ("n5-933" 201/2 52.804664985)
    ("n5-934" 201/2 55.165825844)
    ("n5-935" 201/2 57.526986702)
    ("n5-936" 201/2 59.888147561)
    ("n5-937" 201/2 62.249301242)
    ("n5-938" 201/2 64.610462101)
    ("n5-939" 201/2 66.971630137)
    ("n1-1154" 201/2 70.692785543)
    ("n1-1155" 201/2 70.692785543)
    ("n1-1156" 201/2 71.879348238)
    ("n1-1157" 201/2 85.874367232)
    ("n1-1158" 201/2 85.874367232)
    ("n1-1159" 201/2 89.290724984)
    ("n1-1160" 201/2 89.290724984)
    ("n1-1161" 201/2 93.940218816)
    ("n1-1162" 201/2 93.940218816)
    ("n2-139" 201/2 84.641245507)
    ("n5-940" 201/2 70.692785543)
    ("n5-941" 201/2 73.017528871)
    ("n5-942" 201/2 75.342272198)
    ("n5-943" 201/2 77.667015525)
    ("n5-944" 201/2 79.991758852)
    ("n5-945" 201/2 82.316495002)
    ("n5-946" 201/2 84.641245507)
    ("n5-947" 201/2 86.965988834)
    ("n5-948" 201/2 89.290724984)
    ("n5-949" 201/2 91.615475488)
    ("n5-950" 201/2 93.940218816)
    ("n5-951" 201/2 96.264954966)
    ("n1-1163" 201/2 99.949700018)
    ("n1-1164" 201/2 99.949700018)
    ("n1-1165" 201/2 101.136262712)
    ("n1-1166" 201/2 109.312694687)
    ("n1-1167" 201/2 109.312694687)
    ("n1-1168" 201/2 123.682985074)
    ("n1-1169" 201/2 123.682985074)
    ("n2-140" 201/2 109.276600133)
    ("n5-952" 201/2 99.949700018)
    ("n5-953" 201/2 102.290448685)
    ("n5-954" 201/2 104.631197353)
    ("n5-955" 201/2 106.971946020)
    ("n5-956" 201/2 109.312694687)
    ("n5-957" 201/2 111.653436177)
    ("n5-958" 201/2 114.320004759)
    ("n5-959" 201/2 116.660746249)
    ("n5-960" 201/2 119.001502094)
    ("n5-961" 201/2 121.342229229)
    ("n5-962" 201/2 123.682985074)
    ("n5-963" 201/2 126.023726564)
    ("n1-1170" 207/2 10.877813967)
    ("n1-1171" 207/2 15.494378427)
    ("n1-1172" 207/2 20.110941092)
    ("n1-1173" 207/2 24.727505552)
    ("n1-1174" 207/2 33.960634472)
    ("n2-141" 207/2 10.877813967)
    ("n2-142" 207/2 10.877813967)
    ("n2-143" 207/2 24.727505552)
    ("n2-144" 207/2 24.727505552)
    ("n5-964" 207/2 10.877813967)
    ("n5-965" 207/2 13.186094403)
    ("n5-966" 207/2 15.494378427)
    ("n5-967" 207/2 17.802660657)
    ("n5-968" 207/2 20.110941092)
    ("n5-969" 207/2 22.419223322)
    ("n5-970" 207/2 24.727505552)
    ("n5-971" 207/2 27.035787782)
    ("n5-972" 207/2 29.344070012)
    ("n5-973" 207/2 31.652352242)
    ("n5-974" 207/2 33.960634472)
    ("n5-975" 207/2 36.268916702)
    ("n1-1175" 207/2 39.945479652)
    ("n1-1176" 207/2 39.945479652)
    ("n1-1177" 207/2 39.945479652)
    ("n1-1178" 207/2 49.618364258)
    ("n1-1179" 207/2 49.618364258)
    ("n1-1180" 207/2 54.454808355)
    ("n1-1181" 207/2 54.454808355)
    ("n1-1182" 207/2 59.291256041)
    ("n1-1183" 207/2 59.291256041)
    ("n1-1184" 207/2 64.127703727)
    ("n1-1185" 207/2 64.127703727)
    ("n2-145" 207/2 54.884813703)
    ("n5-976" 207/2 39.945479652)
    ("n5-977" 207/2 42.363699906)
    ("n5-978" 207/2 44.781923749)
    ("n5-979" 207/2 47.200144004)
    ("n5-980" 207/2 49.618364258)
    ("n5-981" 207/2 52.036588101)
    ("n5-982" 207/2 54.454808355)
    ("n5-983" 207/2 56.873028609)
    ("n5-984" 207/2 59.291256041)
    ("n5-985" 207/2 61.709483472)
    ("n5-986" 207/2 64.127703727)
    ("n5-987" 207/2 66.545923981)
    ("n1-1186" 207/2 70.324145961)
    ("n1-1187" 207/2 70.324145961)
    ("n1-1188" 207/2 71.510708655)
    ("n1-1189" 207/2 74.861250726)
    ("n1-1190" 207/2 74.861250726)
    ("n1-1191" 207/2 79.398362669)
    ("n1-1192" 207/2 79.398362669)
    ("n1-1193" 207/2 83.935474611)
    ("n1-1194" 207/2 83.935474611)
    ("n1-1195" 207/2 88.472586554)
    ("n1-1196" 207/2 88.472586554)
    ("n1-1197" 207/2 93.009698497)
    ("n1-1198" 207/2 93.009698497)
    ("n2-146" 207/2 84.365472782)
    ("n5-988" 207/2 70.324145961)
    ("n5-989" 207/2 72.592698343)
    ("n5-990" 207/2 74.861250726)
    ("n5-991" 207/2 77.129810286)
    ("n5-992" 207/2 79.398362669)
    ("n5-993" 207/2 81.666922229)
    ("n5-994" 207/2 83.935474611)
    ("n5-995" 207/2 86.204026994)
    ("n5-996" 207/2 88.472586554)
    ("n5-997" 207/2 90.741131759)
    ("n5-998" 207/2 93.009698497)
    ("n5-999" 207/2 95.278243702)
    ("n1-1199" 207/2 98.954806653)
    ("n1-1200" 207/2 98.954806653)
    ("n1-1201" 207/2 100.141376524)
    ("n1-1202" 207/2 103.817193037)
    ("n1-1203" 207/2 103.817193037)
    ("n1-1204" 207/2 113.777330431)
    ("n1-1205" 207/2 113.777330431)
    ("n1-1206" 207/2 123.502103201)
    ("n1-1207" 207/2 123.502103201)
    ("n2-147" 207/2 103.817193037)
    ("n2-148" 207/2 113.777330431)
    ("n5-1000" 207/2 98.954806653)
    ("n5-1001" 207/2 101.385996256)
    ("n5-1002" 207/2 103.817193037)
    ("n5-1003" 207/2 106.248382641)
    ("n5-1004" 207/2 108.679572245)
    ("n5-1005" 207/2 111.110769026)
    ("n5-1006" 207/2 113.777330431)
    ("n5-1007" 207/2 116.208520035)
    ("n5-1008" 207/2 118.639709639)
    ("n5-1009" 207/2 121.070913597)
    ("n5-1010" 207/2 123.502103201)
    ("n5-1011" 207/2 125.933278450)
    ("n1-1208" 213/2 10.877813967)
    ("n1-1209" 213/2 12.722063353)
    ("n1-1210" 213/2 17.737586031)
    ("n1-1211" 213/2 22.753110503)
    ("n1-1212" 213/2 27.768634976)
    ("n1-1213" 213/2 27.768634976)
    ("n1-1214" 213/2 27.768634976)
    ("n1-1215" 213/2 37.799680332)
    ("n1-1216" 213/2 38.986243026)
    ("n2-149" 213/2 12.722063353)
    ("n2-150" 213/2 12.722063353)
    ("n5-1012" 213/2 12.722063353)
    ("n5-1013" 213/2 15.229823795)
    ("n5-1014" 213/2 17.737586031)
    ("n5-1015" 213/2 20.245348267)
    ("n5-1016" 213/2 22.753110503)
    ("n5-1017" 213/2 25.260874534)
    ("n5-1018" 213/2 37.799680332)
    ("n6-72" 213/2 27.768634976)
    ("n6-73" 213/2 30.276395418)
    ("n6-74" 213/2 32.784159448)
    ("n6-75" 213/2 35.291919890)
    ("n6-76" 213/2 37.799680332)
    ("n6-77" 213/2 40.327185478)
    ("n1-1217" 213/2 44.574941688)
    ("n1-1218" 213/2 44.574941688)
    ("n1-1219" 213/2 50.823081888)
    ("n1-1220" 213/2 53.947151988)
    ("n1-1221" 213/2 60.195285010)
    ("n5-1019" 213/2 44.574941688)
    ("n5-1020" 213/2 44.574941688)
    ("n6-78" 213/2 44.574941688)
    ("n1-1222" 213/2 64.679356835)
    ("n1-1223" 213/2 70.608969238)
    ("n1-1224" 213/2 73.573768263)
    ("n1-1225" 213/2 79.503380666)
    ("n1-1226" 213/2 84.208189814)
    ("n1-1227" 213/2 91.083071851)
    ("n1-1228" 213/2 91.083071851)
    ("n1-1229" 213/2 94.520516459)
    ("n1-1230" 213/2 101.395405674)
    ("n1-1231" 213/2 101.395405674)
    ("n5-1021" 213/2 84.208189814)
    ("n5-1022" 213/2 91.083071851)
    ("n5-1023" 213/2 91.083071851)
    ("n5-1024" 213/2 91.083071851)
    ("n5-1025" 213/2 94.520516459)
    ("n5-1026" 213/2 101.395405674)
    ("n5-1027" 213/2 101.395405674)
    ("n5-1028" 213/2 101.395405674)
    ("n1-1232" 213/2 106.192844829)
    ("n1-1233" 213/2 113.242795141)
    ("n1-1234" 213/2 113.242795141)
    ("n1-1235" 213/2 115.945300377)
    ("n1-1236" 213/2 117.789546174)
    ("n1-1237" 213/2 117.789546174)
    ("n1-1238" 213/2 121.314524919)
    ("n1-1239" 213/2 121.314524919)
    ("n1-1240" 213/2 124.839503663)
    ("n1-1241" 213/2 124.839503663)
    ("n5-1029" 213/2 106.192844829)
    ("n5-1030" 213/2 113.242795141)
    ("n5-1031" 213/2 113.242795141)
    ("n5-1032" 213/2 117.789546174)
    ("n5-1033" 213/2 124.839503663)
    ("n5-1034" 213/2 124.839503663)
    ("n1-1242" 441/4 11.257810879)
    ("n1-1243" 441/4 12.444373308)
    ("n1-1244" 441/4 18.099979128)
    ("n1-1245" 441/4 18.099979128)
    ("n1-1246" 441/4 21.521064150)
    ("n1-1247" 441/4 28.363234194)
    ("n1-1248" 441/4 28.363234194)
    ("n5-1035" 441/4 11.257810879)
    ("n5-1036" 441/4 18.099979128)
    ("n5-1037" 441/4 18.099979128)
    ("n5-1038" 441/4 21.521064150)
    ("n5-1039" 441/4 28.363234194)
    ("n5-1040" 441/4 28.363234194)
    ("n1-1249" 441/4 33.524319980)
    ("n1-1250" 441/4 41.791668333)
    ("n1-1251" 441/4 41.791668333)
    ("n1-1252" 441/4 44.494165788)
    ("n1-1253" 441/4 46.338418350)
    ("n1-1254" 441/4 46.338418350)
    ("n1-1255" 441/4 50.472094321)
    ("n1-1256" 441/4 50.472094321)
    ("n1-1257" 441/4 54.605770292)
    ("n1-1258" 441/4 54.605770292)
    ("n5-1041" 441/4 33.524319980)
    ("n5-1042" 441/4 41.791668333)
    ("n5-1043" 441/4 41.791668333)
    ("n5-1044" 441/4 46.338418350)
    ("n6-79" 441/4 46.338418350)
    ("n6-80" 441/4 50.472094321)
    ("n6-81" 441/4 54.605770292)
    ("n7-7" 441/4 46.338418350)
    ("n1-1259" 441/4 60.479448820)
    ("n1-1260" 441/4 60.479448820)
    ("n1-1261" 441/4 67.413857689)
    ("n1-1262" 441/4 67.413857689)
    ("n1-1263" 441/4 70.881058535)
    ("n1-1264" 441/4 77.815467404)
    ("n1-1265" 441/4 77.815467404)
    ("n5-1045" 441/4 60.479448820)
    ("n5-1046" 441/4 60.479448820)
    ("n5-1047" 441/4 67.413857689)
    ("n5-1048" 441/4 67.413857689)
    ("n5-1049" 441/4 70.881058535)
    ("n5-1050" 441/4 77.815467404)
    ("n5-1051" 441/4 77.815467404)
    ("n6-82" 441/4 60.479448820)
    ("n1-1266" 441/4 82.642669672)
    ("n1-1267" 441/4 89.764053885)
    ("n1-1268" 441/4 89.764053885)
    ("n1-1269" 441/4 92.466544163)
    ("n1-1270" 441/4 94.310796725)
    ("n1-1271" 441/4 94.310796725)
    ("n1-1272" 441/4 97.871481654)
    ("n1-1273" 441/4 97.871481654)
    ("n1-1274" 441/4 101.432173761)
    ("n1-1275" 441/4 101.432173761)
    ("n5-1052" 441/4 82.642669672)
    ("n5-1053" 441/4 89.764053885)
    ("n5-1054" 441/4 89.764053885)
    ("n5-1055" 441/4 94.310796725)
    ("n5-1056" 441/4 101.432173761)
    ("n5-1057" 441/4 101.432173761)
    ("n1-1276" 441/4 106.732868425)
    ("n1-1277" 441/4 107.919423677)
    ("n1-1278" 441/4 113.943387290)
    ("n1-1279" 441/4 113.943387290)
    ("n1-1280" 441/4 117.548664665)
    ("n1-1281" 441/4 124.759190707)
    ("n1-1282" 441/4 124.759190707)
    ("n5-1058" 441/4 106.732868425)
    ("n5-1059" 441/4 113.943387290)
    ("n5-1060" 441/4 113.943387290)
    ("n5-1061" 441/4 117.548664665)
    ("n5-1062" 441/4 124.759190707)
    ("n5-1063" 441/4 124.759190707)
    ("n1-1283" 114 11.257813394)
    ("n1-1284" 114 17.866805825)
    ("n1-1285" 114 17.866805825)
    ("n1-1286" 114 20.569305678)
    ("n1-1287" 114 22.413553269)
    ("n1-1288" 114 22.413553269)
    ("n1-1289" 114 26.103243469)
    ("n1-1290" 114 26.103243469)
    ("n1-1291" 114 29.407739685)
    ("n1-1292" 114 29.407739685)
    ("n5-1064" 114 11.257813394)
    ("n5-1065" 114 17.866805825)
    ("n5-1066" 114 17.866805825)
    ("n5-1067" 114 22.413553269)
    ("n6-83" 114 22.413553269)
    ("n6-84" 114 26.103243469)
    ("n6-85" 114 29.407739685)
    ("n7-8" 114 22.413553269)
    ("n1-1293" 114 34.452235258)
    ("n1-1294" 114 34.452235258)
    ("n1-1295" 114 41.061224100)
    ("n1-1296" 114 41.061224100)
    ("n1-1297" 114 43.763725748)
    ("n1-1298" 114 45.607975133)
    ("n1-1299" 114 45.607975133)
    ("n1-1300" 114 49.297661745)
    ("n1-1301" 114 49.297661745)
    ("n1-1302" 114 52.602157960)
    ("n1-1303" 114 52.602157960)
    ("n5-1068" 114 34.452235258)
    ("n5-1069" 114 34.452235258)
    ("n5-1070" 114 41.061224100)
    ("n5-1071" 114 41.061224100)
    ("n5-1072" 114 45.607975133)
    ("n6-86" 114 34.452235258)
    ("n6-87" 114 45.607975133)
    ("n6-88" 114 49.297661745)
    ("n6-89" 114 52.602157960)
    ("n7-9" 114 45.607975133)
    ("n1-1304" 114 57.646653533)
    ("n1-1305" 114 57.646653533)
    ("n1-1306" 114 62.841857684)
    ("n1-1307" 114 70.634663910)
    ("n2-151" 114 62.841857684)
    ("n2-152" 114 65.439459759)
    ("n2-153" 114 70.634663910)
    ("n5-1073" 114 57.646653533)
    ("n5-1074" 114 62.841857684)
    ("n5-1075" 114 62.841857684)
    ("n5-1076" 114 65.439459759)
    ("n5-1077" 114 70.634663910)
    ("n5-1078" 114 70.634663910)
    ("n1-1308" 114 75.012267927)
    ("n1-1309" 114 79.820516070)
    ("n1-1310" 114 87.032881107)
    ("n2-154" 114 75.012267927)
    ("n2-155" 114 79.820516070)
    ("n2-156" 114 82.224632964)
    ("n2-157" 114 87.032881107)
    ("n5-1079" 114 75.012267927)
    ("n5-1080" 114 79.820516070)
    ("n5-1081" 114 79.820516070)
    ("n5-1082" 114 82.224632964)
    ("n5-1083" 114 87.032881107)
    ("n1-1311" 114 96.793504402)
    ("n1-1312" 114 106.499142536)
    ("n1-1313" 114 111.874144790)
    ("n1-1314" 114 122.989472977)
    ("n5-1084" 114 96.793504402)
    ("n5-1085" 114 101.124125928)
    ("n5-1086" 114 103.811630643)
    ("n5-1087" 114 106.499142536)
    ("n5-1088" 114 109.186632897)
    ("n5-1089" 114 111.874144790)
    ("n5-1090" 114 114.561649506)
    ("n5-1091" 114 117.249154222)
    ("n5-1092" 114 119.936658937)
    ("n5-1093" 114 122.989472977)
    ("n5-1094" 114 125.676977692)
    ("n6-90" 114 96.793504402)
    ("n6-91" 114 106.499142536)
    ("n6-92" 114 106.499142536)
    ("n6-93" 114 111.874144790)
    ("n6-94" 114 111.874144790)
    ("n6-95" 114 122.989472977)
    ("n6-96" 114 122.989472977)
    ("n1-1315" 471/4 11.341251097)
    ("n1-1316" 471/4 17.712452982)
    ("n1-1317" 471/4 24.083653073)
    ("n1-1318" 471/4 30.454854958)
    ("n1-1319" 471/4 36.826056843)
    ("n1-1320" 471/4 43.197258728)
    ("n5-1095" 471/4 11.341251097)
    ("n5-1096" 471/4 14.526852040)
    ("n5-1097" 471/4 17.712452982)
    ("n5-1098" 471/4 20.898053925)
    ("n5-1099" 471/4 24.083653073)
    ("n5-1100" 471/4 27.269254015)
    ("n5-1101" 471/4 30.454854958)
    ("n5-1102" 471/4 33.640455900)
    ("n5-1103" 471/4 36.826056843)
    ("n5-1104" 471/4 40.011657785)
    ("n5-1105" 471/4 43.197258728)
    ("n5-1106" 471/4 46.382859670)
    ("n6-97" 471/4 11.341251097)
    ("n6-98" 471/4 11.341251097)
    ("n6-99" 471/4 17.712452982)
    ("n6-100" 471/4 17.712452982)
    ("n6-101" 471/4 24.083653073)
    ("n6-102" 471/4 24.083653073)
    ("n6-103" 471/4 30.454854958)
    ("n6-104" 471/4 30.454854958)
    ("n6-105" 471/4 36.826056843)
    ("n6-106" 471/4 43.197258728)
    ("n1-1321" 471/4 51.308459970)
    ("n1-1322" 471/4 64.099231447)
    ("n1-1323" 471/4 71.205207626)
    ("n1-1324" 471/4 85.417174338)
    ("n5-1107" 471/4 51.308459970)
    ("n5-1108" 471/4 51.308459970)
    ("n5-1109" 471/4 56.993248091)
    ("n5-1110" 471/4 60.546239769)
    ("n5-1111" 471/4 64.099231447)
    ("n5-1112" 471/4 67.652215948)
    ("n5-1113" 471/4 71.205207626)
    ("n5-1114" 471/4 74.758199304)
    ("n5-1115" 471/4 78.311198159)
    ("n5-1116" 471/4 81.864182660)
    ("n5-1117" 471/4 85.417174338)
    ("n5-1118" 471/4 88.970158839)
    ("n6-107" 471/4 51.308459970)
    ("n6-108" 471/4 51.308459970)
    ("n6-109" 471/4 64.099231447)
    ("n6-110" 471/4 71.205207626)
    ("n6-111" 471/4 85.417174338)
    ("n1-1325" 471/4 94.406282831)
    ("n1-1326" 471/4 100.661679263)
    ("n1-1327" 471/4 106.433097183)
    ("n1-1328" 471/4 112.204500748)
    ("n1-1329" 471/4 116.821646568)
    ("n1-1330" 471/4 122.593071665)
    ("n5-1119" 471/4 94.406282831)
    ("n5-1120" 471/4 97.291995379)
    ("n5-1121" 471/4 100.661679263)
    ("n5-1122" 471/4 103.547384634)
    ("n5-1123" 471/4 106.433097183)
    ("n5-1124" 471/4 109.318802554)
    ("n5-1125" 471/4 112.204500748)
    ("n5-1126" 471/4 116.821646568)
    ("n5-1127" 471/4 119.707344762)
    ("n5-1128" 471/4 122.593071665)
    ("n5-1129" 471/4 125.478769859)
    ("n6-112" 471/4 94.406282831)
    ("n6-113" 471/4 100.661679263)
    ("n6-114" 471/4 105.246527311)
    ("n6-115" 471/4 106.433097183)
    ("n6-116" 471/4 112.204500748)
    ("n6-117" 471/4 111.017945231)
    ("n6-118" 471/4 116.821646568)
    ("n6-119" 471/4 121.406494616)
    ("n6-120" 471/4 122.593071665)
    ("n6-121" 471/4 122.593071665)
    ("n1-1331" 120 11.341251097)
    ("n1-1332" 120 18.665097274)
    ("n1-1333" 120 31.889920292)
    ("n5-1130" 120 11.341251097)
    ("n5-1131" 120 14.596292248)
    ("n5-1132" 120 16.630696555)
    ("n5-1133" 120 18.665097274)
    ("n5-1134" 120 20.699501582)
    ("n5-1135" 120 22.733900507)
    ("n5-1136" 120 24.768301226)
    ("n5-1137" 120 27.821115265)
    ("n5-1138" 120 29.855515984)
    ("n5-1139" 120 31.889920292)
    ("n5-1140" 120 33.924321011)
    ("n6-122" 120 11.341251097)
    ("n6-123" 120 11.341251097)
    ("n6-124" 120 11.341251097)
    ("n6-125" 120 18.665097274)
    ("n6-126" 120 18.665097274)
    ("n6-127" 120 17.478534580)
    ("n6-128" 120 31.889920292)
    ("n6-129" 120 31.889920292)
    ("n6-130" 120 31.889920292)
    ("n1-1334" 120 38.124010961)
    ("n1-1335" 120 46.685985019)
    ("n1-1336" 120 50.966972047)
    ("n1-1337" 120 56.160274218)
    ("n1-1338" 120 60.441264835)
    ("n5-1141" 120 38.124010961)
    ("n5-1142" 120 40.264499092)
    ("n5-1143" 120 42.404994401)
    ("n5-1144" 120 44.545489710)
    ("n5-1145" 120 46.685985019)
    ("n5-1146" 120 48.826476739)
    ("n5-1147" 120 50.966972047)
    ("n5-1148" 120 53.107467356)
    ("n5-1149" 120 56.160274218)
    ("n5-1150" 120 58.300769527)
    ("n5-1151" 120 60.441264835)
    ("n5-1152" 120 62.767824015)
    ("n6-131" 120 38.124010961)
    ("n6-132" 120 38.124010961)
    ("n6-133" 120 38.124010961)
    ("n6-134" 120 46.685985019)
    ("n6-135" 120 46.685985019)
    ("n6-136" 120 50.966972047)
    ("n6-137" 120 50.966972047)
    ("n6-138" 120 56.160274218)
    ("n6-139" 120 56.160274218)
    ("n6-140" 120 60.441264835)
    ("n1-1339" 120 66.967517554)
    ("n1-1340" 120 73.324537129)
    ("n1-1341" 120 78.772955805)
    ("n1-1342" 120 84.221367304)
    ("n1-1343" 120 95.924615408)
    ("n5-1153" 120 66.967517554)
    ("n5-1154" 120 69.691719715)
    ("n5-1155" 120 73.324537129)
    ("n5-1156" 120 76.048746467)
    ("n5-1157" 120 78.772955805)
    ("n5-1158" 120 81.497157966)
    ("n5-1159" 120 84.221367304)
    ("n5-1160" 120 86.945576643)
    ("n5-1161" 120 89.669778804)
    ("n5-1162" 120 92.393988142)
    ("n5-1163" 120 95.924615408)
    ("n5-1164" 120 98.648824746)
    ("n6-141" 120 66.967517554)
    ("n6-142" 120 77.586385934)
    ("n6-143" 120 84.221367304)
    ("n6-144" 120 95.924615408)
    ("n6-145" 120 95.924615408)
    ("n1-1344" 120 103.256159220)
    ("n1-1345" 120 111.583859600)
    ("n1-1346" 120 116.471050673)
    ("n1-1347" 120 123.965985322)
    ("n5-1165" 120 103.256159220)
    ("n5-1166" 120 105.338087904)
    ("n5-1167" 120 107.420016588)
    ("n5-1168" 120 109.501930917)
    ("n5-1169" 120 111.583859600)
    ("n5-1170" 120 114.027458726)
    ("n5-1171" 120 116.471050673)
    ("n5-1172" 120 119.802142309)
    ("n5-1173" 120 121.884070993)
    ("n5-1174" 120 123.965985322)
    ("n5-1175" 120 126.047914005)
    ("n6-146" 120 103.256159220)
    ("n6-147" 120 103.256159220)
    ("n6-148" 120 111.583859600)
    ("n6-149" 120 111.583859600)
    ("n6-150" 120 111.583859600)
    ("n6-151" 120 116.471050673)
    ("n6-152" 120 115.284487979)
    ("n6-153" 120 116.471050673)
    ("n6-154" 120 122.779422628)
    ("n6-155" 120 123.965985322)
    ("n6-156" 120 123.965985322)
    ("n6-157" 120 123.965985322)
    ("n1-1348" 123 10.961249876)
    ("n1-1349" 123 13.295418770)
    ("n1-1350" 123 15.629589457)
    ("n1-1351" 123 17.963756556)
    ("n1-1352" 123 20.297925450)
    ("n1-1353" 123 22.632094343)
    ("n1-1354" 123 24.966265031)
    ("n1-1355" 123 27.300432130)
    ("n1-1356" 123 29.634599229)
    ("n1-1357" 123 31.968769917)
    ("n1-1358" 123 34.302937016)
    ("n1-1359" 123 36.637107704)
    ("n5-1176" 123 10.961249876)
    ("n5-1177" 123 19.111362756)
    ("n5-1178" 123 20.297925450)
    ("n5-1179" 123 20.297925450)
    ("n5-1180" 123 23.779702337)
    ("n5-1181" 123 24.966265031)
    ("n5-1182" 123 24.966265031)
    ("n5-1183" 123 34.302937016)
    ("n5-1184" 123 34.302937016)
    ("n5-1185" 123 34.302937016)
    ("n1-1360" 123 40.711277750)
    ("n1-1361" 123 43.045444849)
    ("n1-1362" 123 45.379611948)
    ("n1-1363" 123 47.713786224)
    ("n1-1364" 123 50.047953323)
    ("n1-1365" 123 52.382116834)
    ("n1-1366" 123 54.716283933)
    ("n1-1367" 123 57.050458209)
    ("n1-1368" 123 59.384625309)
    ("n1-1369" 123 61.718792408)
    ("n1-1370" 123 64.052966684)
    ("n1-1371" 123 66.387133783)
    ("n5-1186" 123 40.711277750)
    ("n5-1187" 123 40.711277750)
    ("n5-1188" 123 40.711277750)
    ("n5-1189" 123 50.047953323)
    ("n5-1190" 123 50.047953323)
    ("n5-1191" 123 50.047953323)
    ("n5-1192" 123 54.716283933)
    ("n5-1193" 123 59.384625309)
    ("n5-1194" 123 64.052966684)
    ("n6-158" 123 54.716283933)
    ("n1-1372" 123 70.604426019)
    ("n1-1373" 123 72.938600295)
    ("n1-1374" 123 75.272767394)
    ("n1-1375" 123 77.606934493)
    ("n1-1376" 123 79.941101593)
    ("n1-1377" 123 82.275268692)
    ("n1-1378" 123 84.609435791)
    ("n1-1379" 123 86.943602890)
    ("n1-1380" 123 89.277769989)
    ("n1-1381" 123 91.611937088)
    ("n1-1382" 123 93.946118542)
    ("n1-1383" 123 96.280285641)
    ("n5-1195" 123 70.604426019)
    ("n5-1196" 123 70.604426019)
    ("n5-1197" 123 70.604426019)
    ("n5-1198" 123 78.754538898)
    ("n5-1199" 123 79.941101593)
    ("n5-1200" 123 79.941101593)
    ("n5-1201" 123 83.422880274)
    ("n5-1202" 123 84.609435791)
    ("n5-1203" 123 84.609435791)
    ("n5-1204" 123 93.946118542)
    ("n5-1205" 123 93.946118542)
    ("n5-1206" 123 93.946118542)
    ("n1-1384" 123 100.354455686)
    ("n1-1385" 123 102.688622786)
    ("n1-1386" 123 105.022789885)
    ("n1-1387" 123 107.356956984)
    ("n1-1388" 123 109.691124083)
    ("n1-1389" 123 112.025298359)
    ("n1-1390" 123 114.359465459)
    ("n1-1391" 123 116.693632558)
    ("n1-1392" 123 119.027799657)
    ("n1-1393" 123 121.361966756)
    ("n1-1394" 123 123.696133855)
    ("n1-1395" 123 126.030300954)
    ("n5-1207" 123 100.354455686)
    ("n5-1208" 123 100.354455686)
    ("n5-1209" 123 100.354455686)
    ("n5-1210" 123 109.691124083)
    ("n5-1211" 123 109.691124083)
    ("n5-1212" 123 109.691124083)
    ("n5-1213" 123 114.359465459)
    ("n5-1214" 123 119.027799657)
    ("n5-1215" 123 123.696133855)
    ("n6-159" 123 114.359465459)
    ("n1-1396" 126 11.341248563)
    ("n1-1397" 126 13.694232177)
    ("n1-1398" 126 16.047213996)
    ("n1-1399" 126 18.400197610)
    ("n1-1400" 126 20.753183018)
    ("n1-1401" 126 23.106166632)
    ("n1-1402" 126 25.459148451)
    ("n1-1403" 126 27.812130271)
    ("n1-1404" 126 30.165115679)
    ("n1-1405" 126 32.518097498)
    ("n1-1406" 126 34.871079318)
    ("n1-1407" 126 37.224064726)
    ("n5-1216" 126 11.341248563)
    ("n5-1217" 126 11.341248563)
    ("n5-1218" 126 20.753183018)
    ("n5-1219" 126 20.753183018)
    ("n5-1220" 126 20.753183018)
    ("n5-1221" 126 25.459148451)
    ("n5-1222" 126 25.459148451)
    ("n5-1223" 126 25.459148451)
    ("n5-1224" 126 34.871079318)
    ("n5-1225" 126 34.871079318)
    ("n5-1226" 126 34.871079318)
    ("n1-1408" 126 40.937047967)
    ("n1-1409" 126 43.290029786)
    ("n1-1410" 126 45.643015194)
    ("n1-1411" 126 47.995997014)
    ("n1-1412" 126 50.348978833)
    ("n1-1413" 126 52.701967830)
    ("n1-1414" 126 55.054953238)
    ("n1-1415" 126 57.407931469)
    ("n1-1416" 126 59.760916877)
    ("n1-1417" 126 62.113895108)
    ("n1-1418" 126 64.466880516)
    ("n1-1419" 126 66.819865924)
    ("n5-1227" 126 40.937047967)
    ("n5-1228" 126 40.937047967)
    ("n5-1229" 126 40.937047967)
    ("n5-1230" 126 50.348978833)
    ("n5-1231" 126 50.348978833)
    ("n5-1232" 126 50.348978833)
    ("n5-1233" 126 55.054953238)
    ("n5-1234" 126 55.054953238)
    ("n5-1235" 126 55.054953238)
    ("n5-1236" 126 64.466880516)
    ("n5-1237" 126 64.466880516)
    ("n5-1238" 126 64.466880516)
    ("n1-1420" 126 70.532845576)
    ("n1-1421" 126 72.885830984)
    ("n1-1422" 126 75.238816392)
    ("n1-1423" 126 77.591794623)
    ("n1-1424" 126 79.944780031)
    ("n1-1425" 126 82.297765439)
    ("n1-1426" 126 84.650750847)
    ("n1-1427" 126 87.003729078)
    ("n1-1428" 126 89.356714486)
    ("n1-1429" 126 91.709699894)
    ("n1-1430" 126 94.062678125)
    ("n1-1431" 126 96.415670711)
    ("n5-1239" 126 70.532845576)
    ("n5-1240" 126 79.944780031)
    ("n5-1241" 126 78.758217602)
    ("n5-1242" 126 79.944780031)
    ("n5-1243" 126 84.650750847)
    ("n5-1244" 126 94.062678125)
    ("n5-1245" 126 94.062678125)
    ("n5-1246" 126 94.062678125)
    ("n1-1432" 126 100.128650363)
    ("n1-1433" 126 102.481628594)
    ("n1-1434" 126 104.834621179)
    ("n1-1435" 126 107.187592233)
    ("n1-1436" 126 109.540584818)
    ("n1-1437" 126 111.893555871)
    ("n1-1438" 126 114.246555634)
    ("n1-1439" 126 116.599541042)
    ("n1-1440" 126 118.952512096)
    ("n1-1441" 126 121.305497504)
    ("n1-1442" 126 123.658482912)
    ("n1-1443" 126 126.011468320)
    ("n5-1247" 126 100.128650363)
    ("n5-1248" 126 108.354022389)
    ("n5-1249" 126 109.540584818)
    ("n5-1250" 126 109.540584818)
    ("n5-1251" 126 109.540584818)
    ("n5-1252" 126 114.246555634)
    ("n5-1253" 126 114.246555634)
    ("n5-1254" 126 122.471920483)
    ("n5-1255" 126 123.658482912)
    ("n5-1256" 126 123.658482912)
    ("n5-1257" 126 123.658482912)
    ("n1-1444" 129 11.341251097)
    ("n1-1445" 129 11.341251097)
    ("n1-1446" 129 11.341251097)
    ("n1-1447" 129 13.524817278)
    ("n1-1448" 129 15.708383459)
    ("n1-1449" 129 15.708383459)
    ("n1-1450" 129 15.708383459)
    ("n1-1451" 129 17.891951434)
    ("n1-1452" 129 20.075519409)
    ("n1-1453" 129 20.075519409)
    ("n1-1454" 129 20.075519409)
    ("n1-1455" 129 22.259083796)
    ("n1-1456" 129 24.442653565)
    ("n1-1457" 129 24.442653565)
    ("n1-1458" 129 24.442653565)
    ("n1-1459" 129 26.626219746)
    ("n1-1460" 129 28.809785927)
    ("n1-1461" 129 28.809785927)
    ("n1-1462" 129 28.809785927)
    ("n1-1463" 129 31.101065174)
    ("n1-1464" 129 34.664632578)
    ("n1-1465" 129 34.664632578)
    ("n1-1466" 129 37.592540371)
    ("n5-1258" 129 11.341251097)
    ("n5-1259" 129 11.341251097)
    ("n5-1260" 129 20.075519409)
    ("n5-1261" 129 20.075519409)
    ("n5-1262" 129 20.075519409)
    ("n5-1263" 129 24.442653565)
    ("n5-1264" 129 24.442653565)
    ("n5-1265" 129 34.664632578)
    ("n5-1266" 129 34.664632578)
    ("n5-1267" 129 34.664632578)
    ("n5-1268" 129 34.664632578)
    ("n1-1467" 129 42.016107705)
    ("n1-1468" 129 42.016107705)
    ("n1-1469" 129 44.183618304)
    ("n1-1470" 129 46.351128904)
    ("n1-1471" 129 46.351128904)
    ("n1-1472" 129 48.642411741)
    ("n1-1473" 129 52.189923564)
    ("n1-1474" 129 52.189923564)
    ("n1-1475" 129 55.117831356)
    ("n1-1476" 129 58.285345547)
    ("n1-1477" 129 58.285345547)
    ("n1-1478" 129 60.452856147)
    ("n1-1479" 129 62.620366747)
    ("n1-1480" 129 62.620366747)
    ("n1-1481" 129 64.787877346)
    ("n1-1482" 129 66.955387946)
    ("n1-1483" 129 66.955387946)
    ("n1-1484" 129 69.122898546)
    ("n5-1269" 129 42.016107705)
    ("n5-1270" 129 42.016107705)
    ("n5-1271" 129 52.189923564)
    ("n5-1272" 129 52.189923564)
    ("n5-1273" 129 52.189923564)
    ("n5-1274" 129 52.189923564)
    ("n5-1275" 129 58.285345547)
    ("n5-1276" 129 58.285345547)
    ("n5-1277" 129 66.955387946)
    ("n5-1278" 129 66.955387946)
    ("n5-1279" 129 66.955387946)
    ("n5-1280" 129 66.955387946)
    ("n1-1485" 129 73.179462718)
    ("n1-1486" 129 73.179462718)
    ("n1-1487" 129 73.179462718)
    ("n1-1488" 129 75.437909487)
    ("n1-1489" 129 77.696363433)
    ("n1-1490" 129 77.696363433)
    ("n1-1491" 129 77.696363433)
    ("n1-1492" 129 79.954810202)
    ("n1-1493" 129 82.213256971)
    ("n1-1494" 129 82.213256971)
    ("n1-1495" 129 84.471710917)
    ("n1-1496" 129 86.730157686)
    ("n1-1497" 129 86.730157686)
    ("n1-1498" 129 88.988611632)
    ("n1-1499" 129 91.247058401)
    ("n1-1500" 129 91.247058401)
    ("n1-1501" 129 93.505512348)
    ("n1-1502" 129 95.763959117)
    ("n1-1503" 129 95.763959117)
    ("n1-1504" 129 98.022413063)
    ("n5-1281" 129 73.179462718)
    ("n5-1282" 129 73.179462718)
    ("n5-1283" 129 82.213256971)
    ("n5-1284" 129 82.213256971)
    ("n5-1285" 129 82.213256971)
    ("n5-1286" 129 82.213256971)
    ("n5-1287" 129 86.730157686)
    ("n5-1288" 129 86.730157686)
    ("n5-1289" 129 95.763959117)
    ("n5-1290" 129 95.763959117)
    ("n5-1291" 129 95.763959117)
    ("n5-1292" 129 95.763959117)
    ("n1-1505" 129 102.078970057)
    ("n1-1506" 129 102.078970057)
    ("n1-1507" 129 104.257964309)
    ("n1-1508" 129 106.436958561)
    ("n1-1509" 129 106.436958561)
    ("n1-1510" 129 108.615952813)
    ("n1-1511" 129 110.794947065)
    ("n1-1512" 129 110.794947065)
    ("n1-1513" 129 112.973948494)
    ("n1-1514" 129 115.152942746)
    ("n1-1515" 129 115.152942746)
    ("n1-1516" 129 117.331936998)
    ("n1-1517" 129 119.510931250)
    ("n1-1518" 129 119.510931250)
    ("n1-1519" 129 121.689925502)
    ("n1-1520" 129 123.868919754)
    ("n1-1521" 129 123.868919754)
    ("n1-1522" 129 126.047914005)
    ("n5-1293" 129 102.078970057)
    ("n5-1294" 129 102.078970057)
    ("n5-1295" 129 110.794947065)
    ("n5-1296" 129 110.794947065)
    ("n5-1297" 129 110.794947065)
    ("n5-1298" 129 115.152942746)
    ("n5-1299" 129 115.152942746)
    ("n5-1300" 129 123.868919754)
    ("n5-1301" 129 123.868919754)
    ("n5-1302" 129 123.868919754)
    ("n1-1523" 132 11.341251097)
    ("n1-1524" 132 11.341251097)
    ("n1-1525" 132 11.341251097)
    ("n1-1526" 132 14.226240534)
    ("n1-1527" 132 17.111229972)
    ("n1-1528" 132 17.111229972)
    ("n1-1529" 132 17.111229972)
    ("n1-1530" 132 19.996221204)
    ("n1-1531" 132 22.881210641)
    ("n1-1532" 132 22.881210641)
    ("n1-1533" 132 22.881210641)
    ("n1-1534" 132 25.766201873)
    ("n1-1535" 132 28.755888124)
    ("n1-1536" 132 28.755888124)
    ("n1-1537" 132 28.755888124)
    ("n1-1538" 132 31.640879356)
    ("n1-1539" 132 34.525870588)
    ("n1-1540" 132 34.525870588)
    ("n1-1541" 132 34.525870588)
    ("n1-1542" 132 37.410858231)
    ("n1-1543" 132 40.780545703)
    ("n1-1544" 132 40.780545703)
    ("n1-1545" 132 40.780545703)
    ("n1-1546" 132 43.665540523)
    ("n5-1303" 132 11.341251097)
    ("n5-1304" 132 11.341251097)
    ("n5-1305" 132 22.881210641)
    ("n5-1306" 132 22.881210641)
    ("n5-1307" 132 22.881210641)
    ("n5-1308" 132 22.881210641)
    ("n5-1309" 132 28.755888124)
    ("n5-1310" 132 28.755888124)
    ("n5-1311" 132 40.780545703)
    ("n5-1312" 132 40.780545703)
    ("n5-1313" 132 40.780545703)
    ("n5-1314" 132 40.780545703)
    ("n1-1547" 132 48.290527524)
    ("n1-1548" 132 48.290527524)
    ("n1-1549" 132 48.290527524)
    ("n1-1550" 132 51.014403119)
    ("n1-1551" 132 53.738285890)
    ("n1-1552" 132 53.738285890)
    ("n1-1553" 132 53.738285890)
    ("n1-1554" 132 56.462165074)
    ("n1-1555" 132 61.494796599)
    ("n1-1556" 132 61.494796599)
    ("n1-1557" 132 64.422697214)
    ("n1-1558" 132 68.146587165)
    ("n1-1559" 132 68.146587165)
    ("n1-1560" 132 70.870459171)
    ("n1-1561" 132 73.917021797)
    ("n1-1562" 132 73.917021797)
    ("n1-1563" 132 76.640900981)
    ("n1-1564" 132 81.673532506)
    ("n1-1565" 132 81.673532506)
    ("n1-1566" 132 84.601440298)
    ("n5-1315" 132 48.290527524)
    ("n5-1316" 132 48.290527524)
    ("n5-1317" 132 61.494796599)
    ("n5-1318" 132 61.494796599)
    ("n5-1319" 132 61.494796599)
    ("n5-1320" 132 61.494796599)
    ("n5-1321" 132 68.146587165)
    ("n5-1322" 132 68.146587165)
    ("n5-1323" 132 81.673532506)
    ("n5-1324" 132 81.673532506)
    ("n5-1325" 132 81.673532506)
    ("n5-1326" 132 81.673532506)
    ("n1-1567" 132 89.565320634)
    ("n1-1568" 132 89.565320634)
    ("n1-1569" 132 92.382332235)
    ("n1-1570" 132 96.199361781)
    ("n1-1571" 132 96.199361781)
    ("n1-1572" 132 99.016380559)
    ("n1-1573" 132 103.420303671)
    ("n1-1574" 132 103.420303671)
    ("n1-1575" 132 106.409993511)
    ("n1-1576" 132 109.227012289)
    ("n1-1577" 132 109.227012289)
    ("n1-1578" 132 112.044031067)
    ("n1-1579" 132 115.861053435)
    ("n1-1580" 132 115.861053435)
    ("n1-1581" 132 118.678065036)
    ("n1-1582" 132 122.730430497)
    ("n1-1583" 132 122.730430497)
    ("n1-1584" 132 125.547456453)
    ("n5-1327" 132 89.565320634)
    ("n5-1328" 132 89.565320634)
    ("n5-1329" 132 96.199361781)
    ("n5-1330" 132 96.199361781)
    ("n5-1331" 132 103.420303671)
    ("n5-1332" 132 103.420303671)
    ("n5-1333" 132 109.227012289)
    ("n5-1334" 132 109.227012289)
    ("n5-1335" 132 115.861053435)
    ("n5-1336" 132 115.861053435)
    ("n5-1337" 132 122.730430497)
    ("n5-1338" 132 122.730430497)
    ("n1-1585" 537/4 12.664451306)
    ("n1-1586" 537/4 12.664451306)
    ("n1-1587" 537/4 15.451693334)
    ("n1-1588" 537/4 18.238933567)
    ("n1-1589" 537/4 18.238933567)
    ("n1-1590" 537/4 21.026175594)
    ("n1-1591" 537/4 23.813417621)
    ("n1-1592" 537/4 23.813417621)
    ("n1-1593" 537/4 26.600661443)
    ("n1-1594" 537/4 29.387901676)
    ("n1-1595" 537/4 29.387901676)
    ("n1-1596" 537/4 32.175141909)
    ("n1-1597" 537/4 36.367952434)
    ("n1-1598" 537/4 36.367952434)
    ("n1-1599" 537/4 39.155196256)
    ("n1-1600" 537/4 43.024881934)
    ("n1-1601" 537/4 43.024881934)
    ("n1-1602" 537/4 46.014571774)
    ("n5-1339" 537/4 12.664451306)
    ("n5-1340" 537/4 12.664451306)
    ("n5-1341" 537/4 18.238933567)
    ("n5-1342" 537/4 18.238933567)
    ("n5-1343" 537/4 23.813417621)
    ("n5-1344" 537/4 23.813417621)
    ("n5-1345" 537/4 29.387901676)
    ("n5-1346" 537/4 29.387901676)
    ("n5-1347" 537/4 36.367952434)
    ("n5-1348" 537/4 36.367952434)
    ("n5-1349" 537/4 43.024881934)
    ("n5-1350" 537/4 43.024881934)
    ("n1-1603" 537/4 50.541811365)
    ("n1-1604" 537/4 50.541811365)
    ("n1-1605" 537/4 53.143985369)
    ("n1-1606" 537/4 56.513676430)
    ("n1-1607" 537/4 56.513676430)
    ("n1-1608" 537/4 59.115843257)
    ("n1-1609" 537/4 62.162405883)
    ("n1-1610" 537/4 62.162405883)
    ("n1-1611" 537/4 64.764572710)
    ("n1-1612" 537/4 67.366746714)
    ("n1-1613" 537/4 67.366746714)
    ("n1-1614" 537/4 69.968920719)
    ("n1-1615" 537/4 72.571087546)
    ("n1-1616" 537/4 72.571087546)
    ("n1-1617" 537/4 75.173261550)
    ("n1-1618" 537/4 77.775428377)
    ("n1-1619" 537/4 77.775428377)
    ("n1-1620" 537/4 80.377595204)
    ("n5-1351" 537/4 50.541811365)
    ("n5-1352" 537/4 50.541811365)
    ("n5-1353" 537/4 56.513676430)
    ("n5-1354" 537/4 56.513676430)
    ("n5-1355" 537/4 62.162405883)
    ("n5-1356" 537/4 62.162405883)
    ("n5-1357" 537/4 67.366746714)
    ("n5-1358" 537/4 67.366746714)
    ("n5-1359" 537/4 72.571087546)
    ("n5-1360" 537/4 72.571087546)
    ("n5-1361" 537/4 77.775428377)
    ("n5-1362" 537/4 77.775428377)
    ("n1-1621" 537/4 84.719764977)
    ("n1-1622" 537/4 84.719764977)
    ("n1-1623" 537/4 88.073802385)
    ("n1-1624" 537/4 92.709745507)
    ("n1-1625" 537/4 92.709745507)
    ("n1-1626" 537/4 96.063761383)
    ("n1-1627" 537/4 100.636573129)
    ("n1-1628" 537/4 100.636573129)
    ("n1-1629" 537/4 103.990603359)
    ("n1-1630" 537/4 107.344633590)
    ("n1-1631" 537/4 107.344633590)
    ("n1-1632" 537/4 110.698663820)
    ("n1-1633" 537/4 114.052694051)
    ("n1-1634" 537/4 114.052694051)
    ("n1-1635" 537/4 117.406724281)
    ("n1-1636" 537/4 121.656407592)
    ("n1-1637" 537/4 121.656407592)
    ("n1-1638" 537/4 125.010437823)
    ("n5-1363" 537/4 84.719764977)
    ("n5-1364" 537/4 84.719764977)
    ("n5-1365" 537/4 92.709745507)
    ("n5-1366" 537/4 92.709745507)
    ("n5-1367" 537/4 100.636573129)
    ("n5-1368" 537/4 100.636573129)
    ("n5-1369" 537/4 107.344633590)
    ("n5-1370" 537/4 107.344633590)
    ("n5-1371" 537/4 114.052694051)
    ("n5-1372" 537/4 114.052694051)
    ("n5-1373" 537/4 121.656407592)
    ("n5-1374" 537/4 121.656407592)
    ("n1-1639" 273/2 12.221250525)
    ("n1-1640" 273/2 12.221250525)
    ("n1-1641" 273/2 12.221250525)
    ("n1-1642" 273/2 18.695905759)
    ("n1-1643" 273/2 30.329787222)
    ("n5-1375" 273/2 12.221250525)
    ("n5-1376" 273/2 12.221250525)
    ("n5-1377" 273/2 21.933231582)
    ("n5-1378" 273/2 24.259797939)
    ("n5-1379" 273/2 26.283124112)
    ("n5-1380" 273/2 28.306457461)
    ("n5-1381" 273/2 30.329787222)
    ("n5-1382" 273/2 32.353116983)
    ("n1-1644" 273/2 36.932804565)
    ("n1-1645" 273/2 46.476749291)
    ("n1-1646" 273/2 60.792664586)
    ("n5-1383" 273/2 36.932804565)
    ("n5-1384" 273/2 39.318791644)
    ("n5-1385" 273/2 41.704775134)
    ("n5-1386" 273/2 44.090762212)
    ("n5-1387" 273/2 46.476749291)
    ("n5-1388" 273/2 48.862736370)
    ("n5-1389" 273/2 51.248723448)
    ("n5-1390" 273/2 53.634710527)
    ("n5-1391" 273/2 56.020690428)
    ("n5-1392" 273/2 58.406677507)
    ("n5-1393" 273/2 60.792664586)
    ("n5-1394" 273/2 63.178651664)
    ("n1-1647" 273/2 67.827765100)
    ("n1-1648" 273/2 77.371706237)
    ("n1-1649" 273/2 77.371706237)
    ("n1-1650" 273/2 77.371706237)
    ("n1-1651" 273/2 82.143680395)
    ("n1-1652" 273/2 91.687628709)
    ("n1-1653" 273/2 91.687628709)
    ("n1-1654" 273/2 91.687628709)
    ("n5-1395" 273/2 67.827765100)
    ("n5-1396" 273/2 70.213752179)
    ("n5-1397" 273/2 72.599739257)
    ("n5-1398" 273/2 74.985726336)
    ("n5-1399" 273/2 77.371706237)
    ("n5-1400" 273/2 79.757693316)
    ("n5-1401" 273/2 82.143680395)
    ("n5-1402" 273/2 84.529667473)
    ("n5-1403" 273/2 86.915654552)
    ("n5-1404" 273/2 89.301634453)
    ("n5-1405" 273/2 91.687628709)
    ("n5-1406" 273/2 94.073608611)
    ("n1-1655" 273/2 98.722722046)
    ("n1-1656" 273/2 109.269975502)
    ("n1-1657" 273/2 114.043607611)
    ("n1-1658" 273/2 118.817232543)
    ("n1-1659" 273/2 123.590857476)
    ("n2-158" 273/2 109.269975502)
    ("n2-159" 273/2 114.043607611)
    ("n5-1407" 273/2 98.722722046)
    ("n5-1408" 273/2 101.109541690)
    ("n5-1409" 273/2 103.496346979)
    ("n5-1410" 273/2 105.883159445)
    ("n5-1411" 273/2 109.269975502)
    ("n5-1412" 273/2 111.656795145)
    ("n5-1413" 273/2 114.043607611)
    ("n5-1414" 273/2 116.430412900)
    ("n5-1415" 273/2 118.817232543)
    ("n5-1416" 273/2 121.204037832)
    ("n5-1417" 273/2 123.590857476)
    ("n5-1418" 273/2 125.977662765)
    ("n1-1660" 279/2 11.841246658)
    ("n1-1661" 279/2 20.595354612)
    ("n1-1662" 279/2 25.064430301)
    ("n1-1663" 279/2 33.818531077)
    ("n2-160" 279/2 11.841246658)
    ("n2-161" 279/2 20.595354612)
    ("n2-162" 279/2 25.064430301)
    ("n2-163" 279/2 33.818531077)
    ("n5-1419" 279/2 11.841246658)
    ("n5-1420" 279/2 14.167810701)
    ("n5-1421" 279/2 16.310324142)
    ("n5-1422" 279/2 18.452837582)
    ("n5-1423" 279/2 20.595354612)
    ("n5-1424" 279/2 22.737868052)
    ("n5-1425" 279/2 25.064430301)
    ("n5-1426" 279/2 27.390988961)
    ("n5-1427" 279/2 29.533507784)
    ("n5-1428" 279/2 31.676019431)
    ("n5-1429" 279/2 33.818531077)
    ("n5-1430" 279/2 35.961049901)
    ("n1-1664" 279/2 40.540736460)
    ("n1-1665" 279/2 49.294837236)
    ("n1-1666" 279/2 53.763911131)
    ("n2-164" 279/2 40.540736460)
    ("n2-165" 279/2 53.763911131)
    ("n2-166" 279/2 58.232995792)
    ("n2-167" 279/2 58.232995792)
    ("n2-168" 279/2 62.518019085)
    ("n2-169" 279/2 62.518019085)
    ("n5-1431" 279/2 40.540736460)
    ("n5-1432" 279/2 42.867295120)
    ("n5-1433" 279/2 45.009810355)
    ("n5-1434" 279/2 47.152325590)
    ("n5-1435" 279/2 49.294837236)
    ("n5-1436" 279/2 51.437352471)
    ("n5-1437" 279/2 53.763911131)
    ("n5-1438" 279/2 56.090476968)
    ("n5-1439" 279/2 58.232995792)
    ("n5-1440" 279/2 60.375500261)
    ("n5-1441" 279/2 62.518019085)
    ("n5-1442" 279/2 64.660537908)
    ("n1-1667" 279/2 68.717093996)
    ("n1-1668" 279/2 77.695298191)
    ("n1-1669" 279/2 81.525741222)
    ("n1-1670" 279/2 81.525741222)
    ("n1-1671" 279/2 85.293497882)
    ("n1-1672" 279/2 89.061261719)
    ("n2-170" 279/2 68.717093996)
    ("n2-171" 279/2 68.717093996)
    ("n5-1443" 279/2 68.717093996)
    ("n5-1444" 279/2 70.663658697)
    ("n5-1445" 279/2 72.547537027)
    ("n5-1446" 279/2 74.431415357)
    ("n5-1447" 279/2 77.695298191)
    ("n5-1448" 279/2 79.579176521)
    ("n5-1449" 279/2 81.525741222)
    ("n5-1450" 279/2 83.409619552)
    ("n5-1451" 279/2 85.293497882)
    ("n5-1452" 279/2 87.177383389)
    ("n5-1453" 279/2 89.061261719)
    ("n5-1454" 279/2 90.945147226)
    ("n1-1673" 279/2 95.524826608)
    ("n1-1674" 279/2 95.524826608)
    ("n1-1675" 279/2 106.704948803)
    ("n1-1676" 279/2 109.638698247)
    ("n1-1677" 279/2 112.791692091)
    ("n1-1678" 279/2 112.791692091)
    ("n1-1679" 279/2 112.791692091)
    ("n2-172" 279/2 95.524826608)
    ("n5-1455" 279/2 95.524826608)
    ("n5-1456" 279/2 98.675451949)
    ("n5-1457" 279/2 101.665141121)
    ("n5-1458" 279/2 104.185048551)
    ("n5-1459" 279/2 106.704948803)
    ("n5-1460" 279/2 109.748324036)
    ("n5-1461" 279/2 112.791692091)
    ("n5-1462" 279/2 115.618263201)
    ("n5-1463" 279/2 118.284824010)
    ("n5-1464" 279/2 120.804738617)
    ("n5-1465" 279/2 123.324638869)
    ("n5-1466" 279/2 125.844539121)
    ("n1-1680" 285/2 11.341251097)
    ("n1-1681" 285/2 11.341251097)
    ("n1-1682" 285/2 11.341251097)
    ("n1-1683" 285/2 21.677802865)
    ("n1-1684" 285/2 21.677802865)
    ("n1-1685" 285/2 21.677802865)
    ("n1-1686" 285/2 26.521230458)
    ("n1-1687" 285/2 26.521230458)
    ("n1-1688" 285/2 26.521230458)
    ("n1-1689" 285/2 36.208085644)
    ("n1-1690" 285/2 36.208085644)
    ("n1-1691" 285/2 36.208085644)
    ("n5-1467" 285/2 11.341251097)
    ("n5-1468" 285/2 14.167813866)
    ("n5-1469" 285/2 16.834377066)
    ("n5-1470" 285/2 19.256089068)
    ("n5-1471" 285/2 21.677802865)
    ("n5-1472" 285/2 24.099518456)
    ("n5-1473" 285/2 26.521230458)
    ("n5-1474" 285/2 28.942942460)
    ("n5-1475" 285/2 31.364654462)
    ("n5-1476" 285/2 33.786370053)
    ("n5-1477" 285/2 36.208085644)
    ("n5-1478" 285/2 38.629797646)
    ("n1-1692" 285/2 42.791512595)
    ("n1-1693" 285/2 42.791512595)
    ("n1-1694" 285/2 54.543591339)
    ("n1-1695" 285/2 54.543591339)
    ("n1-1696" 285/2 72.068369149)
    ("n2-173" 285/2 44.408073459)
    ("n5-1479" 285/2 42.791512595)
    ("n5-1480" 285/2 45.712304111)
    ("n5-1481" 285/2 48.633102805)
    ("n5-1482" 285/2 51.622789057)
    ("n5-1483" 285/2 54.543591339)
    ("n5-1484" 285/2 57.464386445)
    ("n5-1485" 285/2 60.385181550)
    ("n5-1486" 285/2 63.305976655)
    ("n5-1487" 285/2 66.226778938)
    ("n5-1488" 285/2 69.147574044)
    ("n5-1489" 285/2 72.068369149)
    ("n5-1490" 285/2 74.989164254)
    ("n1-1697" 285/2 79.689961301)
    ("n1-1698" 285/2 94.294589961)
    ("n1-1699" 285/2 94.294589961)
    ("n1-1700" 285/2 101.596907879)
    ("n1-1701" 285/2 116.201543716)
    ("n1-1702" 285/2 116.201543716)
    ("n5-1491" 285/2 79.689961301)
    ("n5-1492" 285/2 83.341123849)
    ("n5-1493" 285/2 86.992279220)
    ("n5-1494" 285/2 90.643434590)
    ("n5-1495" 285/2 94.294589961)
    ("n5-1496" 285/2 97.945745331)
    ("n5-1497" 285/2 101.596907879)
    ("n5-1498" 285/2 105.248063250)
    ("n5-1499" 285/2 108.899225798)
    ("n5-1500" 285/2 112.550388346)
    ("n5-1501" 285/2 116.201543716)
    ("n5-1502" 285/2 119.852699087)
    ("n1-1703" 579/4 12.137812822)
    ("n1-1704" 579/4 23.115150575)
    ("n1-1705" 579/4 27.650023205)
    ("n1-1706" 579/4 32.184892247)
    ("n1-1707" 579/4 36.601511972)
    ("n2-174" 579/4 23.115150575)
    ("n2-175" 579/4 27.650023205)
    ("n5-1503" 579/4 12.137812822)
    ("n5-1504" 579/4 14.464375590)
    ("n5-1505" 579/4 16.672683658)
    ("n5-1506" 579/4 19.026841283)
    ("n5-1507" 579/4 23.115150575)
    ("n5-1508" 579/4 25.323460437)
    ("n5-1509" 579/4 27.650023205)
    ("n5-1510" 579/4 29.976582385)
    ("n5-1511" 579/4 32.184892247)
    ("n5-1512" 579/4 34.393202109)
    ("n5-1513" 579/4 36.601511972)
    ("n5-1514" 579/4 38.809821834)
    ("n1-1708" 579/4 43.066384570)
    ("n1-1709" 579/4 52.069137077)
    ("n1-1710" 579/4 52.069137077)
    ("n1-1711" 579/4 56.621098817)
    ("n1-1712" 579/4 56.621098817)
    ("n1-1713" 579/4 65.623851323)
    ("n1-1714" 579/4 65.623851323)
    ("n2-176" 579/4 43.066384570)
    ("n2-177" 579/4 52.069137077)
    ("n2-178" 579/4 56.621098817)
    ("n2-179" 579/4 65.623851323)
    ("n5-1515" 579/4 43.066384570)
    ("n5-1516" 579/4 45.392943750)
    ("n5-1517" 579/4 47.618342722)
    ("n5-1518" 579/4 49.843738105)
    ("n5-1519" 579/4 52.069137077)
    ("n5-1520" 579/4 54.294532460)
    ("n5-1521" 579/4 56.621098817)
    ("n5-1522" 579/4 58.947657997)
    ("n5-1523" 579/4 61.173053380)
    ("n5-1524" 579/4 63.398455940)
    ("n5-1525" 579/4 65.623851323)
    ("n5-1526" 579/4 67.849246707)
    ("n1-1715" 579/4 72.105805854)
    ("n1-1716" 579/4 72.105805854)
    ("n1-1717" 579/4 81.108558361)
    ("n1-1718" 579/4 85.660527278)
    ("n2-180" 579/4 73.292375726)
    ("n2-181" 579/4 85.660527278)
    ("n2-182" 579/4 90.212481841)
    ("n2-183" 579/4 90.212481841)
    ("n2-184" 579/4 94.663272607)
    ("n2-185" 579/4 94.663272607)
    ("n5-1527" 579/4 72.105805854)
    ("n5-1528" 579/4 74.432372211)
    ("n5-1529" 579/4 76.657767594)
    ("n5-1530" 579/4 78.883170155)
    ("n5-1531" 579/4 81.108558361)
    ("n5-1532" 579/4 83.333960921)
    ("n5-1533" 579/4 85.660527278)
    ("n5-1534" 579/4 87.987093635)
    ("n5-1535" 579/4 90.212481841)
    ("n5-1536" 579/4 92.437877224)
    ("n5-1537" 579/4 94.663272607)
    ("n5-1538" 579/4 96.888675168)
    ("n1-1719" 579/4 100.945232162)
    ("n1-1720" 579/4 111.149619656)
    ("n1-1721" 579/4 115.311804716)
    ("n1-1722" 579/4 119.804625649)
    ("n1-1723" 579/4 123.966817887)
    ("n2-186" 579/4 100.945232162)
    ("n2-187" 579/4 100.945232162)
    ("n2-188" 579/4 116.498381765)
    ("n5-1539" 579/4 100.945232162)
    ("n5-1540" 579/4 103.026335458)
    ("n5-1541" 579/4 105.107424400)
    ("n5-1542" 579/4 107.188527696)
    ("n5-1543" 579/4 111.149619656)
    ("n5-1544" 579/4 113.230722952)
    ("n5-1545" 579/4 115.311804716)
    ("n5-1546" 579/4 117.558222360)
    ("n5-1547" 579/4 119.804625649)
    ("n5-1548" 579/4 121.885721768)
    ("n5-1549" 579/4 123.966817887)
    ("n5-1550" 579/4 126.047914005)
    ("n1-1724" 591/4 12.961874304)
    ("n1-1725" 591/4 25.934060567)
    ("n1-1726" 591/4 29.602559840)
    ("n1-1727" 591/4 34.235560277)
    ("n1-1728" 591/4 34.235560277)
    ("n1-1729" 591/4 34.235560277)
    ("n2-189" 591/4 12.961874304)
    ("n2-190" 591/4 12.961874304)
    ("n5-1551" 591/4 12.961874304)
    ("n5-1552" 591/4 16.204920421)
    ("n5-1553" 591/4 19.447966538)
    ("n5-1554" 591/4 22.691012655)
    ("n5-1555" 591/4 25.934060567)
    ("n5-1556" 591/4 30.084808628)
    ("n5-1557" 591/4 34.235560277)
    ("n5-1558" 591/4 37.478604600)
    ("n5-1559" 591/4 40.721652511)
    ("n5-1560" 591/4 43.964693246)
    ("n5-1561" 591/4 47.207741157)
    ("n5-1562" 591/4 50.450785480)
    ("n1-1730" 591/4 55.433839926)
    ("n1-1731" 591/4 55.433839926)
    ("n1-1732" 591/4 55.433839926)
    ("n1-1733" 591/4 65.775148438)
    ("n1-1734" 591/4 65.775148438)
    ("n1-1735" 591/4 65.775148438)
    ("n1-1736" 591/4 70.945799105)
    ("n1-1737" 591/4 70.945799105)
    ("n1-1738" 591/4 70.945799105)
    ("n1-1739" 591/4 81.287114794)
    ("n1-1740" 591/4 81.287114794)
    ("n1-1741" 591/4 81.287114794)
    ("n5-1563" 591/4 55.433839926)
    ("n5-1564" 591/4 58.019161671)
    ("n5-1565" 591/4 60.604490594)
    ("n5-1566" 591/4 63.189819516)
    ("n5-1567" 591/4 65.775148438)
    ("n5-1568" 591/4 68.360470183)
    ("n5-1569" 591/4 70.945799105)
    ("n5-1570" 591/4 73.531128028)
    ("n5-1571" 591/4 76.116456950)
    ("n5-1572" 591/4 78.701785872)
    ("n5-1573" 591/4 81.287114794)
    ("n5-1574" 591/4 83.872443717)
    ("n1-1742" 591/4 88.017762163)
    ("n1-1743" 591/4 88.017762163)
    ("n1-1744" 591/4 101.466668911)
    ("n1-1745" 591/4 101.466668911)
    ("n1-1746" 591/4 121.640029034)
    ("n2-191" 591/4 88.017762163)
    ("n5-1575" 591/4 88.017762163)
    ("n5-1576" 591/4 91.379996028)
    ("n5-1577" 591/4 94.742222715)
    ("n5-1578" 591/4 98.104442224)
    ("n5-1579" 591/4 101.466668911)
    ("n5-1580" 591/4 104.828902776)
    ("n5-1581" 591/4 108.191115108)
    ("n5-1582" 591/4 111.553348973)
    ("n5-1583" 591/4 114.915575660)
    ("n5-1584" 591/4 118.277802347)
    ("n5-1585" 591/4 121.640029034)
    ("n5-1586" 591/4 125.002255721)
    ("n1-1747" 150 11.757813395)
    ("n1-1748" 150 24.534386412)
    ("n1-1749" 150 24.534386412)
    ("n1-1750" 150 31.175719678)
    ("n1-1751" 150 44.217753460)
    ("n1-1752" 150 44.217753460)
    ("n2-192" 150 24.534386412)
    ("n2-193" 150 44.217753460)
    ("n5-1587" 150 11.757813395)
    ("n5-1588" 150 14.951955304)
    ("n5-1589" 150 18.146099007)
    ("n5-1590" 150 21.340242710)
    ("n5-1591" 150 24.534386412)
    ("n5-1592" 150 27.728528321)
    ("n5-1593" 150 31.175719678)
    ("n5-1594" 150 34.382278286)
    ("n5-1595" 150 37.829466054)
    ("n5-1596" 150 41.023611551)
    ("n5-1597" 150 44.217753460)
    ("n5-1598" 150 47.411895369)
    ("n1-1753" 150 52.869167223)
    ("n1-1754" 150 62.987068463)
    ("n1-1755" 150 64.831314260)
    ("n1-1756" 150 64.831314260)
    ("n1-1757" 150 64.831314260)
    ("n1-1758" 150 70.668368428)
    ("n1-1759" 150 70.668368428)
    ("n1-1760" 150 70.668368428)
    ("n1-1761" 150 76.505422597)
    ("n1-1762" 150 76.505422597)
    ("n1-1763" 150 76.505422597)
    ("n1-1764" 150 82.342483942)
    ("n1-1765" 150 82.342483942)
    ("n1-1766" 150 82.342483942)
    ("n2-194" 150 54.055729917)
    ("n5-1599" 150 52.869167223)
    ("n5-1600" 150 56.075725830)
    ("n5-1601" 150 58.994260092)
    ("n5-1602" 150 61.912787176)
    ("n5-1603" 150 64.831314260)
    ("n5-1604" 150 67.749841344)
    ("n5-1605" 150 70.668368428)
    ("n5-1606" 150 73.586902690)
    ("n5-1607" 150 76.505422597)
    ("n5-1608" 150 79.423956858)
    ("n5-1609" 150 82.342483942)
    ("n5-1610" 150 85.261018203)
    ("n1-1767" 150 92.202670500)
    ("n1-1768" 150 92.202670500)
    ("n1-1769" 150 93.389233194)
    ("n1-1770" 150 104.397024157)
    ("n1-1771" 150 104.397024157)
    ("n1-1772" 150 104.397024157)
    ("n1-1773" 150 110.388885131)
    ("n1-1774" 150 110.388885131)
    ("n1-1775" 150 110.388885131)
    ("n1-1776" 150 116.380760460)
    ("n1-1777" 150 116.380760460)
    ("n1-1778" 150 116.380760460)
    ("n1-1779" 150 122.372614257)
    ("n1-1780" 150 122.372614257)
    ("n1-1781" 150 122.372614257)
    ("n5-1611" 150 92.202670500)
    ("n5-1612" 150 95.409229107)
    ("n5-1613" 150 98.405163183)
    ("n5-1614" 150 101.401097259)
    ("n5-1615" 150 104.397024157)
    ("n5-1616" 150 107.392958233)
    ("n5-1617" 150 110.388885131)
    ("n5-1618" 150 113.384819207)
    ("n5-1619" 150 116.380760460)
    ("n5-1620" 150 119.376673004)
    ("n5-1621" 150 122.372614257)
    ("n5-1622" 150 125.368555510)
    ("n1-1782" 609/4 12.461873313)
    ("n1-1783" 609/4 12.461873313)
    ("n1-1784" 609/4 12.461873313)
    ("n1-1785" 609/4 23.130249998)
    ("n1-1786" 609/4 23.130249998)
    ("n1-1787" 609/4 23.130249998)
    ("n1-1788" 609/4 27.925499011)
    ("n1-1789" 609/4 27.925499011)
    ("n1-1790" 609/4 27.925499011)
    ("n1-1791" 609/4 37.516000626)
    ("n1-1792" 609/4 37.516000626)
    ("n1-1793" 609/4 37.516000626)
    ("n5-1623" 609/4 12.461873313)
    ("n5-1624" 609/4 15.668434792)
    ("n5-1625" 609/4 18.334995602)
    ("n5-1626" 609/4 20.732623697)
    ("n5-1627" 609/4 23.130249998)
    ("n5-1628" 609/4 25.527874504)
    ("n5-1629" 609/4 37.516000626)
    ("n6-160" 609/4 27.925499011)
    ("n6-161" 609/4 30.323123517)
    ("n6-162" 609/4 32.720751613)
    ("n6-163" 609/4 35.118376119)
    ("n6-164" 609/4 37.516000626)
    ("n6-165" 609/4 40.043501618)
    ("n1-1794" 609/4 44.381127202)
    ("n1-1795" 609/4 44.381127202)
    ("n1-1796" 609/4 44.381127202)
    ("n1-1797" 609/4 53.407774454)
    ("n1-1798" 609/4 53.407774454)
    ("n1-1799" 609/4 53.407774454)
    ("n1-1800" 609/4 57.900723574)
    ("n1-1801" 609/4 57.900723574)
    ("n1-1802" 609/4 57.900723574)
    ("n1-1803" 609/4 66.726439259)
    ("n1-1804" 609/4 66.726439259)
    ("n1-1805" 609/4 66.726439259)
    ("n2-195" 609/4 45.997687706)
    ("n2-196" 609/4 59.517284078)
    ("n5-1630" 609/4 44.381127202)
    ("n5-1631" 609/4 57.900723574)
    ("n5-1632" 609/4 60.227282234)
    ("n5-1633" 609/4 62.393665516)
    ("n5-1634" 609/4 64.560055976)
    ("n5-1635" 609/4 66.726439259)
    ("n5-1636" 609/4 68.892815364)
    ("n6-166" 609/4 44.381127202)
    ("n6-167" 609/4 46.908628195)
    ("n6-168" 609/4 49.075011478)
    ("n6-169" 609/4 51.241391172)
    ("n6-170" 609/4 53.407774454)
    ("n6-171" 609/4 55.574157737)
    ("n1-1806" 609/4 73.149380738)
    ("n1-1807" 609/4 73.149380738)
    ("n1-1808" 609/4 73.149380738)
    ("n1-1809" 609/4 81.734427841)
    ("n1-1810" 609/4 81.734427841)
    ("n1-1811" 609/4 84.504714713)
    ("n1-1812" 609/4 86.348960098)
    ("n1-1813" 609/4 86.348960098)
    ("n1-1814" 609/4 86.348960098)
    ("n1-1815" 609/4 90.761681572)
    ("n1-1816" 609/4 90.761681572)
    ("n1-1817" 609/4 90.761681572)
    ("n1-1818" 609/4 97.020170015)
    ("n1-1819" 609/4 97.020170015)
    ("n1-1820" 609/4 97.020170015)
    ("n2-197" 609/4 74.765948419)
    ("n5-1637" 609/4 73.149380738)
    ("n5-1638" 609/4 75.475946575)
    ("n5-1639" 609/4 77.562102212)
    ("n5-1640" 609/4 79.648265026)
    ("n5-1641" 609/4 81.734427841)
    ("n5-1642" 609/4 83.820583478)
    ("n5-1643" 609/4 86.348960098)
    ("n5-1644" 609/4 88.675518758)
    ("n5-1645" 609/4 90.761681572)
    ("n5-1646" 609/4 92.847844387)
    ("n5-1647" 609/4 94.934000024)
    ("n5-1648" 609/4 97.020170015)
    ("n1-1821" 609/4 101.276721035)
    ("n1-1822" 609/4 101.276721035)
    ("n1-1823" 609/4 102.463290641)
    ("n1-1824" 609/4 109.830130683)
    ("n1-1825" 609/4 109.830130683)
    ("n1-1826" 609/4 109.830130683)
    ("n1-1827" 609/4 114.232315909)
    ("n1-1828" 609/4 114.232315909)
    ("n1-1829" 609/4 115.418863983)
    ("n1-1830" 609/4 114.232315909)
    ("n1-1831" 609/4 118.634486780)
    ("n1-1832" 609/4 118.634486780)
    ("n1-1833" 609/4 118.634486780)
    ("n1-1834" 609/4 124.861323414)
    ("n1-1835" 609/4 126.047885843)
    ("n1-1836" 609/4 124.861323414)
    ("n1-1837" 609/4 124.861323414)
    ("n5-1649" 609/4 101.276721035)
    ("n5-1650" 609/4 103.603286872)
    ("n5-1651" 609/4 105.678899083)
    ("n5-1652" 609/4 107.754518472)
    ("n5-1653" 609/4 109.830130683)
    ("n5-1654" 609/4 111.905742894)
    ("n5-1655" 609/4 114.232315909)
    ("n5-1656" 609/4 116.558860214)
    ("n5-1657" 609/4 118.634486780)
    ("n5-1658" 609/4 120.710098991)
    ("n5-1659" 609/4 122.785711203)
    ("n5-1660" 609/4 124.861323414)
    ("n1-1838" 621/4 12.137812822)
    ("n1-1839" 621/4 12.137812822)
    ("n1-1840" 621/4 12.137812822)
    ("n1-1841" 621/4 30.595766545)
    ("n1-1842" 621/4 30.595766545)
    ("n1-1843" 621/4 30.595766545)
    ("n1-1844" 621/4 39.824746995)
    ("n1-1845" 621/4 39.824746995)
    ("n1-1846" 621/4 39.824746995)
    ("n1-1847" 621/4 58.282704307)
    ("n1-1848" 621/4 58.282704307)
    ("n1-1849" 621/4 59.469259824)
    ("n5-1661" 621/4 12.137812822)
    ("n5-1662" 621/4 16.752303047)
    ("n5-1663" 621/4 21.366789683)
    ("n5-1664" 621/4 25.981276320)
    ("n5-1665" 621/4 30.595766545)
    ("n5-1666" 621/4 35.210256770)
    ("n5-1667" 621/4 39.824746995)
    ("n5-1668" 621/4 44.439233631)
    ("n5-1669" 621/4 49.053720268)
    ("n5-1670" 621/4 53.668206904)
    ("n5-1671" 621/4 58.282704307)
    ("n5-1672" 621/4 62.897187355)
    ("n1-1850" 621/4 69.251673349)
    ("n1-1851" 621/4 69.251673349)
    ("n1-1852" 621/4 70.438236043)
    ("n1-1853" 621/4 88.955940643)
    ("n1-1854" 621/4 88.955940643)
    ("n1-1855" 621/4 88.955940643)
    ("n1-1856" 621/4 98.808081467)
    ("n1-1857" 621/4 98.808081467)
    ("n1-1858" 621/4 98.808081467)
    ("n1-1859" 621/4 108.660215114)
    ("n1-1860" 621/4 108.660215114)
    ("n1-1861" 621/4 108.660215114)
    ("n1-1862" 621/4 118.512341584)
    ("n1-1863" 621/4 118.512341584)
    ("n1-1864" 621/4 118.512341584)
    ("n5-1673" 621/4 69.251673349)
    ("n5-1674" 621/4 74.177743761)
    ("n5-1675" 621/4 79.103806996)
    ("n5-1676" 621/4 84.029877408)
    ("n5-1677" 621/4 88.955940643)
    ("n5-1678" 621/4 93.882003877)
    ("n5-1679" 621/4 98.808081467)
    ("n5-1680" 621/4 103.734137525)
    ("n5-1681" 621/4 108.660215114)
    ("n5-1682" 621/4 113.586271172)
    ("n5-1683" 621/4 118.512341584)
    ("n5-1684" 621/4 123.438411996)
    ("n1-1865" 627/4 12.637812823)
    ("n1-1866" 627/4 12.637812823)
    ("n1-1867" 627/4 12.637812823)
    ("n1-1868" 627/4 25.338087739)
    ("n1-1869" 627/4 25.338087739)
    ("n1-1870" 627/4 25.338087739)
    ("n1-1871" 627/4 31.627228164)
    ("n1-1872" 627/4 31.627228164)
    ("n1-1873" 627/4 31.627228164)
    ("n1-1874" 627/4 37.916368590)
    ("n1-1875" 627/4 37.916368590)
    ("n1-1876" 627/4 37.916368590)
    ("n1-1877" 627/4 47.350081023)
    ("n1-1878" 627/4 47.350081023)
    ("n1-1879" 627/4 47.350081023)
    ("n5-1685" 627/4 12.637812823)
    ("n5-1686" 627/4 15.782384830)
    ("n5-1687" 627/4 18.926953248)
    ("n5-1688" 627/4 22.193519320)
    ("n5-1689" 627/4 25.338087739)
    ("n5-1690" 627/4 28.482659746)
    ("n5-1691" 627/4 31.627228164)
    ("n5-1692" 627/4 34.771800172)
    ("n5-1693" 627/4 37.916368590)
    ("n5-1694" 627/4 41.060944186)
    ("n5-1695" 627/4 44.205512605)
    ("n5-1696" 627/4 47.350081023)
    ("n1-1880" 627/4 52.654652604)
    ("n1-1881" 627/4 52.654652604)
    ("n1-1882" 627/4 52.654652604)
    ("n1-1883" 627/4 58.650848657)
    ("n1-1884" 627/4 58.650848657)
    ("n1-1885" 627/4 58.650848657)
    ("n1-1886" 627/4 64.915510961)
    ("n1-1887" 627/4 64.915510961)
    ("n1-1888" 627/4 64.915510961)
    ("n1-1889" 627/4 70.911707014)
    ("n1-1890" 627/4 70.911707014)
    ("n1-1891" 627/4 70.911707014)
    ("n1-1892" 627/4 76.907895889)
    ("n1-1893" 627/4 76.907895889)
    ("n1-1894" 627/4 76.907895889)
    ("n1-1895" 627/4 82.904099119)
    ("n1-1896" 627/4 82.904099119)
    ("n1-1897" 627/4 82.904099119)
    ("n5-1697" 627/4 52.654652604)
    ("n5-1698" 627/4 52.654652604)
    ("n5-1699" 627/4 55.652747042)
    ("n5-1700" 627/4 58.650848657)
    ("n5-1701" 627/4 61.917409346)
    ("n5-1702" 627/4 64.915510961)
    ("n5-1703" 627/4 67.913612576)
    ("n5-1704" 627/4 70.911707014)
    ("n5-1705" 627/4 73.909801451)
    ("n5-1706" 627/4 76.907895889)
    ("n5-1707" 627/4 79.905997504)
    ("n5-1708" 627/4 82.904099119)
    ("n5-1709" 627/4 85.902193557)
    ("n1-1898" 627/4 91.940290584)
    ("n1-1899" 627/4 91.940290584)
    ("n1-1900" 627/4 91.940290584)
    ("n1-1901" 627/4 97.962504286)
    ("n1-1902" 627/4 97.962504286)
    ("n1-1903" 627/4 97.962504286)
    ("n1-1904" 627/4 104.240164649)
    ("n1-1905" 627/4 104.240164649)
    ("n1-1906" 627/4 104.240164649)
    ("n1-1907" 627/4 110.297841303)
    ("n1-1908" 627/4 110.297841303)
    ("n1-1909" 627/4 110.297841303)
    ("n1-1910" 627/4 116.320055005)
    ("n1-1911" 627/4 116.320055005)
    ("n1-1912" 627/4 116.320055005)
    ("n1-1913" 627/4 122.342268706)
    ("n1-1914" 627/4 122.342268706)
    ("n1-1915" 627/4 122.342268706)
    ("n5-1710" 627/4 91.940290584)
    ("n5-1711" 627/4 91.940290584)
    ("n5-1712" 627/4 94.951397435)
    ("n5-1713" 627/4 97.962504286)
    ("n5-1714" 627/4 101.229064975)
    ("n5-1715" 627/4 104.240164649)
    ("n5-1716" 627/4 107.251271499)
    ("n5-1717" 627/4 110.297841303)
    ("n5-1718" 627/4 110.297841303)
    ("n5-1719" 627/4 113.308940976)
    ("n5-1720" 627/4 116.320055005)
    ("n5-1721" 627/4 119.331154678)
    ("n5-1722" 627/4 122.342268706)
    ("n5-1723" 627/4 125.353368380)
    ("n1-1916" 159 11.257813394)
    ("n1-1917" 159 11.257813394)
    ("n1-1918" 159 25.375646458)
    ("n1-1919" 159 25.375646458)
    ("n1-1920" 159 31.184249878)
    ("n1-1921" 159 29.997687184)
    ("n1-1922" 159 31.184249878)
    ("n1-1923" 159 31.184249878)
    ("n1-1924" 159 36.992853299)
    ("n1-1925" 159 36.992853299)
    ("n1-1926" 159 42.801456719)
    ("n1-1927" 159 42.801456719)
    ("n2-198" 159 11.257813394)
    ("n2-199" 159 19.567041243)
    ("n2-200" 159 19.567041243)
    ("n2-201" 159 19.567041243)
    ("n5-1724" 159 11.257813394)
    ("n5-1725" 159 11.257813394)
    ("n5-1726" 159 19.567041243)
    ("n5-1727" 159 19.567041243)
    ("n5-1728" 159 19.567041243)
    ("n5-1729" 159 20.753603937)
    ("n5-1730" 159 25.375646458)
    ("n5-1731" 159 25.375646458)
    ("n5-1732" 159 26.562209152)
    ("n5-1733" 159 25.375646458)
    ("n5-1734" 159 31.184249878)
    ("n5-1735" 159 32.370812573)
    ("n5-1736" 159 31.184249878)
    ("n5-1737" 159 31.184249878)
    ("n5-1738" 159 36.992853299)
    ("n5-1739" 159 36.992853299)
    ("n5-1740" 159 38.179415993)
    ("n5-1741" 159 36.992853299)
    ("n5-1742" 159 42.801456719)
    ("n5-1743" 159 42.801456719)
    ("n5-1744" 159 42.801456719)
    ("n5-1745" 159 43.988015825)
    ("n1-1928" 159 50.850061293)
    ("n1-1929" 159 50.850061293)
    ("n1-1930" 159 64.636953450)
    ("n1-1931" 159 64.636953450)
    ("n1-1932" 159 70.840393535)
    ("n1-1933" 159 70.840393535)
    ("n1-1934" 159 83.247280881)
    ("n1-1935" 159 83.247280881)
    ("n2-202" 159 50.850061293)
    ("n2-203" 159 58.433506189)
    ("n2-204" 159 58.433506189)
    ("n2-205" 159 70.840393535)
    ("n2-206" 159 77.043833619)
    ("n2-207" 159 77.043833619)
    ("n5-1746" 159 50.850061293)
    ("n5-1747" 159 50.850061293)
    ("n5-1748" 159 58.433506189)
    ("n5-1749" 159 58.433506189)
    ("n5-1750" 159 64.636953450)
    ("n5-1751" 159 64.636953450)
    ("n5-1752" 159 70.840393535)
    ("n5-1753" 159 70.840393535)
    ("n5-1754" 159 77.043833619)
    ("n5-1755" 159 77.043833619)
    ("n5-1756" 159 83.247280881)
    ("n5-1757" 159 83.247280881)
    ("n1-1936" 159 92.540727682)
    ("n2-208" 159 92.110722334)
    ("n2-209" 159 92.110722334)
    ("n2-210" 159 98.153018072)
    ("n2-211" 159 98.153018072)
    ("n2-212" 159 104.195313810)
    ("n2-213" 159 104.195313810)
    ("n2-214" 159 109.066011488)
    ("n2-215" 159 110.237595194)
    ("n2-216" 159 110.237595194)
    ("n2-217" 159 110.237595194)
    ("n2-218" 159 116.279890932)
    ("n2-219" 159 116.279890932)
    ("n2-220" 159 116.279890932)
    ("n2-221" 159 122.322186670)
    ("n2-222" 159 122.322186670)
    ("n2-223" 159 122.322186670)
    ("n5-1758" 159 92.110722334)
    ("n5-1759" 159 92.110722334)
    ("n5-1760" 159 98.153018072)
    ("n5-1761" 159 98.153018072)
    ("n5-1762" 159 104.195313810)
    ("n5-1763" 159 104.195313810)
    ("n5-1764" 159 110.237595194)
    ("n5-1765" 159 110.237595194)
    ("n5-1766" 159 116.279890932)
    ("n5-1767" 159 116.279890932)
    ("n5-1768" 159 122.322186670)
    ("n5-1769" 159 122.322186670)
    ("n1-1937" 645/4 11.257813394)
    ("n1-1938" 645/4 11.257813394)
    ("n1-1939" 645/4 11.257813394)
    ("n1-1940" 645/4 17.357328222)
    ("n1-1941" 645/4 17.357328222)
    ("n1-1942" 645/4 23.456843051)
    ("n1-1943" 645/4 23.456843051)
    ("n1-1944" 645/4 29.556356085)
    ("n1-1945" 645/4 29.556356085)
    ("n1-1946" 645/4 35.655872707)
    ("n1-1947" 645/4 35.655872707)
    ("n1-1948" 645/4 45.567581387)
    ("n1-1949" 645/4 45.567581387)
    ("n5-1770" 645/4 11.257813394)
    ("n5-1771" 645/4 11.257813394)
    ("n5-1772" 645/4 17.357328222)
    ("n5-1773" 645/4 17.357328222)
    ("n5-1774" 645/4 23.456843051)
    ("n5-1775" 645/4 23.456843051)
    ("n5-1776" 645/4 29.556356085)
    ("n5-1777" 645/4 29.556356085)
    ("n5-1778" 645/4 35.655872707)
    ("n5-1779" 645/4 35.655872707)
    ("n5-1780" 645/4 45.567581387)
    ("n5-1781" 645/4 45.567581387)
    ("n1-1950" 645/4 51.119779980)
    ("n1-1951" 645/4 51.119779980)
    ("n1-1952" 645/4 63.707667624)
    ("n1-1953" 645/4 70.001613240)
    ("n1-1954" 645/4 68.815050546)
    ("n1-1955" 645/4 70.001613240)
    ("n1-1956" 645/4 70.001613240)
    ("n1-1957" 645/4 76.295558857)
    ("n1-1958" 645/4 75.108996163)
    ("n1-1959" 645/4 76.295558857)
    ("n1-1960" 645/4 76.295558857)
    ("n1-1961" 645/4 82.589504473)
    ("n1-1962" 645/4 81.402941779)
    ("n1-1963" 645/4 82.589504473)
    ("n1-1964" 645/4 82.589504473)
    ("n2-224" 645/4 51.119779980)
    ("n2-225" 645/4 57.413722008)
    ("n2-226" 645/4 57.413722008)
    ("n2-227" 645/4 63.707667624)
    ("n2-228" 645/4 63.707667624)
    ("n5-1782" 645/4 51.119779980)
    ("n5-1783" 645/4 51.119779980)
    ("n5-1784" 645/4 57.413722008)
    ("n5-1785" 645/4 57.413722008)
    ("n5-1786" 645/4 63.707667624)
    ("n5-1787" 645/4 63.707667624)
    ("n5-1788" 645/4 70.001613240)
    ("n5-1789" 645/4 70.001613240)
    ("n5-1790" 645/4 76.295558857)
    ("n5-1791" 645/4 76.295558857)
    ("n5-1792" 645/4 82.589504473)
    ("n5-1793" 645/4 82.589504473)
    ("n1-1965" 645/4 90.623453036)
    ("n1-1966" 645/4 90.623453036)
    ("n1-1967" 645/4 103.203793767)
    ("n1-1968" 645/4 103.203793767)
    ("n1-1969" 645/4 109.493964133)
    ("n1-1970" 645/4 109.493964133)
    ("n1-1971" 645/4 122.074297688)
    ("n1-1972" 645/4 122.074297688)
    ("n2-229" 645/4 90.623453036)
    ("n2-230" 645/4 96.913623402)
    ("n2-231" 645/4 96.913623402)
    ("n2-232" 645/4 109.493964133)
    ("n2-233" 645/4 115.784127322)
    ("n2-234" 645/4 115.784127322)
    ("n5-1794" 645/4 90.623453036)
    ("n5-1795" 645/4 90.623453036)
    ("n5-1796" 645/4 96.913623402)
    ("n5-1797" 645/4 96.913623402)
    ("n5-1798" 645/4 103.203793767)
    ("n5-1799" 645/4 103.203793767)
    ("n5-1800" 645/4 109.493964133)
    ("n5-1801" 645/4 109.493964133)
    ("n1-1973" 327/2 12.808435497)
    ("n2-235" 327/2 12.378435628)
    ("n2-236" 327/2 12.378435628)
    ("n2-237" 327/2 17.048023013)
    ("n2-238" 327/2 17.048023013)
    ("n2-239" 327/2 21.717610398)
    ("n2-240" 327/2 21.717610398)
    ("n2-241" 327/2 25.215605368)
    ("n2-242" 327/2 26.387199578)
    ("n2-243" 327/2 26.387199578)
    ("n2-244" 327/2 26.387199578)
    ("n2-245" 327/2 31.056785169)
    ("n2-246" 327/2 31.056785169)
    ("n2-247" 327/2 31.056785169)
    ("n2-248" 327/2 35.726377937)
    ("n2-249" 327/2 35.726377937)
    ("n2-250" 327/2 35.726377937)
    ("n5-1802" 327/2 12.378435628)
    ("n5-1803" 327/2 12.378435628)
    ("n5-1804" 327/2 17.048023013)
    ("n5-1805" 327/2 17.048023013)
    ("n5-1806" 327/2 21.717610398)
    ("n5-1807" 327/2 21.717610398)
    ("n5-1808" 327/2 26.387199578)
    ("n5-1809" 327/2 26.387199578)
    ("n5-1810" 327/2 31.056785169)
    ("n5-1811" 327/2 31.056785169)
    ("n5-1812" 327/2 35.726377937)
    ("n5-1813" 327/2 35.726377937)
    ("n1-1974" 327/2 42.335964605)
    ("n1-1975" 327/2 42.335964605)
    ("n1-1976" 327/2 42.335964605)
    ("n1-1977" 327/2 46.749421751)
    ("n1-1978" 327/2 46.749421751)
    ("n1-1979" 327/2 46.749421751)
    ("n1-1980" 327/2 51.162875307)
    ("n1-1981" 327/2 51.162875307)
    ("n1-1982" 327/2 55.576339630)
    ("n1-1983" 327/2 55.576339630)
    ("n1-1984" 327/2 64.403246744)
    ("n1-1985" 327/2 64.403246744)
    ("n2-251" 327/2 55.576339630)
    ("n2-252" 327/2 59.989793187)
    ("n2-253" 327/2 59.989793187)
    ("n5-1814" 327/2 42.335964605)
    ("n5-1815" 327/2 42.335964605)
    ("n5-1816" 327/2 46.749421751)
    ("n5-1817" 327/2 46.749421751)
    ("n5-1818" 327/2 51.162875307)
    ("n5-1819" 327/2 51.162875307)
    ("n5-1820" 327/2 55.576339630)
    ("n5-1821" 327/2 55.576339630)
    ("n1-1986" 327/2 71.406708232)
    ("n2-254" 327/2 70.976710157)
    ("n2-255" 327/2 70.976710157)
    ("n2-256" 327/2 75.646292160)
    ("n2-257" 327/2 75.646292160)
    ("n2-258" 327/2 80.315881339)
    ("n2-259" 327/2 80.315881339)
    ("n2-260" 327/2 83.813879897)
    ("n2-261" 327/2 84.985470518)
    ("n2-262" 327/2 84.985470518)
    ("n2-263" 327/2 84.985470518)
    ("n2-264" 327/2 89.655059698)
    ("n2-265" 327/2 89.655059698)
    ("n2-266" 327/2 89.655059698)
    ("n2-267" 327/2 94.324641700)
    ("n2-268" 327/2 94.324641700)
    ("n2-269" 327/2 94.324641700)
    ("n5-1822" 327/2 70.976710157)
    ("n5-1823" 327/2 70.976710157)
    ("n5-1824" 327/2 75.646292160)
    ("n5-1825" 327/2 75.646292160)
    ("n5-1826" 327/2 80.315881339)
    ("n5-1827" 327/2 80.315881339)
    ("n5-1828" 327/2 84.985470518)
    ("n5-1829" 327/2 84.985470518)
    ("n5-1830" 327/2 89.655059698)
    ("n5-1831" 327/2 89.655059698)
    ("n5-1832" 327/2 94.324641700)
    ("n5-1833" 327/2 94.324641700)
    ("n1-1987" 327/2 100.934228368)
    ("n1-1988" 327/2 100.934228368)
    ("n1-1989" 327/2 100.934228368)
    ("n1-1990" 327/2 105.481423377)
    ("n1-1991" 327/2 105.481423377)
    ("n1-1992" 327/2 105.481423377)
    ("n1-1993" 327/2 112.564258415)
    ("n1-1994" 327/2 112.564258415)
    ("n1-1995" 327/2 112.564258415)
    ("n1-1996" 327/2 115.288438435)
    ("n1-1997" 327/2 115.288438435)
    ("n1-1998" 327/2 115.288438435)
    ("n1-1999" 327/2 119.647100630)
    ("n1-2000" 327/2 119.647100630)
    ("n1-2001" 327/2 119.647100630)
    ("n1-2002" 327/2 124.005777179)
    ("n1-2003" 327/2 124.005777179)
    ("n1-2004" 327/2 124.005777179)
    ("n5-1834" 327/2 100.934228368)
    ("n5-1835" 327/2 100.934228368)
    ("n5-1836" 327/2 105.481423377)
    ("n5-1837" 327/2 105.481423377)
    ("n5-1838" 327/2 109.840085572)
    ("n5-1839" 327/2 109.840085572)
    ("n5-1840" 327/2 115.288438435)
    ("n5-1841" 327/2 115.288438435)
    ("n5-1842" 327/2 119.647100630)
    ("n5-1843" 327/2 119.647100630)
    ("n5-1844" 327/2 124.005777179)
    ("n5-1845" 327/2 124.005777179)
    ("n1-2005" 333/2 12.378438394)
    ("n1-2006" 333/2 12.378438394)
    ("n1-2007" 333/2 12.378438394)
    ("n1-2008" 333/2 17.623515686)
    ("n1-2009" 333/2 17.623515686)
    ("n1-2010" 333/2 17.623515686)
    ("n1-2011" 333/2 26.146766510)
    ("n1-2012" 333/2 26.146766510)
    ("n1-2013" 333/2 26.146766510)
    ("n1-2014" 333/2 30.557389615)
    ("n1-2015" 333/2 30.557389615)
    ("n1-2016" 333/2 30.557389615)
    ("n1-2017" 333/2 35.802468702)
    ("n1-2018" 333/2 35.802468702)
    ("n1-2019" 333/2 35.802468702)
    ("n1-2020" 333/2 44.325717732)
    ("n1-2021" 333/2 44.325717732)
    ("n1-2022" 333/2 44.325717732)
    ("n5-1846" 333/2 12.378438394)
    ("n5-1847" 333/2 12.378438394)
    ("n5-1848" 333/2 17.623515686)
    ("n5-1849" 333/2 17.623515686)
    ("n5-1850" 333/2 22.868589390)
    ("n5-1851" 333/2 22.868589390)
    ("n5-1852" 333/2 30.557389615)
    ("n5-1853" 333/2 30.557389615)
    ("n5-1854" 333/2 35.802468702)
    ("n5-1855" 333/2 35.802468702)
    ("n1-2023" 333/2 49.343890621)
    ("n1-2024" 333/2 49.343890621)
    ("n1-2025" 333/2 49.343890621)
    ("n1-2026" 333/2 55.069829691)
    ("n1-2027" 333/2 55.069829691)
    ("n1-2028" 333/2 55.069829691)
    ("n1-2029" 333/2 64.374487407)
    ("n1-2030" 333/2 64.374487407)
    ("n1-2031" 333/2 64.374487407)
    ("n1-2032" 333/2 68.567290755)
    ("n1-2033" 333/2 68.567290755)
    ("n1-2034" 333/2 68.567290755)
    ("n1-2035" 333/2 74.293240590)
    ("n1-2036" 333/2 74.293240590)
    ("n1-2037" 333/2 74.293240590)
    ("n1-2038" 333/2 83.597891130)
    ("n1-2039" 333/2 83.597891130)
    ("n1-2040" 333/2 83.597891130)
    ("n5-1856" 333/2 49.343890621)
    ("n5-1857" 333/2 49.343890621)
    ("n5-1858" 333/2 55.069829691)
    ("n5-1859" 333/2 55.069829691)
    ("n5-1860" 333/2 60.795772349)
    ("n5-1861" 333/2 60.795772349)
    ("n5-1862" 333/2 68.567290755)
    ("n5-1863" 333/2 68.567290755)
    ("n5-1864" 333/2 74.293240590)
    ("n5-1865" 333/2 74.293240590)
    ("n1-2041" 333/2 90.319731973)
    ("n1-2042" 333/2 90.319731973)
    ("n1-2043" 333/2 90.319731973)
    ("n1-2044" 333/2 100.500355485)
    ("n1-2045" 333/2 101.686918179)
    ("n1-2046" 333/2 101.686918179)
    ("n1-2047" 333/2 101.686918179)
    ("n1-2048" 333/2 104.105432702)
    ("n1-2049" 333/2 105.291988219)
    ("n1-2050" 333/2 105.291988219)
    ("n1-2051" 333/2 105.291988219)
    ("n1-2052" 333/2 109.873556249)
    ("n1-2053" 333/2 111.060111766)
    ("n1-2054" 333/2 111.060111766)
    ("n1-2055" 333/2 111.060111766)
    ("n1-2056" 333/2 115.641672619)
    ("n1-2057" 333/2 116.828235313)
    ("n1-2058" 333/2 116.828235313)
    ("n1-2059" 333/2 116.828235313)
    ("n1-2060" 333/2 121.409796166)
    ("n1-2061" 333/2 122.596358861)
    ("n1-2062" 333/2 122.596358861)
    ("n1-2063" 333/2 122.596358861)
    ("n5-1866" 333/2 90.319731973)
    ("n5-1867" 333/2 90.319731973)
    ("n5-1868" 333/2 101.686918179)
    ("n5-1869" 333/2 101.686918179)
    ("n5-1870" 333/2 101.686918179)
    ("n5-1871" 333/2 105.291988219)
    ("n5-1872" 333/2 105.291988219)
    ("n5-1873" 333/2 105.291988219)
    ("n5-1874" 333/2 111.060111766)
    ("n5-1875" 333/2 111.060111766)
    ("n5-1876" 333/2 111.060111766)
    ("n5-1877" 333/2 116.828235313)
    ("n5-1878" 333/2 116.828235313)
    ("n5-1879" 333/2 116.828235313)
    ("n5-1880" 333/2 122.596358861)
    ("n5-1881" 333/2 122.596358861)
    ("n5-1882" 333/2 122.596358861)
    ("n1-2064" 675/4 13.857500470)
    ("n1-2065" 675/4 15.044063164)
    ("n1-2066" 675/4 15.044063164)
    ("n1-2067" 675/4 15.044063164)
    ("n1-2068" 675/4 19.943968793)
    ("n1-2069" 675/4 19.943968793)
    ("n1-2070" 675/4 19.943968793)
    ("n1-2071" 675/4 24.843874422)
    ("n1-2072" 675/4 24.843874422)
    ("n1-2073" 675/4 24.843874422)
    ("n1-2074" 675/4 29.743780051)
    ("n1-2075" 675/4 29.743780051)
    ("n1-2076" 675/4 29.743780051)
    ("n1-2077" 675/4 34.643682091)
    ("n1-2078" 675/4 34.643682091)
    ("n1-2079" 675/4 34.643682091)
    ("n1-2080" 675/4 39.543591308)
    ("n1-2081" 675/4 39.543591308)
    ("n1-2082" 675/4 39.543591308)
    ("n5-1883" 675/4 15.044063164)
    ("n5-1884" 675/4 19.943968793)
    ("n5-1885" 675/4 19.943968793)
    ("n5-1886" 675/4 19.943968793)
    ("n5-1887" 675/4 24.843874422)
    ("n5-1888" 675/4 24.843874422)
    ("n5-1889" 675/4 24.843874422)
    ("n5-1890" 675/4 29.743780051)
    ("n5-1891" 675/4 29.743780051)
    ("n5-1892" 675/4 29.743780051)
    ("n5-1893" 675/4 34.643682091)
    ("n5-1894" 675/4 34.643682091)
    ("n5-1895" 675/4 34.643682091)
    ("n5-1896" 675/4 39.543591308)
    ("n5-1897" 675/4 39.543591308)
    ("n5-1898" 675/4 39.543591308)
    ("n1-2083" 675/4 47.703494001)
    ("n1-2084" 675/4 47.703494001)
    ("n1-2085" 675/4 47.703494001)
    ("n1-2086" 675/4 47.703494001)
    ("n1-2087" 675/4 51.641170077)
    ("n1-2088" 675/4 51.641170077)
    ("n1-2089" 675/4 51.641170077)
    ("n1-2090" 675/4 51.641170077)
    ("n1-2091" 675/4 55.578849742)
    ("n1-2092" 675/4 55.578849742)
    ("n1-2093" 675/4 55.578849742)
    ("n1-2094" 675/4 55.578849742)
    ("n1-2095" 675/4 59.516536583)
    ("n1-2096" 675/4 59.516536583)
    ("n1-2097" 675/4 59.516536583)
    ("n1-2098" 675/4 59.516536583)
    ("n1-2099" 675/4 63.454209071)
    ("n1-2100" 675/4 63.454209071)
    ("n1-2101" 675/4 63.454209071)
    ("n1-2102" 675/4 63.454209071)
    ("n1-2103" 675/4 67.391888735)
    ("n1-2104" 675/4 67.391888735)
    ("n1-2105" 675/4 67.391888735)
    ("n1-2106" 675/4 67.391888735)
    ("n5-1899" 675/4 47.703494001)
    ("n5-1900" 675/4 47.703494001)
    ("n5-1901" 675/4 51.641170077)
    ("n5-1902" 675/4 51.641170077)
    ("n5-1903" 675/4 55.578849742)
    ("n5-1904" 675/4 55.578849742)
    ("n5-1905" 675/4 59.516536583)
    ("n5-1906" 675/4 59.516536583)
    ("n5-1907" 675/4 63.454209071)
    ("n5-1908" 675/4 63.454209071)
    ("n5-1909" 675/4 67.391888735)
    ("n5-1910" 675/4 67.391888735)
    ("n1-2107" 675/4 72.889565101)
    ("n1-2108" 675/4 72.889565101)
    ("n1-2109" 675/4 72.889565101)
    ("n1-2110" 675/4 72.889565101)
    ("n1-2111" 675/4 76.867911248)
    ("n1-2112" 675/4 76.867911248)
    ("n1-2113" 675/4 76.867911248)
    ("n1-2114" 675/4 76.867911248)
    ("n1-2115" 675/4 80.846264573)
    ("n1-2116" 675/4 80.846264573)
    ("n1-2117" 675/4 80.846264573)
    ("n1-2118" 675/4 80.846264573)
    ("n1-2119" 675/4 84.824610720)
    ("n1-2120" 675/4 84.824610720)
    ("n1-2121" 675/4 84.824610720)
    ("n1-2122" 675/4 84.824610720)
    ("n1-2123" 675/4 88.802956867)
    ("n1-2124" 675/4 88.802956867)
    ("n1-2125" 675/4 88.802956867)
    ("n1-2126" 675/4 88.802956867)
    ("n1-2127" 675/4 92.781310191)
    ("n1-2128" 675/4 92.781310191)
    ("n1-2129" 675/4 92.781310191)
    ("n1-2130" 675/4 92.781310191)
    ("n5-1911" 675/4 72.889565101)
    ("n5-1912" 675/4 72.889565101)
    ("n5-1913" 675/4 76.867911248)
    ("n5-1914" 675/4 76.867911248)
    ("n5-1915" 675/4 76.867911248)
    ("n5-1916" 675/4 80.846264573)
    ("n5-1917" 675/4 80.846264573)
    ("n5-1918" 675/4 80.846264573)
    ("n5-1919" 675/4 84.824610720)
    ("n5-1920" 675/4 84.824610720)
    ("n5-1921" 675/4 84.824610720)
    ("n5-1922" 675/4 88.802956867)
    ("n5-1923" 675/4 88.802956867)
    ("n5-1924" 675/4 88.802956867)
    ("n5-1925" 675/4 92.781310191)
    ("n5-1926" 675/4 92.781310191)
    ("n5-1927" 675/4 92.781310191)
    ("n1-2131" 675/4 99.829344168)
    ("n1-2132" 675/4 99.829344168)
    ("n1-2133" 675/4 98.642781474)
    ("n1-2134" 675/4 99.829344168)
    ("n1-2135" 675/4 104.585190972)
    ("n1-2136" 675/4 103.398635455)
    ("n1-2137" 675/4 104.585190972)
    ("n1-2138" 675/4 104.585190972)
    ("n1-2139" 675/4 109.341059307)
    ("n1-2140" 675/4 108.154496613)
    ("n1-2141" 675/4 109.341059307)
    ("n1-2142" 675/4 109.341059307)
    ("n1-2143" 675/4 114.096906111)
    ("n1-2144" 675/4 112.910343417)
    ("n1-2145" 675/4 114.096906111)
    ("n1-2146" 675/4 114.096906111)
    ("n1-2147" 675/4 118.852774446)
    ("n1-2148" 675/4 118.852774446)
    ("n1-2149" 675/4 118.852774446)
    ("n1-2150" 675/4 123.608628427)
    ("n1-2151" 675/4 123.608628427)
    ("n1-2152" 675/4 123.608628427)
    ("n5-1928" 675/4 99.829344168)
    ("n5-1929" 675/4 99.829344168)
    ("n5-1930" 675/4 104.585190972)
    ("n5-1931" 675/4 104.585190972)
    ("n5-1932" 675/4 103.398635455)
    ("n5-1933" 675/4 104.585190972)
    ("n5-1934" 675/4 109.341059307)
    ("n5-1935" 675/4 109.341059307)
    ("n5-1936" 675/4 108.154496613)
    ("n5-1937" 675/4 109.341059307)
    ("n5-1938" 675/4 114.096906111)
    ("n5-1939" 675/4 114.096906111)
    ("n5-1940" 675/4 112.910343417)
    ("n5-1941" 675/4 114.096906111)
    ("n5-1942" 675/4 118.852774446)
    ("n5-1943" 675/4 118.852774446)
    ("n5-1944" 675/4 118.852774446)
    ("n5-1945" 675/4 123.608628427)
    ("n5-1946" 675/4 123.608628427)
    ("n5-1947" 675/4 123.608628427)
    ("n1-2153" 687/4 11.257813394)
    ("n1-2154" 687/4 11.257813394)
    ("n1-2155" 687/4 11.257813394)
    ("n1-2156" 687/4 16.765735331)
    ("n1-2157" 687/4 16.765735331)
    ("n1-2158" 687/4 16.765735331)
    ("n1-2159" 687/4 22.273657268)
    ("n1-2160" 687/4 22.273657268)
    ("n1-2161" 687/4 22.273657268)
    ("n1-2162" 687/4 27.781579205)
    ("n1-2163" 687/4 27.781579205)
    ("n1-2164" 687/4 27.781579205)
    ("n1-2165" 687/4 32.102938447)
    ("n1-2166" 687/4 33.289501142)
    ("n1-2167" 687/4 33.289501142)
    ("n1-2168" 687/4 37.610856796)
    ("n1-2169" 687/4 38.797419490)
    ("n1-2170" 687/4 38.797419490)
    ("n5-1948" 687/4 11.257813394)
    ("n5-1949" 687/4 11.257813394)
    ("n5-1950" 687/4 11.257813394)
    ("n5-1951" 687/4 16.765735331)
    ("n5-1952" 687/4 16.765735331)
    ("n5-1953" 687/4 16.765735331)
    ("n5-1954" 687/4 16.765735331)
    ("n5-1955" 687/4 22.273657268)
    ("n5-1956" 687/4 22.273657268)
    ("n5-1957" 687/4 22.273657268)
    ("n5-1958" 687/4 22.273657268)
    ("n5-1959" 687/4 27.781579205)
    ("n5-1960" 687/4 27.781579205)
    ("n5-1961" 687/4 27.781579205)
    ("n5-1962" 687/4 27.781579205)
    ("n5-1963" 687/4 33.289501142)
    ("n5-1964" 687/4 33.289501142)
    ("n5-1965" 687/4 33.289501142)
    ("n5-1966" 687/4 38.797419490)
    ("n5-1967" 687/4 38.797419490)
    ("n5-1968" 687/4 38.797419490)
    ("n1-2171" 687/4 46.045340784)
    ("n1-2172" 687/4 47.141939831)
    ("n1-2173" 687/4 48.238531701)
    ("n1-2174" 687/4 49.335119982)
    ("n1-2175" 687/4 50.506718042)
    ("n1-2176" 687/4 68.542600903)
    ("n1-2177" 687/4 72.300080537)
    ("n1-2178" 687/4 76.057560170)
    ("n1-2179" 687/4 79.815039803)
    ("n1-2180" 687/4 83.572512259)
    ("n1-2181" 687/4 87.329991892)
    ("n5-1969" 687/4 50.506718042)
    ("n5-1970" 687/4 50.506718042)
    ("n5-1971" 687/4 62.530643538)
    ("n5-1972" 687/4 62.530643538)
    ("n5-1973" 687/4 62.530643538)
    ("n5-1974" 687/4 68.542600903)
    ("n5-1975" 687/4 68.542600903)
    ("n5-1976" 687/4 68.542600903)
    ("n1-2182" 687/4 92.647468227)
    ("n1-2183" 687/4 96.292056384)
    ("n1-2184" 687/4 99.936658896)
    ("n1-2185" 687/4 103.581247053)
    ("n1-2186" 687/4 107.225835210)
    ("n1-2187" 687/4 110.870423367)
    ("n1-2188" 687/4 114.515025879)
    ("n1-2189" 687/4 122.533127002)
    ("n1-2190" 687/4 122.533127002)
    ("n5-1977" 687/4 92.647468227)
    ("n5-1978" 687/4 107.225835210)
    ("n5-1979" 687/4 114.515025879)
    ("n5-1980" 687/4 122.533127002)
    ("n6-172" 687/4 92.647468227)
    ("n6-173" 687/4 107.225835210)
    ("n6-174" 687/4 114.515025879)
    ("n1-2191" 174 11.257813394)
    ("n1-2192" 174 12.354407058)
    ("n1-2193" 174 13.451000722)
    ("n1-2194" 174 14.547594386)
    ("n1-2195" 174 15.719187063)
    ("n1-2196" 174 29.517465979)
    ("n1-2197" 174 32.280891989)
    ("n1-2198" 174 35.044317999)
    ("n1-2199" 174 37.807744009)
    ("n1-2200" 174 40.571166430)
    ("n1-2201" 174 43.638356566)
    ("n5-1981" 174 15.719187063)
    ("n5-1982" 174 15.719187063)
    ("n5-1983" 174 24.562151730)
    ("n5-1984" 174 24.562151730)
    ("n5-1985" 174 24.562151730)
    ("n5-1986" 174 29.517465979)
    ("n5-1987" 174 29.517465979)
    ("n5-1988" 174 29.517465979)
    ("n1-2202" 174 47.961779277)
    ("n1-2203" 174 50.628340683)
    ("n1-2204" 174 53.062207413)
    ("n1-2205" 174 55.496059788)
    ("n1-2206" 174 57.929919341)
    ("n1-2207" 174 60.363771716)
    ("n1-2208" 174 62.797638447)
    ("n1-2209" 174 68.152120850)
    ("n1-2210" 174 68.152120850)
    ("n5-1989" 174 47.961779277)
    ("n5-1990" 174 57.929919341)
    ("n5-1991" 174 62.797638447)
    ("n5-1992" 174 68.152120850)
    ("n6-175" 174 47.961779277)
    ("n6-176" 174 57.929919341)
    ("n6-177" 174 62.797638447)
    ("n1-2211" 174 73.786294774)
    ("n1-2212" 174 76.127007555)
    ("n1-2213" 174 78.467720336)
    ("n1-2214" 174 80.808433117)
    ("n1-2215" 174 83.149145897)
    ("n1-2216" 174 85.726701823)
    ("n1-2217" 174 86.823297281)
    ("n1-2218" 174 87.919885562)
    ("n1-2219" 174 89.091483622)
    ("n1-2220" 174 94.241054611)
    ("n1-2221" 174 96.581767392)
    ("n5-1993" 174 73.786294774)
    ("n5-1994" 174 83.149145897)
    ("n5-1995" 174 89.091483622)
    ("n5-1996" 174 89.091483622)
    ("n1-2222" 174 100.282474720)
    ("n1-2223" 174 102.743930924)
    ("n1-2224" 174 105.205379951)
    ("n1-2225" 174 107.876664008)
    ("n1-2226" 174 111.704043196)
    ("n1-2227" 174 114.661600342)
    ("n1-2228" 174 115.758188623)
    ("n1-2229" 174 116.854791259)
    ("n1-2230" 174 118.026367787)
    ("n1-2231" 174 123.441570000)
    ("n1-2232" 174 125.903019027)
    ("n5-1997" 174 100.282474720)
    ("n5-1998" 174 111.704043196)
    ("n5-1999" 174 118.026367787)
    ("n5-2000" 174 118.026367787)
    ("n1-2233" 177 12.029372161)
    ("n1-2234" 177 16.701044547)
    ("n1-2235" 177 19.620837769)
    ("n1-2236" 177 22.540632785)
    ("n1-2237" 177 25.460426007)
    ("n1-2238" 177 28.380219229)
    ("n1-2239" 177 31.300016040)
    ("n1-2240" 177 34.219809262)
    ("n1-2241" 177 37.139602485)
    ("n1-2242" 177 40.059399295)
    ("n1-2243" 177 42.979192517)
    ("n5-2001" 177 12.029372161)
    ("n5-2002" 177 12.029372161)
    ("n5-2003" 177 12.029372161)
    ("n1-2244" 177 47.859976775)
    ("n1-2245" 177 50.429260308)
    ("n1-2246" 177 52.998547430)
    ("n1-2247" 177 55.567834552)
    ("n1-2248" 177 58.137114497)
    ("n1-2249" 177 60.706401619)
    ("n5-2004" 177 63.275681563)
    ("n5-2005" 177 65.844968685)
    ("n5-2006" 177 68.414255807)
    ("n5-2007" 177 70.983535752)
    ("n5-2008" 177 73.552822873)
    ("n5-2009" 177 76.122109995)
    ("n1-2250" 177 89.960539126)
    ("n1-2251" 177 89.960539126)
    ("n1-2252" 177 89.960539126)
    ("n1-2253" 177 91.147094378)
    ("n5-2010" 177 80.431392497)
    ("n5-2011" 177 89.960539126)
    ("n5-2012" 177 89.960539126)
    ("n1-2254" 177 98.850972353)
    ("n1-2255" 177 98.850972353)
    ("n1-2256" 177 98.850972353)
    ("n1-2257" 177 98.850972353)
    ("n1-2258" 177 106.961493530)
    ("n1-2259" 177 108.148055959)
    ("n1-2260" 177 106.961493530)
    ("n1-2261" 177 106.961493530)
    ("n1-2262" 177 108.148055959)
    ("n5-2013" 177 98.850972353)
    ("n5-2014" 177 98.850972353)
    ("n5-2015" 177 106.961493530)
    ("n5-2016" 177 106.961493530)
    ("n1-2263" 177 116.812002911)
    ("n1-2264" 177 116.812002911)
    ("n1-2265" 177 116.812002911)
    ("n5-2017" 177 116.812002911)
    ("n5-2018" 177 116.812002911)))

#(define concerto-spaced-systems (make-hash-table))
#(define (concerto-interpolate-x x knots)
   (cond ((null? knots) x)
         ((null? (cdr knots)) (+ x (- (cdar knots) (caar knots))))
         ((< x (caar knots)) (+ x (- (cdar knots) (caar knots))))
         (else
          (let loop ((left (car knots)) (right (cdr knots)))
            (if (null? right) (+ x (- (cdr left) (car left)))
                (let ((b (car right)))
                  (if (<= x (car b))
                      (if (< (abs (- (car b) (car left))) 0.000001)
                          (cdr left)
                          (+ (cdr left)
                             (* (/ (- x (car left)) (- (car b) (car left)))
                                (- (cdr b) (cdr left)))))
                      (loop b (cdr right)))))))))
% A bar preceding grace notes may belong to a negative grace-time column.
#(define (concerto-paper-column-of grob)
   (let loop ((g grob) (depth 0))
     (cond ((or (not (ly:grob? g)) (> depth 12)) #f)
           ((memq 'paper-column-interface (ly:grob-interfaces g)) g)
           (else (loop (ly:grob-parent g X) (+ depth 1))))))


referenceNotes =
#(define-music-function (voice music) (integer? ly:music?)
   (let ((index 0) (seen (make-hash-table)))
     (concerto-complete-special-beam-events
     (music-selective-map
       (lambda (m) (not (eq? (ly:music-property m 'name) 'InitialContextMusic)))
       (lambda (m)
         (unless (hashq-ref seen m #f)
           (hashq-set! seen m #t)
           (when (eq? (ly:music-property m 'name) 'NoteEvent)
             (set! index (+ index 1))
             (for-each (lambda (grob)
               (set! (ly:music-property m 'tweaks)
                 (acons (cons grob 'output-attributes)
                   (list (cons 'data-nid (format #f "n~a-~a" voice index)))
                   (ly:music-property m 'tweaks))))
             '(NoteHead Accidental AccidentalCautionary Dots))
             (concerto-source-note-properties (format #f "n~a-~a" voice index) m)
             (op47-source-accidental-properties (format #f "n~a-~a" voice index) m)))
         m) music))))

#(define (concerto-head-voice-rank grob)
   (let* ((attrs (ly:grob-property grob 'output-attributes '()))
          (name (assoc-get 'data-voice attrs ""))
          (entry (assoc name '(("PartPOneVoiceOne" . 1) ("PartPOneVoiceTwo" . 2)
            ("PartPOneVoiceThree" . 3) ("PartPOneVoiceFour" . 4)
            ("PartPOneVoiceFive" . 5) ("PartPOneVoiceSix" . 6)
            ("PartPOneVoiceSeven" . 7) ("PartPOneVoiceEight" . 8)))))
     (if entry (cdr entry) 99)))
#(define (concerto-left-head-offset column all)
   (let* ((heads (filter (lambda (g)
                  (and (eq? (assoc-get 'name (ly:grob-property g 'meta)) 'NoteHead)
                       (eq? column (concerto-paper-column-of g))
                       (not (ly:grob-property g 'transparent #f))
                       (not (eq? #f (ly:grob-property-data g 'stencil)))
                       (< (concerto-head-voice-rank g) 99))) all)))
     (if (null? heads) 0
         (let* ((rank (apply min (map concerto-head-voice-rank heads)))
                (chosen (filter (lambda (g) (= rank (concerto-head-voice-rank g))) heads)))
           (apply min (map (lambda (g) (ly:grob-relative-coordinate g column X)) chosen))))))

#(define (concerto-native-note-target column all start origin space)
   (let* ((heads (filter (lambda (g)
                  (and (eq? (assoc-get 'name (ly:grob-property g 'meta)) 'NoteHead)
                       (eq? column (concerto-paper-column-of g))
                       (not (ly:grob-property g 'transparent #f)))) all))
          (records (filter-map (lambda (g)
                     (let* ((attrs (ly:grob-property g 'output-attributes '()))
                            (nid (assoc-get 'data-nid attrs #f))
                            (ref (and nid (hash-ref concerto-note-targets nid #f))))
                       (and ref (= (car ref) start)
                         (list g (concerto-head-voice-rank g) (cadr ref))))) heads)))
     (if (null? records) #f
         (let* ((rank (apply min (map cadr records)))
                (chosen (filter (lambda (r) (= (cadr r) rank)) records))
                (reference (car (sort chosen (lambda (a b) (< (caddr a) (caddr b)))))))
           (- (+ origin (* space (caddr reference)))
              (ly:grob-relative-coordinate (car reference) column X))))))

#(define (concerto-place-columns-base system)
   (if (not (hashq-ref concerto-spaced-systems system))
     (begin
       (hashq-set! concerto-spaced-systems system #t)
       (let* ((array (ly:grob-object system 'columns))
              (columns (if (ly:grob-array? array) (ly:grob-array->list array) '()))
              (all-array (ly:grob-object system 'all-elements))
              (all (if (ly:grob-array? all-array) (ly:grob-array->list all-array) '()))
              (bar-columns (filter-map
                (lambda (g)
                  (and (eq? (assoc-get 'name (ly:grob-property g 'meta)) 'BarLine)
                       (concerto-paper-column-of g))) all))
              (first (and (pair? columns) (car columns)))
              (last-column (and (pair? columns) (car (reverse columns))))
              (moment (and first (ly:grob-property first 'when)))
              (start (and (ly:moment? moment) (ly:moment-main moment)))
              (profile (and start (assoc start concerto-spacing-profiles))))
         (if profile
           (let* ((music (cadr profile)) (bars (caddr profile))
                  (origin (ly:grob-relative-coordinate first system X))
                  (space (ly:staff-symbol-staff-space first))
                  (items
                   (map
                    (lambda (c)
                      (let* ((m (ly:grob-property c 'when))
                             (x (ly:grob-relative-coordinate c system X))
                             (time (and (ly:moment? m) (- (ly:moment-main m) start)))
                             (plain (and (ly:moment? m) (= (ly:moment-grace m) 0)))
                             (nonmusic (memq 'non-musical-paper-column-interface (ly:grob-interfaces c)))
                             (bar (and nonmusic
                               (find (lambda (g)
                                 (and (eq? (assoc-get 'name (ly:grob-property g 'meta)) 'BarLine)
                                      (eq? c (concerto-paper-column-of g)))) all)))
                             (headtarget (and (not nonmusic) (concerto-native-note-target c all start origin space)))
                             (target (and time (or plain bar)
                                          (assoc time (if nonmusic bars music))))
                             (bar-offset (if (ly:grob? bar)
                               (let ((ex (ly:grob-extent bar c X)))
                                 (* 0.5 (+ (car ex) (cdr ex)))) 0)))
                        (list c x
                          (cond ((eq? c first) origin)
                                ((eq? c last-column) (+ origin (* space (cadddr profile))))
                                (headtarget headtarget)
                                (target (- (+ origin (* space (cdr target))) bar-offset (if nonmusic 0 (concerto-left-head-offset c all))))
                                (else #f)) )))
                    columns))
                  (knots (filter-map (lambda (i) (and (caddr i) (cons (cadr i) (caddr i)))) items)))
             (if (pair? knots)
               (for-each
                (lambda (i)
                  (let* ((x (cadr i)) (new (or (caddr i) (concerto-interpolate-x x knots))))
                    (ly:grob-translate-axis! (car i) (- new x) X)))
                items))))))))

% Source-confirmed secondary voice columns displaced by native collision shifts.
% Keep all native notes, stems and beams; translate the affected NoteColumn.
#(define concerto-repaired-note-column-systems (make-hash-table))
#(define (concerto-note-column-of grob)
   (let loop ((g grob) (depth 0))
     (cond ((or (not (ly:grob? g)) (> depth 12)) #f)
           ((memq 'note-column-interface (ly:grob-interfaces g)) g)
           (else (loop (ly:grob-parent g X) (+ depth 1))))))
#(define (concerto-place-columns system)
   (concerto-place-columns-base system)
   (unless (hashq-ref concerto-repaired-note-column-systems system)
     (hashq-set! concerto-repaired-note-column-systems system #t)
     (let* ((array (ly:grob-object system 'all-elements))
            (all (if (ly:grob-array? array) (ly:grob-array->list array) '()))
            (ca (ly:grob-object system 'columns))
            (columns (if (ly:grob-array? ca) (ly:grob-array->list ca) '()))
            (first (and (pair? columns) (car columns)))
            (moment (and first (ly:grob-property first 'when)))
            (start (and (ly:moment? moment) (ly:moment-main moment)))
            (origin (if first (ly:grob-relative-coordinate first system X) 0))
            (space (if first (ly:staff-symbol-staff-space first) 1))
            (done (make-hash-table)))
       (for-each
         (lambda (head)
           (when (eq? (assoc-get 'name (ly:grob-property head 'meta)) 'NoteHead)
             (let* ((attrs (ly:grob-property head 'output-attributes '()))
                    (nid (assoc-get 'data-nid attrs #f))
                    (target (and nid (member nid concerto-repair-note-column-nids)
                                 (hash-ref concerto-note-targets nid #f)))
                    (column (and target (concerto-note-column-of head))))
               (when (and target start (= (car target) start)
                          (ly:grob? column) (not (hashq-ref done column)))
                 (hashq-set! done column #t)
                 (ly:grob-translate-axis! column
                   (- (+ origin (* space (cadr target)))
                      (ly:grob-relative-coordinate head system X)) X)))))
         all))))




% Three source-proven head-side flips before local NoteColumn placement.
% Include after spacing-profiles.ily; this leaves global collision rules intact.
#(define op47-source-head-flips (make-hash-table))
#(for-each (lambda (entry) (hash-set! op47-source-head-flips (car entry) (cdr entry)))
  '(
    ("n6-117" . 1.186555509962)
    ("n6-127" . 1.186562687244)
    ("n6-142" . 1.186569864527)
  ))
#(define op47-head-flipped-systems (make-hash-table))
#(define op47-unflipped-place-columns-base concerto-place-columns-base)
#(define (concerto-place-columns-base system)
   (op47-unflipped-place-columns-base system)
   (unless (hashq-ref op47-head-flipped-systems system #f)
     (hashq-set! op47-head-flipped-systems system #t)
     (let* ((array (ly:grob-object system 'all-elements))
            (all (if (ly:grob-array? array) (ly:grob-array->list array) '())))
       (for-each (lambda (head)
         (when (eq? (assoc-get 'name (ly:grob-property head 'meta)) 'NoteHead)
           (let* ((attrs (ly:grob-property head 'output-attributes '()))
                  (nid (assoc-get 'data-nid attrs #f))
                  (shift (and nid (hash-ref op47-source-head-flips nid #f))))
             (when shift
               (ly:grob-translate-axis! head
                 (- (* shift (ly:staff-symbol-staff-space head))) X))))) all))))


% Source-evidenced local Dot positions; all actual native Dot grobs retained.
#(define op47-source-dot-targets (make-hash-table))
#(for-each (lambda (entry) (hash-set! op47-source-dot-targets (car entry) (cdr entry)))
  '(
    ("n5-378" 48.447519644412 3.500000662883)
    ("n7-1" 48.447519644412 -0.500001109275)
    ("n6-44" 14.460813778419 1.500001785019)
    ("n5-755" 72.626047314574 3.500000662883)
    ("n7-4" 72.626047314574 -0.500001109275)
    ("n5-778" 47.914276393896 3.500000458565)
    ("n7-5" 47.914276393896 -0.499992362735)
    ("n5-783" 74.639872075863 3.500000458565)
    ("n7-6" 74.639872075863 -0.499992362735)
    ("n6-64" 81.117996010279 2.499998190728)
    ("n6-67" 97.793959586587 2.499998190728)
    ("n1-1146" 42.665432611017 -1.499994616372)
    ("n2-138" 56.832390501718 0.499998198720)
    ("n1-1154" 73.545912797026 -1.499994616372)
    ("n2-139" 86.307809991217 0.499998198720)
    ("n5-1044" 48.005014863876 2.500002014165)
    ("n7-7" 48.005014863876 -1.499999757993)
    ("n5-1067" 24.080118119528 2.499998200741)
    ("n7-8" 24.080118119528 -1.500001784008)
    ("n5-1072" 47.274539847165 2.499998200741)
    ("n7-9" 47.274539847165 -1.500001784008)
    ("n2-195" 47.664252605983 -1.499998323984)
    ("n2-196" 61.183849056884 -1.499998323984)
    ("n2-197" 76.432506310774 -1.499998323984)
    ("n5-343" 47.929448926443 -1.500016150241)
    ("n5-347" 55.711212857486 -1.500016150241)
    ("n5-404" 26.167926719366 3.499996849532)
    ("n5-409" 52.460660884337 3.499996849532)
    ("n6-63" 81.117996010279 2.499998190728)
    ("n6-66" 97.793959586587 2.499998190728)
  ))
#(define op47-positioned-source-dots (make-hash-table))
#(define (op47-position-source-dots grob)
   (unless (hashq-ref op47-positioned-source-dots grob #f)
     (hashq-set! op47-positioned-source-dots grob #t)
     (let* ((head (ly:grob-parent grob Y))
            (attrs (if (ly:grob? head) (ly:grob-property head 'output-attributes '()) '()))
            (nid (assoc-get 'data-nid attrs #f))
            (target (and nid (hash-ref op47-source-dot-targets nid #f)))
            (staff (ly:grob-object grob 'staff-symbol))
            (system (ly:grob-system grob)))
       ;; Identity-only annotation also covers the other unchanged visible dots.
       (when nid
         (ly:grob-set-property! grob 'output-attributes
           (acons 'data-nid nid (ly:grob-property grob 'output-attributes '()))))
       (when (and target (ly:grob? staff) (ly:grob? system))
         (concerto-place-columns system)
         (let* ((space (ly:staff-symbol-staff-space grob))
                (left (ly:spanner-bound staff LEFT))
                (origin (ly:grob-relative-coordinate left system X))
                (common (ly:grob-common-refpoint grob staff Y))
                (now-x (ly:grob-relative-coordinate grob system X))
                (now-y (- (ly:grob-relative-coordinate grob common Y)
                          (ly:grob-relative-coordinate staff common Y))))
           (ly:grob-translate-axis! grob (- (+ origin (* space (car target))) now-x) X)
           (ly:grob-translate-axis! grob (- (* space (cadr target)) now-y) Y))))))




% Current-score print coordinates are staff spaces from the source staff's
% left edge and centre line. Stencils use native text/music fonts and paths.
#(define-markup-command (referenceText layout props width content) (number? markup?)
   (let* ((stencil (interpret-markup layout props content))
          (extent (stencil-true-extent stencil X))
          (natural (- (cdr extent) (car extent))))
     (if (> natural 0)
         (let ((scale (/ width natural)))
           (ly:stencil-translate-axis (ly:stencil-scale stencil scale 1)
             (- (* scale (car extent))) X))
         stencil)))
#(define-markup-command (referenceInkBox layout props width height content) (number? number? markup?)
   (let* ((stencil (interpret-markup layout props content))
          (xx (stencil-true-extent stencil X)) (yy (stencil-true-extent stencil Y))
          (sx (/ width (- (cdr xx) (car xx)))) (sy (/ height (- (cdr yy) (car yy)))))
     (ly:stencil-translate (ly:stencil-scale stencil sx sy)
       (cons (- (* sx (car xx))) (- (* sy (car yy)))))))
#(define (concerto-staff-of grob)
   (let ((staff (ly:grob-object grob 'staff-symbol))) (and (ly:grob? staff) staff)))
#(define (concerto-relative-y object reference)
   (let ((common (ly:grob-common-refpoint object reference Y)))
     (- (ly:grob-relative-coordinate object common Y)
        (ly:grob-relative-coordinate reference common Y))))
#(define (concerto-mark-offset x y)
   (lambda (grob)
     (let ((staff (concerto-staff-of grob)) (system (ly:grob-system grob)))
       (if (and (ly:grob? staff) (ly:grob? system))
           (begin
             (concerto-place-columns system)
             (let* ((space (ly:staff-symbol-staff-space grob))
                    (left (ly:spanner-bound staff LEFT))
                    (origin (ly:grob-relative-coordinate left system X))
                    (now-x (ly:grob-relative-coordinate grob system X))
                    (now-y (concerto-relative-y grob staff)))
               (cons (- (+ origin (* space x)) now-x) (- (* space y) now-y))))
           '(0 . 0)))))
markAt =
#(define-music-function (x y content role identifier) (number? number? markup? string? string?)
   #{ <>-\tweak outside-staff-priority ##f
        -\tweak X-offset #0 -\tweak Y-offset #0
        -\tweak X-extent #'(+inf.0 . -inf.0)
        -\tweak Y-extent #'(+inf.0 . -inf.0)
        -\tweak self-alignment-X #LEFT
        -\tweak extra-offset #(concerto-mark-offset x y)
        -\tweak output-attributes #`((data-role . ,role) (data-did . ,identifier))
        ^\markup #content #})

referenceMarksUpper = {
  \markAt #12.7179083264 #-6.5200708366 \markup { \referenceInkBox #1.8043647843 #1.6117535211 { \dynamic "p" } } "dynamics" "op47-dynamics-0009" % source p1 system 1, print m1; anchor m1
  \markAt #9.3787997659 #4.0000000116 \markup { \referenceText #10.1142492623 { \override #'(font-name . "Nimbus Roman, Bold") \abs-fontsize #10.2382498085 "Allegretto" } } "words" "op47-words-0002" % source p1 system 1, print m1; anchor m1
  s1*9/2
  \markAt #-0.3442796067 #3.9999999985 \markup { \referenceText #0.6864009190 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "7" } } "bar_number" "op47-bar_number-0004" % source p1 system 2, print m7; anchor m7
  \markAt #110.5822392200 #-6.5200750935 \markup { \referenceInkBox #1.8043647843 #1.6117535211 { \dynamic "p" } } "dynamics" "op47-dynamics-0006" % source p1 system 2, print m11; anchor m7
  \markAt #79.9608654192 #-6.5634143151 \markup { \referenceInkBox #3.1528425938 #2.4293435626 { \dynamic "mf" } } "dynamics" "op47-dynamics-0007" % source p1 system 2, print m10; anchor m7
  \markAt #51.6060962001 #-6.5634143151 \markup { \referenceInkBox #2.0217198817 #2.4293435626 { \dynamic "f" } } "dynamics" "op47-dynamics-0008" % source p1 system 2, print m9; anchor m7
  \markAt #15.3718012082 #-5.1310607868 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 0.0000000000) (lineto 13.2644452055 -0.5644430261) (moveto 0.0000000000 0.0000000000) (lineto 13.2644452055 0.5644430261)) } "wedge" "op47-wedge-0001" % source p1 system 2, print m7; anchor m7
  \markAt #35.5116308611 #-5.1310607868 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 -0.5644430261) (lineto 6.6792580263 0.0000000000) (moveto 0.0000000000 0.5644430261) (lineto 6.6792580263 0.0000000000)) } "wedge" "op47-wedge-0002" % source p1 system 2, print m8; anchor m7
  s1*15/4
  \markAt #-0.6929233099 #4.0000071890 \markup { \referenceText #1.3798759733 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "12" } } "bar_number" "op47-bar_number-0003" % source p1 system 3, print m12; anchor m12
  \markAt #54.5001492397 #-6.5634131627 \markup { \referenceInkBox #3.1528425938 #2.4293435626 { \dynamic "mf" } } "dynamics" "op47-dynamics-0004" % source p1 system 3, print m14; anchor m12
  \markAt #29.8099957058 #-6.5634131627 \markup { \referenceInkBox #2.0217198817 #2.4293435626 { \dynamic "f" } } "dynamics" "op47-dynamics-0005" % source p1 system 3, print m13; anchor m12
  \markAt #77.0691251908 #6.6762292166 \markup { \referenceText #0.9372268673 { \override #'(font-name . "Nimbus Roman, Italic") \abs-fontsize #8.6322503829 "8" } } "tuplet_number" "op47-tuplet_number-0001" % source p1 system 3, print m14; anchor m12
  \markAt #69.3909844016 #-5.4999946249 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 0.0000000000) (lineto 11.9003721667 -0.5644430261) (moveto 0.0000000000 0.0000000000) (lineto 11.9003721667 0.5644430261)) } "wedge" "op47-wedge-0004" % source p1 system 3, print m14; anchor m12
  s1*15/4
  \markAt #-0.6694047907 #4.0000000056 \markup { \referenceText #1.3400504184 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "17" } } "bar_number" "op47-bar_number-0002" % source p1 system 4, print m17; anchor m17
  \markAt #68.3002714008 #-6.5200658742 \markup { \referenceInkBox #1.8043647843 #1.6117535211 { \dynamic "p" } } "dynamics" "op47-dynamics-0002" % source p1 system 4, print m19; anchor m17
  s1*15/4
  \markAt #-0.7755137643 #4.0000071961 \markup { \referenceText #1.5095027606 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "22" } } "bar_number" "op47-bar_number-0001" % source p1 system 5, print m22; anchor m22
  \markAt #109.9142267256 #4.3320352777 \markup { \referenceInkBox #2.3984376412 #2.2031252761 { \musicglyph "scripts.trill" } } "reference-trill" "op47-reference-trill-0001" % source p1 system 5, print m26; anchor m22
  \markAt #47.0016280401 #4.5889175782 \markup { \referenceText #2.9738295031 { \override #'(font-name . "Nimbus Roman, Italic") \abs-fontsize #10.2382498085 "ten." } } "words" "op47-words-0001" % source p1 system 5, print m23; anchor m22
  s1*15/4
  \markAt #-0.7519953122 #4.0000004674 \markup { \referenceText #1.4696780532 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "27" } } "bar_number" "op47-bar_number-0009" % source p2 system 6, print m27; anchor m27
  \markAt #55.1057477349 #-6.5634081450 \markup { \referenceInkBox #2.0217194300 #2.4293430198 { \dynamic "f" } } "dynamics" "op47-dynamics-0013" % source p2 system 6, print m29; anchor m27
  \markAt #104.1266254842 #7.0415051214 \markup { \override #'(line-cap-style . square) \path #0.0999999821 #'((moveto 0.0000000000 0.0000000000) (lineto 0.2999999300 0.0000000000) (moveto 0.5999998601 0.0000000000) (lineto 0.6406369138 0.0000000000) (moveto 0.6406369138 0.0000000000) (lineto 0.6406369138 -0.2999999300) (moveto 0.6406369138 -0.5999998601) (lineto 0.6406369138 -0.8999997901) (moveto 0.6406369138 -1.1999997201) (lineto 0.6406369138 -1.4999996502) (moveto 0.6406369138 -1.7999995802) (lineto 0.6406369138 -1.8999994000)) } "ottava_bracket" "op47-ottava_bracket-0001" % source p2 system 6, print m31; anchor m27
  \markAt #102.4516869016 #6.2563223924 \markup { \referenceInkBox #1.1386958912 #1.5781750730 { \musicglyph "eight" } } "ottava_text" "op47-ottava_text-0002" % source p2 system 6, print m31; anchor m27
  \markAt #108.0229890887 #6.2070308797 \markup { \referenceInkBox #2.3984371054 #2.2031247838 { \musicglyph "scripts.trill" } } "reference-trill" "op47-reference-trill-0002" % source p2 system 6, print m31; anchor m27
  \markAt #36.4231710444 #4.7070313472 \markup { \referenceInkBox #2.3984371054 #2.2031247838 { \musicglyph "scripts.trill" } } "reference-trill" "op47-reference-trill-0003" % source p2 system 6, print m28; anchor m27
  \markAt #61.1039252970 #4.7070313472 \markup { \referenceInkBox #2.3984371054 #2.2031247838 { \musicglyph "scripts.trill" } } "reference-trill" "op47-reference-trill-0004" % source p2 system 6, print m29; anchor m27
  \markAt #84.3271102385 #4.7070313472 \markup { \referenceInkBox #2.3984371054 #2.2031247838 { \musicglyph "scripts.trill" } } "reference-trill" "op47-reference-trill-0005" % source p2 system 6, print m30; anchor m27
  \markAt #105.4079878622 #0.6601559620 \markup { \with-color #(rgb-color 0.4274509804 0.4274509804 0.4274509804) { \referenceInkBox #0.6718747906 #2.7031246280 { \musicglyph "accidentals.natural" } } } "source_auxiliary_accidental" "op47-source_auxiliary_accidental-0001" % source p2 system 6, print m31; anchor m27
  s1*15/4
  \markAt #-0.7536488321 #3.9999999995 \markup { \referenceText #1.4876378284 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "32" } } "bar_number" "op47-bar_number-0008" % source p2 system 7, print m32; anchor m32
  \markAt #38.6372967790 #-6.5200754933 \markup { \referenceInkBox #1.8043647843 #1.6117535211 { \dynamic "p" } } "dynamics" "op47-dynamics-0012" % source p2 system 7, print m33; anchor m32
  \markAt #84.5995311410 #9.1618728503 \markup { \override #'(line-cap-style . square) \path #0.1000000044 #'((moveto 0.0000000000 0.0000000000) (lineto 0.2999999971 0.0000000000) (moveto 0.5999999941 0.0000000000) (lineto 0.8999999912 0.0000000000) (moveto 1.1999999882 0.0000000000) (lineto 1.4999999853 0.0000000000) (moveto 1.7999999824 0.0000000000) (lineto 2.0999999794 0.0000000000) (moveto 2.3999999765 0.0000000000) (lineto 2.6999999735 0.0000000000) (moveto 2.9999999706 0.0000000000) (lineto 3.2999999677 0.0000000000) (moveto 3.5999999647 0.0000000000) (lineto 3.8999999618 0.0000000000) (moveto 4.1999999588 0.0000000000) (lineto 4.4999999559 0.0000000000) (moveto 4.7999999530 0.0000000000) (lineto 5.0999999500 0.0000000000) (moveto 5.3999999471 0.0000000000) (lineto 5.6999999441 0.0000000000) (moveto 5.9999999412 0.0000000000) (lineto 6.2999999383 0.0000000000) (moveto 6.5999999353 0.0000000000) (lineto 6.8999999324 0.0000000000) (moveto 7.1999999294 0.0000000000) (lineto 7.4999999265 0.0000000000) (moveto 7.7999999236 0.0000000000) (lineto 8.0999999206 0.0000000000) (moveto 8.3999999177 0.0000000000) (lineto 8.6999999147 0.0000000000) (moveto 8.9999999118 0.0000000000) (lineto 9.2999999089 0.0000000000) (moveto 9.5999999059 0.0000000000) (lineto 9.8999999030 0.0000000000) (moveto 10.1999999000 0.0000000000) (lineto 10.4999998971 0.0000000000) (moveto 10.7999998942 0.0000000000) (lineto 11.0999998912 0.0000000000) (moveto 11.3999998883 0.0000000000) (lineto 11.6999998853 0.0000000000) (moveto 11.9999998824 0.0000000000) (lineto 12.2999998795 0.0000000000) (moveto 12.5999998765 0.0000000000) (lineto 12.8999998736 0.0000000000) (moveto 13.1999998706 0.0000000000) (lineto 13.4999998677 0.0000000000) (moveto 13.7999998648 0.0000000000) (lineto 14.0999998618 0.0000000000) (moveto 14.3999998589 0.0000000000) (lineto 14.6999998559 0.0000000000) (moveto 14.9999998530 0.0000000000) (lineto 15.2999998501 0.0000000000) (moveto 15.5999998471 0.0000000000) (lineto 15.8999998442 0.0000000000) (moveto 16.1999998412 0.0000000000) (lineto 16.4999998383 0.0000000000) (moveto 16.7999998354 0.0000000000) (lineto 17.0999998324 0.0000000000) (moveto 17.3999998295 0.0000000000) (lineto 17.6999998266 0.0000000000) (moveto 17.9999998236 0.0000000000) (lineto 18.2999998207 0.0000000000) (moveto 18.5999998177 0.0000000000) (lineto 18.8999998148 0.0000000000) (moveto 19.1999998119 0.0000000000) (lineto 19.4999998089 0.0000000000) (moveto 19.7999998060 0.0000000000) (lineto 20.0999998030 0.0000000000) (moveto 20.3999998001 0.0000000000) (lineto 20.6999997972 0.0000000000) (moveto 20.9999997942 0.0000000000) (lineto 21.2999997913 0.0000000000) (moveto 21.5999997883 0.0000000000) (lineto 21.8999997854 0.0000000000) (moveto 22.1999997825 0.0000000000) (lineto 22.4999997795 0.0000000000) (moveto 22.7999997766 0.0000000000) (lineto 23.0999997736 0.0000000000) (moveto 23.3999997707 0.0000000000) (lineto 23.6999997678 0.0000000000) (moveto 23.9999997648 0.0000000000) (lineto 24.2999997619 0.0000000000) (moveto 24.5999997589 0.0000000000) (lineto 24.8999997560 0.0000000000) (moveto 24.9253814344 0.0000000000) (lineto 24.9253814344 -0.2999999971) (moveto 24.9253814344 -0.5999999941) (lineto 24.9253814344 -0.8999999912) (moveto 24.9253814344 -1.1999999882) (lineto 24.9253814344 -1.4999999853) (moveto 24.9253814344 -1.7999999824) (lineto 24.9253814344 -1.8999989273)) } "ottava_bracket" "op47-ottava_bracket-0002" % source p2 system 7, print m34; anchor m32
  \markAt #13.8137387841 #7.0415026416 \markup { \override #'(line-cap-style . square) \path #0.1000000044 #'((moveto 0.0000000000 0.0000000000) (lineto 0.2999999971 0.0000000000) (moveto 0.5999999941 0.0000000000) (lineto 0.6406370569 0.0000000000) (moveto 0.6406370569 0.0000000000) (lineto 0.6406370569 -0.2999999971) (moveto 0.6406370569 -0.5999999941) (lineto 0.6406370569 -0.8999999912) (moveto 0.6406370569 -1.1999999882) (lineto 0.6406370569 -1.4999999853) (moveto 0.6406370569 -1.7999999824) (lineto 0.6406370569 -1.8999989273)) } "ottava_bracket" "op47-ottava_bracket-0003" % source p2 system 7, print m32; anchor m32
  \markAt #40.8900817994 #7.0415026416 \markup { \override #'(line-cap-style . square) \path #0.1000000044 #'((moveto 0.0000000000 0.0000000000) (lineto 0.2999999971 0.0000000000) (moveto 0.5999999941 0.0000000000) (lineto 0.6406370569 0.0000000000) (moveto 0.6406370569 0.0000000000) (lineto 0.6406370569 -0.2999999971) (moveto 0.6406370569 -0.5999999941) (lineto 0.6406370569 -0.8999999912) (moveto 0.6406370569 -1.1999999882) (lineto 0.6406370569 -1.4999999853) (moveto 0.6406370569 -1.7999999824) (lineto 0.6406370569 -1.8999989273)) } "ottava_bracket" "op47-ottava_bracket-0004" % source p2 system 7, print m33; anchor m32
  \markAt #82.9245960702 #8.3766895844 \markup { \referenceInkBox #1.1386961456 #1.5781754256 { \musicglyph "eight" } } "ottava_text" "op47-ottava_text-0003" % source p2 system 7, print m34; anchor m32
  \markAt #39.2151458558 #6.2563186868 \markup { \referenceInkBox #1.1386961456 #1.5781754256 { \musicglyph "eight" } } "ottava_text" "op47-ottava_text-0004" % source p2 system 7, print m33; anchor m32
  \markAt #12.1388012440 #6.2563186868 \markup { \referenceInkBox #1.1386961456 #1.5781754256 { \musicglyph "eight" } } "ottava_text" "op47-ottava_text-0005" % source p2 system 7, print m32; anchor m32
  \markAt #17.3610524561 #6.2070290445 \markup { \referenceInkBox #2.3984376412 #2.2031252761 { \musicglyph "scripts.trill" } } "reference-trill" "op47-reference-trill-0006" % source p2 system 7, print m32; anchor m32
  \markAt #14.9205745210 #0.6601552393 \markup { \with-color #(rgb-color 0.0000000000 0.0000000000 0.0000000000) { \referenceInkBox #0.6718749407 #2.7031252320 { \musicglyph "accidentals.natural" } } } "source_auxiliary_accidental" "op47-source_auxiliary_accidental-0002" % source p2 system 7, print m32; anchor m32
  \markAt #66.9224298653 #-5.4999982258 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 0.0000000000) (lineto 30.0096319751 -0.5644430261) (moveto 0.0000000000 0.0000000000) (lineto 30.0096319751 0.5644430261)) } "wedge" "op47-wedge-0007" % source p2 system 7, print m34; anchor m32
  \markAt #102.7218105398 #-5.4999982258 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 -0.5644430261) (lineto 24.6003725518 0.0000000000) (moveto 0.0000000000 0.5644430261) (lineto 24.6003725518 0.0000000000)) } "wedge" "op47-wedge-0008" % source p2 system 7, print m35; anchor m32
  s1*3
  \markAt #-0.7301305481 #4.0000000191 \markup { \referenceText #1.4821723598 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "36" } } "bar_number" "op47-bar_number-0007" % source p2 system 8, print m36; anchor m36
  s1*9/2
  \markAt #-0.7801074014 #4.0000071878 \markup { \referenceText #1.5376153874 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "42" } } "bar_number" "op47-bar_number-0006" % source p2 system 9, print m42; anchor m42
  \markAt #110.5257030516 #-6.5200680144 \markup { \referenceInkBox #1.8043647843 #1.6117535211 { \dynamic "p" } } "dynamics" "op47-dynamics-0011" % source p2 system 9, print m46; anchor m42
  \markAt #112.7784823829 #7.5415080367 \markup { \override #'(line-cap-style . square) \path #0.1000000044 #'((moveto 0.0000000000 0.0000000000) (lineto 0.2999999971 0.0000000000) (moveto 0.5999999941 0.0000000000) (lineto 0.8999999912 0.0000000000) (moveto 1.1999999882 0.0000000000) (lineto 1.4999999853 0.0000000000) (moveto 1.7999999824 0.0000000000) (lineto 2.0999999794 0.0000000000) (moveto 2.3999999765 0.0000000000) (lineto 2.6999999735 0.0000000000) (moveto 2.9999999706 0.0000000000) (lineto 3.2999999677 0.0000000000) (moveto 3.5999999647 0.0000000000) (lineto 3.8999999618 0.0000000000) (moveto 4.1999999588 0.0000000000) (lineto 4.4999999559 0.0000000000) (moveto 4.7999999530 0.0000000000) (lineto 5.0999999500 0.0000000000) (moveto 5.1534180120 0.0000000000) (lineto 5.1534180120 -0.2999999971) (moveto 5.1534180120 -0.5999999941) (lineto 5.1534180120 -0.8999999912) (moveto 5.1534180120 -1.1999999882) (lineto 5.1534180120 -1.4999999853) (moveto 5.1534180120 -1.7999999824) (lineto 5.1534180120 -1.8999989273)) } "ottava_bracket" "op47-ottava_bracket-0005" % source p2 system 9, print m46; anchor m42
  \markAt #111.1035474247 #6.7563204771 \markup { \referenceInkBox #1.1386961456 #1.5781754256 { \musicglyph "eight" } } "ottava_text" "op47-ottava_text-0001" % source p2 system 9, print m46; anchor m42
  \markAt #103.8933152954 #-5.4999946261 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 -0.5644430261) (lineto 6.0677750909 0.0000000000) (moveto 0.0000000000 0.5644430261) (lineto 6.0677750909 0.0000000000)) } "wedge" "op47-wedge-0009" % source p2 system 9, print m46; anchor m42
  s1*9/2
  \markAt #-0.7565886470 #4.0000071862 \markup { \referenceText #1.4970087824 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "48" } } "bar_number" "op47-bar_number-0005" % source p2 system 10, print m48; anchor m48
  \markAt #46.2267968400 #-5.4999874505 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 -0.5644502034) (lineto 12.7470367059 0.0000000000) (moveto 0.0000000000 0.5644502034) (lineto 12.7470367059 0.0000000000)) } "wedge" "op47-wedge-0010" % source p2 system 10, print m50; anchor m48
  s1*6
  \markAt #-0.7473099538 #4.0000004674 \markup { \referenceText #1.4993515975 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "56" } } "bar_number" "op47-bar_number-0014" % source p3 system 11, print m56; anchor m56
  s1*15/4
  \markAt #-0.6971493526 #3.9999999995 \markup { \referenceText #1.3720673546 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "61" } } "bar_number" "op47-bar_number-0013" % source p3 system 12, print m61; anchor m61
  s1*15/4
  \markAt #-0.7441866263 #4.0000000079 \markup { \referenceText #1.4962284380 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "66" } } "bar_number" "op47-bar_number-0012" % source p3 system 13, print m66; anchor m66
  \markAt #75.5095602978 #-5.5000018061 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 0.0000000000) (lineto 4.6566639370 -0.5644430261) (moveto 0.0000000000 0.0000000000) (lineto 4.6566639370 0.5644430261)) } "wedge" "op47-wedge-0011" % source p3 system 13, print m68; anchor m66
  s1*15/4
  \markAt #-0.6970573952 #4.0000000035 \markup { \referenceText #1.3954934460 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "71" } } "bar_number" "op47-bar_number-0011" % source p3 system 14, print m71; anchor m71
  \markAt #14.5763411966 #-5.5000018105 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 -0.5644430261) (lineto 32.3144475775 0.0000000000) (moveto 0.0000000000 0.5644430261) (lineto 32.3144475775 0.0000000000)) } "wedge" "op47-wedge-0012" % source p3 system 14, print m71; anchor m71
  \markAt #47.9061785120 #-5.4240661618 \markup { \referenceText #2.9738271513 { \override #'(font-name . "Nimbus Roman, Italic") \abs-fontsize #10.2382498085 "ten." } } "words" "op47-words-0010" % source p3 system 14, print m72; anchor m71
  s1*15/4
  \markAt #-0.7440944337 #4.0000071957 \markup { \referenceText #1.5196545294 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "76" } } "bar_number" "op47-bar_number-0010" % source p3 system 15, print m76; anchor m76
  s1*15/4
  \markAt #-0.6620092444 #4.0000004674 \markup { \referenceText #1.3369270955 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "81" } } "bar_number" "op47-bar_number-0019" % source p4 system 16, print m81; anchor m81
  \markAt #9.8536526954 #-6.5634081450 \markup { \referenceInkBox #3.0793187813 #2.4293430198 { \dynamic "ff" } } "dynamics" "op47-dynamics-0017" % source p4 system 16, print m81; anchor m81
  s1*15/4
  \markAt #-0.7090466659 #3.9999999995 \markup { \referenceText #1.4610884776 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "86" } } "bar_number" "op47-bar_number-0018" % source p4 system 17, print m86; anchor m86
  \markAt #17.9021061040 #-6.5634147150 \markup { \referenceInkBox #2.0217198817 #2.4293435626 { \dynamic "f" } } "dynamics" "op47-dynamics-0016" % source p4 system 17, print m86; anchor m86
  s1*15/4
  \markAt #-0.7049582066 #4.0000071750 \markup { \referenceText #1.3798762085 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "91" } } "bar_number" "op47-bar_number-0017" % source p4 system 18, print m91; anchor m91
  \markAt #18.8199112574 #-5.4999946390 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 -0.5644430261) (lineto 40.2166660919 0.0000000000) (moveto 0.0000000000 0.5644430261) (lineto 40.2166660919 0.0000000000)) } "wedge" "op47-wedge-0015" % source p4 system 18, print m91; anchor m91
  \markAt #68.5172148551 #-5.4999946390 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 -0.5644430261) (lineto 39.1348217434 0.0000000000) (moveto 0.0000000000 0.5644430261) (lineto 39.1348217434 0.0000000000)) } "wedge" "op47-wedge-0016" % source p4 system 18, print m93; anchor m91
  \markAt #115.8013240906 #-5.4999946390 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 0.0000000000) (lineto 12.7000003851 -0.5644430261) (moveto 0.0000000000 0.0000000000) (lineto 12.7000003851 0.5644430261)) } "wedge" "op47-wedge-0017" % source p4 system 18, print m95; anchor m91
  \markAt #92.4238661582 #8.1120445628 \markup { \referenceText #2.9738271513 { \override #'(font-name . "Nimbus Roman, Italic") \abs-fontsize #10.2382498085 "ten." } } "words" "op47-words-0013" % source p4 system 18, print m94; anchor m91
  s1*15/4
  \markAt #-0.7519954802 #3.9999928201 \markup { \referenceText #1.5040372919 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "96" } } "bar_number" "op47-bar_number-0016" % source p4 system 19, print m96; anchor m96
  \markAt #68.7329711438 #-5.5000089938 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 -0.5644430261) (lineto 9.7366655265 0.0000000000) (moveto 0.0000000000 0.5644430261) (lineto 9.7366655265 0.0000000000)) } "wedge" "op47-wedge-0018" % source p4 system 19, print m98; anchor m96
  \markAt #9.3778121699 #-5.8944509071 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 -0.2351851923) (lineto 58.3259294889 -0.5644430261) (moveto 0.0000000000 0.2351851923) (lineto 58.3259294889 0.5644430261)) } "wedge" "op47-wedge-0019" % source p4 system 19, print m96; anchor m96
  \markAt #68.7480150884 #4.0889121728 \markup { \referenceText #2.9738295031 { \override #'(font-name . "Nimbus Roman, Italic") \abs-fontsize #10.2382498085 "ten." } } "words" "op47-words-0014" % source p4 system 19, print m98; anchor m96
  s1*15/4
  \markAt #-1.0221825791 #4.0000071950 \markup { \referenceText #2.0491427103 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "101" } } "bar_number" "op47-bar_number-0015" % source p4 system 20, print m101; anchor m101
  s1*15/4
  \markAt #-1.0692193787 #4.0000004674 \markup { \referenceText #2.1733035433 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "106" } } "bar_number" "op47-bar_number-0024" % source p5 system 21, print m106; anchor m106
  s1*15/4
  \markAt #-1.0221825791 #3.9999999995 \markup { \referenceText #2.0491427103 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "111" } } "bar_number" "op47-bar_number-0023" % source p5 system 22, print m111; anchor m111
  \markAt #124.9954489607 #4.1120373790 \markup { \referenceText #2.9738342068 { \override #'(font-name . "Nimbus Roman, Italic") \abs-fontsize #10.2382498085 "ten." } } "words" "op47-words-0015" % source p5 system 22, print m115; anchor m111
  \markAt #103.3616151955 #4.1120373790 \markup { \referenceText #2.3008440179 { \override #'(font-name . "Nimbus Roman, Italic") \abs-fontsize #10.2382498085 "rit." } } "words" "op47-words-0016" % source p5 system 22, print m114; anchor m111
  s1*15/4
  \markAt #-1.0692196176 #4.0000071821 \markup { \referenceText #2.1733040289 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "116" } } "bar_number" "op47-bar_number-0022" % source p5 system 23, print m116; anchor m116
  \markAt #73.4067528994 #7.5557621139 \markup { \override #'(line-cap-style . square) \path #0.1000000044 #'((moveto 0.0000000000 0.0000000000) (lineto 0.2999999971 0.0000000000) (moveto 0.5999999941 0.0000000000) (lineto 0.8999999912 0.0000000000) (moveto 1.1999999882 0.0000000000) (lineto 1.4999999853 0.0000000000) (moveto 1.7999999824 0.0000000000) (lineto 2.0999999794 0.0000000000) (moveto 2.3999999765 0.0000000000) (lineto 2.6999999735 0.0000000000) (moveto 2.9999999706 0.0000000000) (lineto 3.2999999677 0.0000000000) (moveto 3.5999999647 0.0000000000) (lineto 3.8999999618 0.0000000000) (moveto 4.1999999588 0.0000000000) (lineto 4.4999999559 0.0000000000) (moveto 4.7999999530 0.0000000000) (lineto 5.0999999500 0.0000000000) (moveto 5.3999999471 0.0000000000) (lineto 5.6999999441 0.0000000000) (moveto 5.9999999412 0.0000000000) (lineto 6.2999999383 0.0000000000) (moveto 6.5999999353 0.0000000000) (lineto 6.8999999324 0.0000000000) (moveto 7.1999999294 0.0000000000) (lineto 7.4999999265 0.0000000000) (moveto 7.7999999236 0.0000000000) (lineto 8.0999999206 0.0000000000) (moveto 8.3999999177 0.0000000000) (lineto 8.6999999147 0.0000000000) (moveto 8.9999999118 0.0000000000) (lineto 9.2999999089 0.0000000000) (moveto 9.5999999059 0.0000000000) (lineto 9.8999999030 0.0000000000) (moveto 10.1999999000 0.0000000000) (lineto 10.4999998971 0.0000000000) (moveto 10.7999998942 0.0000000000) (lineto 11.0999998912 0.0000000000) (moveto 11.3999998883 0.0000000000) (lineto 11.6999998853 0.0000000000) (moveto 11.9999998824 0.0000000000) (lineto 12.2999998795 0.0000000000) (moveto 12.5999998765 0.0000000000) (lineto 12.8999998736 0.0000000000) (moveto 13.1999998706 0.0000000000) (lineto 13.4999998677 0.0000000000) (moveto 13.7999998648 0.0000000000) (lineto 14.0999998618 0.0000000000) (moveto 14.3999998589 0.0000000000) (lineto 14.6999998559 0.0000000000) (moveto 14.9999998530 0.0000000000) (lineto 15.2999998501 0.0000000000) (moveto 15.5999998471 0.0000000000) (lineto 15.8999998442 0.0000000000) (moveto 16.1999998412 0.0000000000) (lineto 16.4999998383 0.0000000000) (moveto 16.7999998354 0.0000000000) (lineto 17.0999998324 0.0000000000) (moveto 17.3999998295 0.0000000000) (lineto 17.6999998266 0.0000000000) (moveto 17.9999998236 0.0000000000) (lineto 18.2999998207 0.0000000000) (moveto 18.5999998177 0.0000000000) (lineto 18.8999998148 0.0000000000) (moveto 19.1999998119 0.0000000000) (lineto 19.4999998089 0.0000000000) (moveto 19.7999998060 0.0000000000) (lineto 20.0999998030 0.0000000000) (moveto 20.3999998001 0.0000000000) (lineto 20.6999997972 0.0000000000) (moveto 20.9999997942 0.0000000000) (lineto 21.2999997913 0.0000000000) (moveto 21.5999997883 0.0000000000) (lineto 21.8999997854 0.0000000000) (moveto 22.1999997825 0.0000000000) (lineto 22.4999997795 0.0000000000) (moveto 22.7999997766 0.0000000000) (lineto 23.0999997736 0.0000000000) (moveto 23.3999997707 0.0000000000) (lineto 23.4820658140 0.0000000000) (moveto 23.4820658140 0.0000000000) (lineto 23.4820658140 -0.2999999971) (moveto 23.4820658140 -0.5999999941) (lineto 23.4820658140 -0.8999999912) (moveto 23.4820658140 -1.1999999882) (lineto 23.4820658140 -1.4999999853) (moveto 23.4820658140 -1.7999999824) (lineto 23.4820658140 -1.8999989273)) } "ottava_bracket" "op47-ottava_bracket-0006" % source p5 system 23, print m118; anchor m116
  \markAt #71.7318176196 #6.7705739227 \markup { \referenceInkBox #1.1386961456 #1.5781754256 { \musicglyph "eight" } } "ottava_text" "op47-ottava_text-0006" % source p5 system 23, print m118; anchor m116
  s1*3
  \markAt #-1.0927381368 #4.0000071776 \markup { \referenceText #2.1709613492 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "120" } } "bar_number" "op47-bar_number-0021" % source p5 system 24, print m120; anchor m120
  s1*3
  \markAt #-1.0927381368 #4.0000071926 \markup { \referenceText #2.1756467086 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "124" } } "bar_number" "op47-bar_number-0020" % source p5 system 25, print m124; anchor m124
  \markAt #66.3327299821 #-5.4999874441 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 0.0000000000) (lineto 26.0585236151 -0.5644502034) (moveto 0.0000000000 0.0000000000) (lineto 26.0585236151 0.5644502034)) } "wedge" "op47-wedge-0020" % source p5 system 25, print m126; anchor m124
  \markAt #98.7452371815 #-5.4999874441 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 -0.5644502034) (lineto 28.5985208212 0.0000000000) (moveto 0.0000000000 0.5644502034) (lineto 28.5985208212 0.0000000000)) } "wedge" "op47-wedge-0021" % source p5 system 25, print m127; anchor m124
  s1*3
  \markAt #-1.0692193787 #4.0000004674 \markup { \referenceText #2.1381635908 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "128" } } "bar_number" "op47-bar_number-0029" % source p6 system 26, print m128; anchor m128
  \markAt #93.6582383478 #-5.4999974297 \markup { \override #'(line-cap-style . square) \path #0.1299999718 #'((moveto 0.0000000000 0.0000000000) (lineto 34.8544405849 -0.5644446943) (moveto 0.0000000000 0.0000000000) (lineto 34.8544405849 0.5644446943)) } "wedge" "op47-wedge-0022" % source p6 system 26, print m130; anchor m128
  \markAt #70.1254774682 #-5.5906554588 \markup { \override #'(line-cap-style . square) \path #0.1299999718 #'((moveto 0.0000000000 -0.5644446943) (lineto 17.6859253817 0.0000000000) (moveto 0.0000000000 0.5644446943) (lineto 17.6859253817 0.0000000000)) } "wedge" "op47-wedge-0023" % source p6 system 26, print m129; anchor m128
  s1*9/4
  \markAt #-1.0221825791 #3.9999964093 \markup { \referenceText #2.0491427103 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "131" } } "bar_number" "op47-bar_number-0028" % source p6 system 27, print m131; anchor m131
  \markAt #29.2032481410 #7.5899977445 \markup { \override #'(line-cap-style . square) \path #0.1000000044 #'((moveto 0.0000000000 0.0000000000) (lineto 0.2999999971 0.0000000000) (moveto 0.5999999941 0.0000000000) (lineto 0.8999999912 0.0000000000) (moveto 1.1999999882 0.0000000000) (lineto 1.4999999853 0.0000000000) (moveto 1.7999999824 0.0000000000) (lineto 2.0999999794 0.0000000000) (moveto 2.3999999765 0.0000000000) (lineto 2.6999999735 0.0000000000) (moveto 2.9999999706 0.0000000000) (lineto 3.2999999677 0.0000000000) (moveto 3.5999999647 0.0000000000) (lineto 3.8999999618 0.0000000000) (moveto 4.1999999588 0.0000000000) (lineto 4.4999999559 0.0000000000) (moveto 4.7999999530 0.0000000000) (lineto 5.0999999500 0.0000000000) (moveto 5.3999999471 0.0000000000) (lineto 5.6999999441 0.0000000000) (moveto 5.9999999412 0.0000000000) (lineto 6.2999999383 0.0000000000) (moveto 6.5999999353 0.0000000000) (lineto 6.8999999324 0.0000000000) (moveto 7.1999999294 0.0000000000) (lineto 7.4999999265 0.0000000000) (moveto 7.7999999236 0.0000000000) (lineto 8.0999999206 0.0000000000) (moveto 8.3999999177 0.0000000000) (lineto 8.6999999147 0.0000000000) (moveto 8.9999999118 0.0000000000) (lineto 9.2999999089 0.0000000000) (moveto 9.5999999059 0.0000000000) (lineto 9.8999999030 0.0000000000) (moveto 10.1999999000 0.0000000000) (lineto 10.4999998971 0.0000000000) (moveto 10.7999998942 0.0000000000) (lineto 11.0999998912 0.0000000000) (moveto 11.3999998883 0.0000000000) (lineto 11.6999998853 0.0000000000) (moveto 11.9999998824 0.0000000000) (lineto 12.2999998795 0.0000000000) (moveto 12.5999998765 0.0000000000) (lineto 12.8999998736 0.0000000000) (moveto 13.1999998706 0.0000000000) (lineto 13.4999998677 0.0000000000) (moveto 13.7999998648 0.0000000000) (lineto 14.0999998618 0.0000000000) (moveto 14.3999998589 0.0000000000) (lineto 14.6999998559 0.0000000000) (moveto 14.9999998530 0.0000000000) (lineto 15.2999998501 0.0000000000) (moveto 15.5999998471 0.0000000000) (lineto 15.8999998442 0.0000000000) (moveto 16.1999998412 0.0000000000) (lineto 16.4999998383 0.0000000000) (moveto 16.7999998354 0.0000000000) (lineto 17.0999998324 0.0000000000) (moveto 17.3999998295 0.0000000000) (lineto 17.6999998266 0.0000000000) (moveto 17.9999998236 0.0000000000) (lineto 18.2999998207 0.0000000000) (moveto 18.5999998177 0.0000000000) (lineto 18.8999998148 0.0000000000) (moveto 19.1999998119 0.0000000000) (lineto 19.4999998089 0.0000000000) (moveto 19.7999998060 0.0000000000) (lineto 20.0999998030 0.0000000000) (moveto 20.3999998001 0.0000000000) (lineto 20.6999997972 0.0000000000) (moveto 20.9999997942 0.0000000000) (lineto 21.2999997913 0.0000000000) (moveto 21.5999997883 0.0000000000) (lineto 21.8999997854 0.0000000000) (moveto 22.1999997825 0.0000000000) (lineto 22.4999997795 0.0000000000) (moveto 22.7999997766 0.0000000000) (lineto 23.0999997736 0.0000000000) (moveto 23.3999997707 0.0000000000) (lineto 23.6999997678 0.0000000000) (moveto 23.9999997648 0.0000000000) (lineto 24.2999997619 0.0000000000) (moveto 24.5999997589 0.0000000000) (lineto 24.8999997560 0.0000000000) (moveto 25.1999997531 0.0000000000) (lineto 25.4999997501 0.0000000000) (moveto 25.7999997472 0.0000000000) (lineto 26.0999997442 0.0000000000) (moveto 26.3999997413 0.0000000000) (lineto 26.6999997384 0.0000000000) (moveto 26.9999997354 0.0000000000) (lineto 27.2999997325 0.0000000000) (moveto 27.5999997295 0.0000000000) (lineto 27.8999997266 0.0000000000) (moveto 28.1999997237 0.0000000000) (lineto 28.4999997207 0.0000000000) (moveto 28.7999997178 0.0000000000) (lineto 29.0999997148 0.0000000000) (moveto 29.3999997119 0.0000000000) (lineto 29.6999997090 0.0000000000) (moveto 29.9999997060 0.0000000000) (lineto 30.2999997031 0.0000000000) (moveto 30.5999997001 0.0000000000) (lineto 30.8999996972 0.0000000000) (moveto 31.1999996943 0.0000000000) (lineto 31.4999996913 0.0000000000) (moveto 31.7999996884 0.0000000000) (lineto 32.0999996854 0.0000000000) (moveto 32.3999996825 0.0000000000) (lineto 32.6999996796 0.0000000000) (moveto 32.9999996766 0.0000000000) (lineto 33.2999996737 0.0000000000) (moveto 33.5999996707 0.0000000000) (lineto 33.8999996678 0.0000000000) (moveto 34.1999996649 0.0000000000) (lineto 34.4999996619 0.0000000000) (moveto 34.7999996590 0.0000000000) (lineto 35.0999996560 0.0000000000) (moveto 35.3999996531 0.0000000000) (lineto 35.6999996502 0.0000000000) (moveto 35.9999996472 0.0000000000) (lineto 36.2999996443 0.0000000000) (moveto 36.5999996413 0.0000000000) (lineto 36.8999996384 0.0000000000) (moveto 37.1999996355 0.0000000000) (lineto 37.4999996325 0.0000000000) (moveto 37.7999996296 0.0000000000) (lineto 38.0999996266 0.0000000000) (moveto 38.3999996237 0.0000000000) (lineto 38.6999996208 0.0000000000) (moveto 38.9999996178 0.0000000000) (lineto 39.2999996149 0.0000000000) (moveto 39.5999996119 0.0000000000) (lineto 39.8999996090 0.0000000000) (moveto 40.1999996061 0.0000000000) (lineto 40.4999996031 0.0000000000) (moveto 40.7999996002 0.0000000000) (lineto 41.0999995972 0.0000000000) (moveto 41.3999995943 0.0000000000) (lineto 41.6999995914 0.0000000000) (moveto 41.9999995884 0.0000000000) (lineto 42.2999995855 0.0000000000) (moveto 42.5999995825 0.0000000000) (lineto 42.8999995796 0.0000000000) (moveto 43.1999995767 0.0000000000) (lineto 43.4999995737 0.0000000000) (moveto 43.7999995708 0.0000000000) (lineto 44.0999995678 0.0000000000) (moveto 44.3999995649 0.0000000000) (lineto 44.6999995620 0.0000000000) (moveto 44.9999995590 0.0000000000) (lineto 45.2999995561 0.0000000000) (moveto 45.5999995531 0.0000000000) (lineto 45.8999995502 0.0000000000) (moveto 46.1999995473 0.0000000000) (lineto 46.4999995443 0.0000000000) (moveto 46.7999995414 0.0000000000) (lineto 47.0999995384 0.0000000000) (moveto 47.3999995355 0.0000000000) (lineto 47.6999995326 0.0000000000) (moveto 47.9999995296 0.0000000000) (lineto 48.2999995267 0.0000000000) (moveto 48.5999995237 0.0000000000) (lineto 48.7290612763 0.0000000000) (moveto 48.7290612763 0.0000000000) (lineto 48.7290612763 -0.2999999971) (moveto 48.7290612763 -0.5999999941) (lineto 48.7290612763 -0.8999999912) (moveto 48.7290612763 -1.1999999882) (lineto 48.7290612763 -1.4999999853) (moveto 48.7290612763 -1.7999999824) (lineto 48.7290612763 -1.8999989273)) } "ottava_bracket" "op47-ottava_bracket-0007" % source p6 system 27, print m131; anchor m131
  \markAt #27.5283091681 #6.8048150758 \markup { \referenceInkBox #1.1386961456 #1.5781754256 { \musicglyph "eight" } } "ottava_text" "op47-ottava_text-0008" % source p6 system 27, print m131; anchor m131
  \markAt #108.2993323063 #3.7570294723 \markup { \referenceInkBox #2.3984376412 #2.2031252761 { \musicglyph "scripts.trill" } } "reference-trill" "op47-reference-trill-0007" % source p6 system 27, print m134; anchor m131
  \markAt #117.1293603518 #3.7570294723 \markup { \referenceInkBox #2.3984376412 #2.2031252761 { \musicglyph "scripts.trill" } } "reference-trill" "op47-reference-trill-0008" % source p6 system 27, print m134; anchor m131
  \markAt #9.2206260949 #-5.5000018160 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 -0.2351851923) (lineto 33.7255605258 -0.5644430261) (moveto 0.0000000000 0.2351851923) (lineto 33.7255605258 0.5644430261)) } "wedge" "op47-wedge-0024" % source p6 system 27, print m131; anchor m131
  s1*3
  \markAt #-1.0457013336 #4.0000000032 \markup { \referenceText #2.1217657810 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "135" } } "bar_number" "op47-bar_number-0027" % source p6 system 28, print m135; anchor m135
  \markAt #22.8982902536 #3.9570279024 \markup { \referenceInkBox #2.3984376412 #2.2031252761 { \musicglyph "scripts.trill" } } "reference-trill" "op47-reference-trill-0009" % source p6 system 28, print m135; anchor m135
  \markAt #10.3380481987 #3.7570264149 \markup { \referenceInkBox #2.3984376412 #2.2031252761 { \musicglyph "scripts.trill" } } "reference-trill" "op47-reference-trill-0010" % source p6 system 28, print m135; anchor m135
  \markAt #23.4380493363 #-5.5000018107 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 0.0000000000) (lineto 12.1825936797 -0.5644430261) (moveto 0.0000000000 0.0000000000) (lineto 12.1825936797 0.5644430261)) } "wedge" "op47-wedge-0026" % source p6 system 28, print m135; anchor m135
  \markAt #55.1658258439 #-5.5000018107 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 -0.5644430261) (lineto 13.1233308604 0.0000000000) (moveto 0.0000000000 0.5644430261) (lineto 13.1233308604 0.0000000000)) } "wedge" "op47-wedge-0027" % source p6 system 28, print m136; anchor m135
  \markAt #89.2907249839 #-5.5000018107 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 -0.5644430261) (lineto 8.2785216405 0.0000000000) (moveto 0.0000000000 0.5644430261) (lineto 8.2785216405 0.0000000000)) } "wedge" "op47-wedge-0028" % source p6 system 28, print m137; anchor m135
  s1*3
  \markAt #-1.0692196176 #4.0000071761 \markup { \referenceText #2.1623716804 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "139" } } "bar_number" "op47-bar_number-0026" % source p6 system 29, print m139; anchor m139
  \markAt #51.2942920148 #5.3150001630 \markup { \override #'(line-cap-style . square) \path #0.1000000044 #'((moveto 0.0000000000 0.0000000000) (lineto 0.2999999971 0.0000000000) (moveto 0.5999999941 0.0000000000) (lineto 0.8999999912 0.0000000000) (moveto 1.1999999882 0.0000000000) (lineto 1.4999999853 0.0000000000) (moveto 1.7999999824 0.0000000000) (lineto 2.0999999794 0.0000000000) (moveto 2.3999999765 0.0000000000) (lineto 2.6999999735 0.0000000000) (moveto 2.9999999706 0.0000000000) (lineto 3.2999999677 0.0000000000) (moveto 3.5999999647 0.0000000000) (lineto 3.8999999618 0.0000000000) (moveto 4.1999999588 0.0000000000) (lineto 4.4999999559 0.0000000000) (moveto 4.7999999530 0.0000000000) (lineto 5.0999999500 0.0000000000) (moveto 5.3999999471 0.0000000000) (lineto 5.6999999441 0.0000000000) (moveto 5.9999999412 0.0000000000) (lineto 6.2999999383 0.0000000000) (moveto 6.5999999353 0.0000000000) (lineto 6.8999999324 0.0000000000) (moveto 7.1999999294 0.0000000000) (lineto 7.4999999265 0.0000000000) (moveto 7.7999999236 0.0000000000) (lineto 8.0999999206 0.0000000000) (moveto 8.3999999177 0.0000000000) (lineto 8.6999999147 0.0000000000) (moveto 8.9999999118 0.0000000000) (lineto 9.2999999089 0.0000000000) (moveto 9.5999999059 0.0000000000) (lineto 9.8999999030 0.0000000000) (moveto 10.1999999000 0.0000000000) (lineto 10.4999998971 0.0000000000) (moveto 10.7999998942 0.0000000000) (lineto 11.0999998912 0.0000000000) (moveto 11.3999998883 0.0000000000) (lineto 11.6999998853 0.0000000000) (moveto 11.9999998824 0.0000000000) (lineto 12.2999998795 0.0000000000) (moveto 12.5999998765 0.0000000000) (lineto 12.8999998736 0.0000000000) (moveto 13.1999998706 0.0000000000) (lineto 13.4999998677 0.0000000000) (moveto 13.7999998648 0.0000000000) (lineto 14.0999998618 0.0000000000) (moveto 14.3999998589 0.0000000000) (lineto 14.6999998559 0.0000000000) (moveto 14.9999998530 0.0000000000) (lineto 15.2999998501 0.0000000000) (moveto 15.5999998471 0.0000000000) (lineto 15.8999998442 0.0000000000) (moveto 16.1999998412 0.0000000000) (lineto 16.4999998383 0.0000000000) (moveto 16.7999998354 0.0000000000) (lineto 17.0999998324 0.0000000000) (moveto 17.3999998295 0.0000000000) (lineto 17.6999998266 0.0000000000) (moveto 17.9999998236 0.0000000000) (lineto 18.2999998207 0.0000000000) (moveto 18.5999998177 0.0000000000) (lineto 18.8999998148 0.0000000000) (moveto 19.1999998119 0.0000000000) (lineto 19.4999998089 0.0000000000) (moveto 19.7999998060 0.0000000000) (lineto 20.0999998030 0.0000000000) (moveto 20.3999998001 0.0000000000) (lineto 20.6999997972 0.0000000000) (moveto 20.9999997942 0.0000000000) (lineto 21.2999997913 0.0000000000) (moveto 21.5999997883 0.0000000000) (lineto 21.8999997854 0.0000000000) (moveto 22.1999997825 0.0000000000) (lineto 22.4999997795 0.0000000000) (moveto 22.5329778652 0.0000000000) (lineto 22.5329778652 -0.2999999971) (moveto 22.5329778652 -0.5999999941) (lineto 22.5329778652 -0.8999999912) (moveto 22.5329778652 -1.1999999882) (lineto 22.5329778652 -1.4999999853) (moveto 22.5329778652 -1.7999999824) (lineto 22.5329778652 -1.8999989273)) } "ottava_bracket" "op47-ottava_bracket-0008" % source p6 system 29, print m140; anchor m139
  \markAt #49.6193530602 #4.5298119603 \markup { \referenceInkBox #1.1386961456 #1.5781754256 { \musicglyph "eight" } } "ottava_text" "op47-ottava_text-0007" % source p6 system 29, print m140; anchor m139
  \markAt #103.8171930374 #-5.6444446251 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 -0.5644430261) (lineto 23.5185264090 0.0000000000) (moveto 0.0000000000 0.5644430261) (lineto 23.5185264090 0.0000000000)) } "wedge" "op47-wedge-0030" % source p6 system 29, print m142; anchor m139
  \markAt #74.8612507259 #-5.8452865207 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 0.0000000000) (lineto 21.7311103346 -0.5644430261) (moveto 0.0000000000 0.0000000000) (lineto 21.7311103346 0.5644430261)) } "wedge" "op47-wedge-0031" % source p6 system 29, print m141; anchor m139
  s1*3
  \markAt #-1.0457013336 #4.0000071952 \markup { \referenceText #2.1217657810 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "143" } } "bar_number" "op47-bar_number-0025" % source p6 system 30, print m143; anchor m143
  \markAt #44.3272238590 #-6.5200778922 \markup { \referenceInkBox #1.8043647843 #1.6117535211 { \dynamic "p" } } "dynamics" "op47-dynamics-0018" % source p6 system 30, print m144; anchor m143
  s1*15/4
  \markAt #-1.0692193787 #4.0000004674 \markup { \referenceText #2.1381635908 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "148" } } "bar_number" "op47-bar_number-0034" % source p7 system 31, print m148; anchor m148
  s1*15/4
  \markAt #-1.0457013336 #3.9999999995 \markup { \referenceText #2.1217657810 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "153" } } "bar_number" "op47-bar_number-0033" % source p7 system 32, print m153; anchor m153
  \markAt #101.1662952456 #3.9999999995 \markup { \referenceText #7.2768203503 { \override #'(font-name . "Nimbus Roman, Italic") \abs-fontsize #10.2382498085 "a tempo" } } "words" "op47-words-0019" % source p7 system 32, print m157; anchor m153
  \markAt #70.6803490748 #3.9999999995 \markup { \referenceText #2.3008416661 { \override #'(font-name . "Nimbus Roman, Italic") \abs-fontsize #10.2382498085 "rit." } } "words" "op47-words-0020" % source p7 system 32, print m155; anchor m153
  s1*15/4
  \markAt #-1.0692196176 #4.0000000009 \markup { \referenceText #2.1381640685 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "158" } } "bar_number" "op47-bar_number-0032" % source p7 system 33, print m158; anchor m158
  s1*9/4
  \markAt #-1.0221825791 #4.0000071738 \markup { \referenceText #2.0491427103 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "161" } } "bar_number" "op47-bar_number-0031" % source p7 system 34, print m161; anchor m161
  s1*3
  \markAt #-1.0457013336 #3.9999928425 \markup { \referenceText #2.1217657810 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "165" } } "bar_number" "op47-bar_number-0030" % source p7 system 35, print m165; anchor m165
  s1*3
  \markAt #-1.0692193787 #4.0000004674 \markup { \referenceText #2.1623711973 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "169" } } "bar_number" "op47-bar_number-0039" % source p8 system 36, print m169; anchor m169
  s1*3
  \markAt #-1.0457013336 #3.9999999995 \markup { \referenceText #2.1217657810 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "173" } } "bar_number" "op47-bar_number-0038" % source p8 system 37, print m173; anchor m173
  \markAt #32.7769893428 #8.1918738890 \markup { \override #'(line-cap-style . square) \path #0.1000000044 #'((moveto 0.0000000000 0.0000000000) (lineto 0.2999999971 0.0000000000) (moveto 0.5999999941 0.0000000000) (lineto 0.8999999912 0.0000000000) (moveto 1.1999999882 0.0000000000) (lineto 1.4999999853 0.0000000000) (moveto 1.7999999824 0.0000000000) (lineto 2.0999999794 0.0000000000) (moveto 2.3999999765 0.0000000000) (lineto 2.6999999735 0.0000000000) (moveto 2.9999999706 0.0000000000) (lineto 3.2999999677 0.0000000000) (moveto 3.5999999647 0.0000000000) (lineto 3.8999999618 0.0000000000) (moveto 4.1999999588 0.0000000000) (lineto 4.4999999559 0.0000000000) (moveto 4.7999999530 0.0000000000) (lineto 5.0999999500 0.0000000000) (moveto 5.3999999471 0.0000000000) (lineto 5.6999999441 0.0000000000) (moveto 5.9999999412 0.0000000000) (lineto 6.2999999383 0.0000000000) (moveto 6.5999999353 0.0000000000) (lineto 6.8999999324 0.0000000000) (moveto 7.1999999294 0.0000000000) (lineto 7.4999999265 0.0000000000) (moveto 7.7999999236 0.0000000000) (lineto 8.0999999206 0.0000000000) (moveto 8.3999999177 0.0000000000) (lineto 8.6999999147 0.0000000000) (moveto 8.9999999118 0.0000000000) (lineto 9.2999999089 0.0000000000) (moveto 9.5999999059 0.0000000000) (lineto 9.8999999030 0.0000000000) (moveto 10.1999999000 0.0000000000) (lineto 10.4999998971 0.0000000000) (moveto 10.7999998942 0.0000000000) (lineto 11.0999998912 0.0000000000) (moveto 11.3999998883 0.0000000000) (lineto 11.6999998853 0.0000000000) (moveto 11.9999998824 0.0000000000) (lineto 12.2999998795 0.0000000000) (moveto 12.5999998765 0.0000000000) (lineto 12.8999998736 0.0000000000) (moveto 13.1999998706 0.0000000000) (lineto 13.4999998677 0.0000000000) (moveto 13.7999998648 0.0000000000) (lineto 14.0999998618 0.0000000000) (moveto 14.3999998589 0.0000000000) (lineto 14.6999998559 0.0000000000) (moveto 14.9999998530 0.0000000000) (lineto 15.2999998501 0.0000000000) (moveto 15.5999998471 0.0000000000) (lineto 15.8999998442 0.0000000000) (moveto 16.1999998412 0.0000000000) (lineto 16.4999998383 0.0000000000) (moveto 16.7999998354 0.0000000000) (lineto 17.0999998324 0.0000000000) (moveto 17.3999998295 0.0000000000) (lineto 17.6999998266 0.0000000000) (moveto 17.9999998236 0.0000000000) (lineto 18.2999998207 0.0000000000) (moveto 18.5999998177 0.0000000000) (lineto 18.8999998148 0.0000000000) (moveto 19.1999998119 0.0000000000) (lineto 19.4999998089 0.0000000000) (moveto 19.7999998060 0.0000000000) (lineto 20.0999998030 0.0000000000) (moveto 20.3999998001 0.0000000000) (lineto 20.6999997972 0.0000000000) (moveto 20.9999997942 0.0000000000) (lineto 21.2999997913 0.0000000000) (moveto 21.5999997883 0.0000000000) (lineto 21.8999997854 0.0000000000) (moveto 22.1999997825 0.0000000000) (lineto 22.4999997795 0.0000000000) (moveto 22.7999997766 0.0000000000) (lineto 23.0999997736 0.0000000000) (moveto 23.3999997707 0.0000000000) (lineto 23.6999997678 0.0000000000) (moveto 23.9999997648 0.0000000000) (lineto 24.2999997619 0.0000000000) (moveto 24.5999997589 0.0000000000) (lineto 24.8999997560 0.0000000000) (moveto 25.1999997531 0.0000000000) (lineto 25.4999997501 0.0000000000) (moveto 25.7999997472 0.0000000000) (lineto 26.0999997442 0.0000000000) (moveto 26.3999997413 0.0000000000) (lineto 26.6999997384 0.0000000000) (moveto 26.9999997354 0.0000000000) (lineto 27.2999997325 0.0000000000) (moveto 27.5999997295 0.0000000000) (lineto 27.8999997266 0.0000000000) (moveto 28.1999997237 0.0000000000) (lineto 28.4999997207 0.0000000000) (moveto 28.7999997178 0.0000000000) (lineto 29.0999997148 0.0000000000) (moveto 29.3999997119 0.0000000000) (lineto 29.6999997090 0.0000000000) (moveto 29.9433784805 0.0000000000) (lineto 29.9433784805 -0.2999999971) (moveto 29.9433784805 -0.5999999941) (lineto 29.9433784805 -0.8999999912) (moveto 29.9433784805 -1.1999999882) (lineto 29.9433784805 -1.4999999853) (moveto 29.9433784805 -1.7999999824) (lineto 29.9433784805 -1.8999989273)) } "ottava_bracket" "op47-ottava_bracket-0009" % source p8 system 37, print m173; anchor m173
  \markAt #31.1020539987 #7.4066917772 \markup { \referenceInkBox #1.1386961456 #1.5781754256 { \musicglyph "eight" } } "ottava_text" "op47-ottava_text-0011" % source p8 system 37, print m173; anchor m173
  s1*3
  \markAt #-1.0692196176 #4.0000071821 \markup { \referenceText #2.1389451186 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "177" } } "bar_number" "op47-bar_number-0037" % source p8 system 38, print m177; anchor m177
  \markAt #58.1380892420 #5.7618793081 \markup { \override #'(line-cap-style . square) \path #0.1000000044 #'((moveto 0.0000000000 0.0000000000) (lineto 0.2999999971 0.0000000000) (moveto 0.5999999941 0.0000000000) (lineto 0.8999999912 0.0000000000) (moveto 1.1999999882 0.0000000000) (lineto 1.4999999853 0.0000000000) (moveto 1.7999999824 0.0000000000) (lineto 2.0999999794 0.0000000000) (moveto 2.3999999765 0.0000000000) (lineto 2.6999999735 0.0000000000) (moveto 2.9999999706 0.0000000000) (lineto 3.2999999677 0.0000000000) (moveto 3.5999999647 0.0000000000) (lineto 3.8999999618 0.0000000000) (moveto 4.1999999588 0.0000000000) (lineto 4.4999999559 0.0000000000) (moveto 4.7999999530 0.0000000000) (lineto 5.0999999500 0.0000000000) (moveto 5.3999999471 0.0000000000) (lineto 5.6999999441 0.0000000000) (moveto 5.9999999412 0.0000000000) (lineto 6.2999999383 0.0000000000) (moveto 6.5999999353 0.0000000000) (lineto 6.8999999324 0.0000000000) (moveto 7.1999999294 0.0000000000) (lineto 7.4999999265 0.0000000000) (moveto 7.7999999236 0.0000000000) (lineto 8.0999999206 0.0000000000) (moveto 8.3999999177 0.0000000000) (lineto 8.6999999147 0.0000000000) (moveto 8.9999999118 0.0000000000) (lineto 9.2999999089 0.0000000000) (moveto 9.5999999059 0.0000000000) (lineto 9.8999999030 0.0000000000) (moveto 10.1999999000 0.0000000000) (lineto 10.4999998971 0.0000000000) (moveto 10.7999998942 0.0000000000) (lineto 11.0999998912 0.0000000000) (moveto 11.3999998883 0.0000000000) (lineto 11.6999998853 0.0000000000) (moveto 11.9999998824 0.0000000000) (lineto 12.2999998795 0.0000000000) (moveto 12.5999998765 0.0000000000) (lineto 12.8999998736 0.0000000000) (moveto 13.1999998706 0.0000000000) (lineto 13.4999998677 0.0000000000) (moveto 13.7999998648 0.0000000000) (lineto 14.0999998618 0.0000000000) (moveto 14.3999998589 0.0000000000) (lineto 14.6999998559 0.0000000000) (moveto 14.9999998530 0.0000000000) (lineto 15.2999998501 0.0000000000) (moveto 15.5999998471 0.0000000000) (lineto 15.8999998442 0.0000000000) (moveto 16.1999998412 0.0000000000) (lineto 16.4999998383 0.0000000000) (moveto 16.7999998354 0.0000000000) (lineto 17.0999998324 0.0000000000) (moveto 17.3999998295 0.0000000000) (lineto 17.6999998266 0.0000000000) (moveto 17.9999998236 0.0000000000) (lineto 18.2999998207 0.0000000000) (moveto 18.5999998177 0.0000000000) (lineto 18.8999998148 0.0000000000) (moveto 19.1999998119 0.0000000000) (lineto 19.4999998089 0.0000000000) (moveto 19.7999998060 0.0000000000) (lineto 20.0999998030 0.0000000000) (moveto 20.3999998001 0.0000000000) (lineto 20.6999997972 0.0000000000) (moveto 20.9999997942 0.0000000000) (lineto 21.2999997913 0.0000000000) (moveto 21.5999997883 0.0000000000) (lineto 21.8999997854 0.0000000000) (moveto 22.1999997825 0.0000000000) (lineto 22.4999997795 0.0000000000) (moveto 22.7999997766 0.0000000000) (lineto 23.0999997736 0.0000000000) (moveto 23.3999997707 0.0000000000) (lineto 23.6999997678 0.0000000000) (moveto 23.9999997648 0.0000000000) (lineto 24.2999997619 0.0000000000) (moveto 24.5999997589 0.0000000000) (lineto 24.8999997560 0.0000000000) (moveto 25.1999997531 0.0000000000) (lineto 25.4999997501 0.0000000000) (moveto 25.7999997472 0.0000000000) (lineto 26.0999997442 0.0000000000) (moveto 26.3999997413 0.0000000000) (lineto 26.6999997384 0.0000000000) (moveto 26.9999997354 0.0000000000) (lineto 27.2999997325 0.0000000000) (moveto 27.5999997295 0.0000000000) (lineto 27.8999997266 0.0000000000) (moveto 28.1999997237 0.0000000000) (lineto 28.4999997207 0.0000000000) (moveto 28.7999997178 0.0000000000) (lineto 29.0999997148 0.0000000000) (moveto 29.3999997119 0.0000000000) (lineto 29.6999997090 0.0000000000) (moveto 29.9999997060 0.0000000000) (lineto 30.2999997031 0.0000000000) (moveto 30.5999997001 0.0000000000) (lineto 30.8999996972 0.0000000000) (moveto 31.1999996943 0.0000000000) (lineto 31.4999996913 0.0000000000) (moveto 31.7999996884 0.0000000000) (lineto 32.0999996854 0.0000000000) (moveto 32.3999996825 0.0000000000) (lineto 32.6999996796 0.0000000000) (moveto 32.9999996766 0.0000000000) (lineto 33.2999996737 0.0000000000) (moveto 33.5999996707 0.0000000000) (lineto 33.8999996678 0.0000000000) (moveto 34.1999996649 0.0000000000) (lineto 34.4999996619 0.0000000000) (moveto 34.7999996590 0.0000000000) (lineto 35.0999996560 0.0000000000) (moveto 35.3999996531 0.0000000000) (lineto 35.6999996502 0.0000000000) (moveto 35.9999996472 0.0000000000) (lineto 36.2999996443 0.0000000000) (moveto 36.5999996413 0.0000000000) (lineto 36.8999996384 0.0000000000) (moveto 37.1999996355 0.0000000000) (lineto 37.4999996325 0.0000000000) (moveto 37.7999996296 0.0000000000) (lineto 38.0999996266 0.0000000000) (moveto 38.3999996237 0.0000000000) (lineto 38.6999996208 0.0000000000) (moveto 38.9999996178 0.0000000000) (lineto 39.2999996149 0.0000000000) (moveto 39.5999996119 0.0000000000) (lineto 39.8999996090 0.0000000000) (moveto 40.1999996061 0.0000000000) (lineto 40.4999996031 0.0000000000) (moveto 40.7999996002 0.0000000000) (lineto 41.0999995972 0.0000000000) (moveto 41.3999995943 0.0000000000) (lineto 41.6999995914 0.0000000000) (moveto 41.9999995884 0.0000000000) (lineto 42.2999995855 0.0000000000) (moveto 42.5999995825 0.0000000000) (lineto 42.8999995796 0.0000000000) (moveto 43.1999995767 0.0000000000) (lineto 43.4999995737 0.0000000000) (moveto 43.7999995708 0.0000000000) (lineto 44.0999995678 0.0000000000) (moveto 44.3999995649 0.0000000000) (lineto 44.6999995620 0.0000000000) (moveto 44.9999995590 0.0000000000) (lineto 45.2999995561 0.0000000000) (moveto 45.5999995531 0.0000000000) (lineto 45.8999995502 0.0000000000) (moveto 46.1999995473 0.0000000000) (lineto 46.4999995443 0.0000000000) (moveto 46.7999995414 0.0000000000) (lineto 47.0999995384 0.0000000000) (moveto 47.3999995355 0.0000000000) (lineto 47.6999995326 0.0000000000) (moveto 47.9999995296 0.0000000000) (lineto 48.2999995267 0.0000000000) (moveto 48.5999995237 0.0000000000) (lineto 48.8999995208 0.0000000000) (moveto 49.1999995179 0.0000000000) (lineto 49.4999995149 0.0000000000) (moveto 49.7999995120 0.0000000000) (lineto 50.0999995091 0.0000000000) (moveto 50.3999995061 0.0000000000) (lineto 50.6999995032 0.0000000000) (moveto 50.9999995002 0.0000000000) (lineto 51.2999994973 0.0000000000) (moveto 51.5999994944 0.0000000000) (lineto 51.8999994914 0.0000000000) (moveto 52.1999994885 0.0000000000) (lineto 52.4999994855 0.0000000000) (moveto 52.7999994826 0.0000000000) (lineto 53.0999994797 0.0000000000) (moveto 53.3999994767 0.0000000000) (lineto 53.6999994738 0.0000000000) (moveto 53.9999994708 0.0000000000) (lineto 54.2999994679 0.0000000000) (moveto 54.5999994650 0.0000000000) (lineto 54.8999994620 0.0000000000) (moveto 55.1999994591 0.0000000000) (lineto 55.4999994561 0.0000000000) (moveto 55.7999994532 0.0000000000) (lineto 56.0999994503 0.0000000000) (moveto 56.3999994473 0.0000000000) (lineto 56.6999994444 0.0000000000) (moveto 56.9999994414 0.0000000000) (lineto 57.2999994385 0.0000000000) (moveto 57.5999994356 0.0000000000) (lineto 57.8999994326 0.0000000000) (moveto 58.1999994297 0.0000000000) (lineto 58.4999994267 0.0000000000) (moveto 58.7999994238 0.0000000000) (lineto 59.0999994209 0.0000000000) (moveto 59.3999994179 0.0000000000) (lineto 59.6999994150 0.0000000000) (moveto 59.9999994120 0.0000000000) (lineto 60.2999994091 0.0000000000) (moveto 60.5999994062 0.0000000000) (lineto 60.8999994032 0.0000000000) (moveto 61.1999994003 0.0000000000) (lineto 61.4999993973 0.0000000000) (moveto 61.7999993944 0.0000000000) (lineto 62.0999993915 0.0000000000) (moveto 62.3999993885 0.0000000000) (lineto 62.6999993856 0.0000000000) (moveto 62.9999993826 0.0000000000) (lineto 63.2999993797 0.0000000000) (moveto 63.5999993768 0.0000000000) (lineto 63.8999993738 0.0000000000) (moveto 64.1999993709 0.0000000000) (lineto 64.4999993679 0.0000000000) (moveto 64.7999993650 0.0000000000) (lineto 65.0999993621 0.0000000000) (moveto 65.3999993591 0.0000000000) (lineto 65.6999993562 0.0000000000) (moveto 65.9999993532 0.0000000000) (lineto 66.2999993503 0.0000000000) (moveto 66.5999993474 0.0000000000) (lineto 66.8999993444 0.0000000000) (moveto 67.1999993415 0.0000000000) (lineto 67.4999993385 0.0000000000) (moveto 67.7999993356 0.0000000000) (lineto 68.0999993327 0.0000000000) (moveto 68.3999993297 0.0000000000) (lineto 68.6999993268 0.0000000000) (moveto 68.9999993238 0.0000000000) (lineto 69.2999993209 0.0000000000) (moveto 69.5999993180 0.0000000000) (lineto 69.8999993150 0.0000000000) (moveto 70.1999993121 0.0000000000) (lineto 70.3863891470 0.0000000000)) } "ottava_bracket" "op47-ottava_bracket-0010" % source p8 system 38, print m178; anchor m177
  \markAt #56.4631504344 #4.9766941646 \markup { \referenceInkBox #1.1386961456 #1.5781754256 { \musicglyph "eight" } } "ottava_text" "op47-ottava_text-0009" % source p8 system 38, print m178; anchor m177
  s1*9/4
  \markAt #-1.0927381368 #4.0000071776 \markup { \referenceText #2.1709613492 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "180" } } "bar_number" "op47-bar_number-0036" % source p8 system 39, print m180; anchor m180
  \markAt #11.1371758356 #5.2618739197 \markup { \override #'(line-cap-style . square) \path #0.1000000044 #'((moveto 0.0000000000 0.0000000000) (lineto 0.2999999971 0.0000000000) (moveto 0.5999999941 0.0000000000) (lineto 0.8999999912 0.0000000000) (moveto 1.1999999882 0.0000000000) (lineto 1.4999999853 0.0000000000) (moveto 1.7999999824 0.0000000000) (lineto 2.0999999794 0.0000000000) (moveto 2.3999999765 0.0000000000) (lineto 2.6999999735 0.0000000000) (moveto 2.9999999706 0.0000000000) (lineto 3.2999999677 0.0000000000) (moveto 3.5999999647 0.0000000000) (lineto 3.8999999618 0.0000000000) (moveto 4.1999999588 0.0000000000) (lineto 4.4999999559 0.0000000000) (moveto 4.7999999530 0.0000000000) (lineto 5.0999999500 0.0000000000) (moveto 5.3999999471 0.0000000000) (lineto 5.6999999441 0.0000000000) (moveto 5.9999999412 0.0000000000) (lineto 6.2999999383 0.0000000000) (moveto 6.5999999353 0.0000000000) (lineto 6.8999999324 0.0000000000) (moveto 7.1999999294 0.0000000000) (lineto 7.4999999265 0.0000000000) (moveto 7.7999999236 0.0000000000) (lineto 8.0999999206 0.0000000000) (moveto 8.3999999177 0.0000000000) (lineto 8.6999999147 0.0000000000) (moveto 8.9999999118 0.0000000000) (lineto 9.2999999089 0.0000000000) (moveto 9.5999999059 0.0000000000) (lineto 9.8999999030 0.0000000000) (moveto 10.1999999000 0.0000000000) (lineto 10.4999998971 0.0000000000) (moveto 10.7999998942 0.0000000000) (lineto 11.0999998912 0.0000000000) (moveto 11.3999998883 0.0000000000) (lineto 11.6999998853 0.0000000000) (moveto 11.9999998824 0.0000000000) (lineto 12.2999998795 0.0000000000) (moveto 12.5999998765 0.0000000000) (lineto 12.8999998736 0.0000000000) (moveto 13.1999998706 0.0000000000) (lineto 13.4999998677 0.0000000000) (moveto 13.7999998648 0.0000000000) (lineto 14.0999998618 0.0000000000) (moveto 14.3999998589 0.0000000000) (lineto 14.6999998559 0.0000000000) (moveto 14.9999998530 0.0000000000) (lineto 15.2999998501 0.0000000000) (moveto 15.5999998471 0.0000000000) (lineto 15.8999998442 0.0000000000) (moveto 16.1999998412 0.0000000000) (lineto 16.4999998383 0.0000000000) (moveto 16.7999998354 0.0000000000) (lineto 17.0999998324 0.0000000000) (moveto 17.3999998295 0.0000000000) (lineto 17.6999998266 0.0000000000) (moveto 17.9999998236 0.0000000000) (lineto 18.2999998207 0.0000000000) (moveto 18.5999998177 0.0000000000) (lineto 18.8999998148 0.0000000000) (moveto 19.1999998119 0.0000000000) (lineto 19.4999998089 0.0000000000) (moveto 19.7999998060 0.0000000000) (lineto 20.0999998030 0.0000000000) (moveto 20.3999998001 0.0000000000) (lineto 20.6999997972 0.0000000000) (moveto 20.9999997942 0.0000000000) (lineto 21.2999997913 0.0000000000) (moveto 21.5999997883 0.0000000000) (lineto 21.8999997854 0.0000000000) (moveto 22.1999997825 0.0000000000) (lineto 22.4999997795 0.0000000000) (moveto 22.7999997766 0.0000000000) (lineto 23.0999997736 0.0000000000) (moveto 23.3999997707 0.0000000000) (lineto 23.6999997678 0.0000000000) (moveto 23.9999997648 0.0000000000) (lineto 24.2999997619 0.0000000000) (moveto 24.5999997589 0.0000000000) (lineto 24.8999997560 0.0000000000) (moveto 25.1999997531 0.0000000000) (lineto 25.4999997501 0.0000000000) (moveto 25.7999997472 0.0000000000) (lineto 26.0999997442 0.0000000000) (moveto 26.3999997413 0.0000000000) (lineto 26.6999997384 0.0000000000) (moveto 26.9999997354 0.0000000000) (lineto 27.2999997325 0.0000000000) (moveto 27.5999997295 0.0000000000) (lineto 27.8999997266 0.0000000000) (moveto 28.1999997237 0.0000000000) (lineto 28.4999997207 0.0000000000) (moveto 28.7999997178 0.0000000000) (lineto 29.0999997148 0.0000000000) (moveto 29.3999997119 0.0000000000) (lineto 29.6999997090 0.0000000000) (moveto 29.9999997060 0.0000000000) (lineto 30.2999997031 0.0000000000) (moveto 30.5999997001 0.0000000000) (lineto 30.8999996972 0.0000000000) (moveto 31.1999996943 0.0000000000) (lineto 31.4999996913 0.0000000000) (moveto 31.7999996884 0.0000000000) (lineto 32.0999996854 0.0000000000) (moveto 32.3999996825 0.0000000000) (lineto 32.6999996796 0.0000000000) (moveto 32.9999996766 0.0000000000) (lineto 33.2999996737 0.0000000000) (moveto 33.5999996707 0.0000000000) (lineto 33.8999996678 0.0000000000) (moveto 34.1999996649 0.0000000000) (lineto 34.4999996619 0.0000000000) (moveto 34.7999996590 0.0000000000) (lineto 35.0999996560 0.0000000000) (moveto 35.3999996531 0.0000000000) (lineto 35.6999996502 0.0000000000) (moveto 35.9999996472 0.0000000000) (lineto 36.2999996443 0.0000000000) (moveto 36.5999996413 0.0000000000) (lineto 36.8999996384 0.0000000000) (moveto 37.1939571639 0.0000000000) (lineto 37.1939571639 -0.2999999971) (moveto 37.1939571639 -0.5999999941) (lineto 37.1939571639 -0.8999999912) (moveto 37.1939571639 -1.1999999882) (lineto 37.1939571639 -1.4999999853) (moveto 37.1939571639 -1.7999999824) (lineto 37.1939571639 -1.8999989273)) } "ottava_bracket" "op47-ottava_bracket-0011" % source p8 system 39, print m180; anchor m180
  \markAt #9.4622382980 #4.4766861419 \markup { \referenceInkBox #1.1386961456 #1.5781754256 { \musicglyph "eight" } } "ottava_text" "op47-ottava_text-0010" % source p8 system 39, print m180; anchor m180
  s1*9/4
  \markAt #-1.0457013336 #4.0000071926 \markup { \referenceText #2.1217657810 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "183" } } "bar_number" "op47-bar_number-0035" % source p8 system 40, print m183; anchor m183
  \markAt #59.9528445458 #-7.0048782524 \markup { \referenceInkBox #2.5969725139 #2.4293435626 { \dynamic "fz" } } "dynamics" "op47-dynamics-0021" % source p8 system 40, print m184; anchor m183
  \markAt #45.6369196302 #-7.0048782524 \markup { \referenceInkBox #2.5969819213 #2.4293435626 { \dynamic "fz" } } "dynamics" "op47-dynamics-0022" % source p8 system 40, print m184; anchor m183
  \markAt #29.4899556961 #-7.0048782524 \markup { \referenceInkBox #2.5969795695 #2.4293435626 { \dynamic "fz" } } "dynamics" "op47-dynamics-0023" % source p8 system 40, print m183; anchor m183
  s1*3
  \markAt #-1.0692193787 #4.0000004674 \markup { \referenceText #2.1389446407 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "187" } } "bar_number" "op47-bar_number-0044" % source p9 system 41, print m187; anchor m187
  s1*3
  \markAt #-1.0221825791 #4.0000036016 \markup { \referenceText #2.0491427103 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "191" } } "bar_number" "op47-bar_number-0043" % source p9 system 42, print m191; anchor m191
  s1*9/4
  \markAt #-1.0927381368 #3.9999999989 \markup { \referenceText #2.1756467086 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "194" } } "bar_number" "op47-bar_number-0042" % source p9 system 43, print m194; anchor m194
  \markAt #100.6975161239 #-6.5200731179 \markup { \referenceInkBox #1.8043647843 #1.6117535211 { \dynamic "p" } } "dynamics" "op47-dynamics-0025" % source p9 system 43, print m197; anchor m194
  s1*3
  \markAt #-1.0692196176 #4.0000071953 \markup { \referenceText #2.1381640685 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "198" } } "bar_number" "op47-bar_number-0041" % source p9 system 44, print m198; anchor m198
  s1*9/4
  \markAt #-1.1047732687 #4.0000071867 \markup { \referenceText #2.1787706735 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "201" } } "bar_number" "op47-bar_number-0040" % source p9 system 45, print m201; anchor m201
  s1*9/4
  \markAt #-1.1753285638 #4.0000004674 \markup { \referenceText #2.3052739215 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "204" } } "bar_number" "op47-bar_number-0049" % source p10 system 46, print m204; anchor m204
  s1*3
  \markAt #-1.1518100720 #3.9999999995 \markup { \referenceText #2.2677913262 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "208" } } "bar_number" "op47-bar_number-0048" % source p10 system 47, print m208; anchor m208
  s1*3/2
  \markAt #-1.1753288264 #4.0000071821 \markup { \referenceText #2.3005890772 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "210" } } "bar_number" "op47-bar_number-0047" % source p10 system 48, print m210; anchor m210
  \markAt #94.9513974352 #-6.0936779068 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 0.0000000000) (lineto 32.4085238076 -0.5644430261) (moveto 0.0000000000 0.0000000000) (lineto 32.4085238076 0.5644430261)) } "wedge" "op47-wedge-0038" % source p10 system 48, print m212; anchor m210
  s1*9/4
  \markAt #-1.1282915527 #4.0000071776 \markup { \referenceText #2.2513930386 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "213" } } "bar_number" "op47-bar_number-0046" % source p10 system 49, print m213; anchor m213
  \markAt #12.9337393565 #8.0649974788 \markup { \override #'(line-cap-style . square) \path #0.1000000044 #'((moveto 0.0000000000 0.0000000000) (lineto 0.2999999971 0.0000000000) (moveto 0.5999999941 0.0000000000) (lineto 0.8999999912 0.0000000000) (moveto 1.1999999882 0.0000000000) (lineto 1.4999999853 0.0000000000) (moveto 1.7999999824 0.0000000000) (lineto 2.0999999794 0.0000000000) (moveto 2.3999999765 0.0000000000) (lineto 2.6999999735 0.0000000000) (moveto 2.9999999706 0.0000000000) (lineto 3.2999999677 0.0000000000) (moveto 3.5999999647 0.0000000000) (lineto 3.8999999618 0.0000000000) (moveto 4.1999999588 0.0000000000) (lineto 4.4999999559 0.0000000000) (moveto 4.7999999530 0.0000000000) (lineto 5.0999999500 0.0000000000) (moveto 5.3999999471 0.0000000000) (lineto 5.6999999441 0.0000000000) (moveto 5.9999999412 0.0000000000) (lineto 6.2999999383 0.0000000000) (moveto 6.5999999353 0.0000000000) (lineto 6.8999999324 0.0000000000) (moveto 7.1999999294 0.0000000000) (lineto 7.4999999265 0.0000000000) (moveto 7.7999999236 0.0000000000) (lineto 8.0999999206 0.0000000000) (moveto 8.3999999177 0.0000000000) (lineto 8.6999999147 0.0000000000) (moveto 8.9999999118 0.0000000000) (lineto 9.2999999089 0.0000000000) (moveto 9.5999999059 0.0000000000) (lineto 9.8999999030 0.0000000000) (moveto 10.1999999000 0.0000000000) (lineto 10.4999998971 0.0000000000) (moveto 10.7999998942 0.0000000000) (lineto 11.0999998912 0.0000000000) (moveto 11.3999998883 0.0000000000) (lineto 11.6999998853 0.0000000000) (moveto 11.9999998824 0.0000000000) (lineto 12.2999998795 0.0000000000) (moveto 12.5999998765 0.0000000000) (lineto 12.8999998736 0.0000000000) (moveto 13.1999998706 0.0000000000) (lineto 13.4999998677 0.0000000000) (moveto 13.7999998648 0.0000000000) (lineto 14.0999998618 0.0000000000) (moveto 14.3999998589 0.0000000000) (lineto 14.6999998559 0.0000000000) (moveto 14.9999998530 0.0000000000) (lineto 15.2999998501 0.0000000000) (moveto 15.5999998471 0.0000000000) (lineto 15.8999998442 0.0000000000) (moveto 16.1999998412 0.0000000000) (lineto 16.4999998383 0.0000000000) (moveto 16.7999998354 0.0000000000) (lineto 17.0999998324 0.0000000000) (moveto 17.3999998295 0.0000000000) (lineto 17.6999998266 0.0000000000) (moveto 17.9999998236 0.0000000000) (lineto 18.2999998207 0.0000000000) (moveto 18.5999998177 0.0000000000) (lineto 18.8999998148 0.0000000000) (moveto 19.1999998119 0.0000000000) (lineto 19.4999998089 0.0000000000) (moveto 19.7999998060 0.0000000000) (lineto 20.0999998030 0.0000000000) (moveto 20.3999998001 0.0000000000) (lineto 20.6999997972 0.0000000000) (moveto 20.9999997942 0.0000000000) (lineto 21.2999997913 0.0000000000) (moveto 21.5999997883 0.0000000000) (lineto 21.8999997854 0.0000000000) (moveto 22.1999997825 0.0000000000) (lineto 22.4999997795 0.0000000000) (moveto 22.7999997766 0.0000000000) (lineto 23.0999997736 0.0000000000) (moveto 23.3999997707 0.0000000000) (lineto 23.6999997678 0.0000000000) (moveto 23.9999997648 0.0000000000) (lineto 24.2999997619 0.0000000000) (moveto 24.5999997589 0.0000000000) (lineto 24.8999997560 0.0000000000) (moveto 25.1999997531 0.0000000000) (lineto 25.4999997501 0.0000000000) (moveto 25.7999997472 0.0000000000) (lineto 26.0999997442 0.0000000000) (moveto 26.3999997413 0.0000000000) (lineto 26.6999997384 0.0000000000) (moveto 26.9999997354 0.0000000000) (lineto 27.2999997325 0.0000000000) (moveto 27.5999997295 0.0000000000) (lineto 27.8999997266 0.0000000000) (moveto 28.1999997237 0.0000000000) (lineto 28.4999997207 0.0000000000) (moveto 28.7999997178 0.0000000000) (lineto 29.0999997148 0.0000000000) (moveto 29.3999997119 0.0000000000) (lineto 29.6999997090 0.0000000000) (moveto 29.9999997060 0.0000000000) (lineto 30.2999997031 0.0000000000) (moveto 30.5999997001 0.0000000000) (lineto 30.8999996972 0.0000000000) (moveto 31.1999996943 0.0000000000) (lineto 31.4999996913 0.0000000000) (moveto 31.7999996884 0.0000000000) (lineto 32.0999996854 0.0000000000) (moveto 32.3999996825 0.0000000000) (lineto 32.6999996796 0.0000000000) (moveto 32.9999996766 0.0000000000) (lineto 33.2999996737 0.0000000000) (moveto 33.5999996707 0.0000000000) (lineto 33.8999996678 0.0000000000) (moveto 34.1999996649 0.0000000000) (lineto 34.4999996619 0.0000000000) (moveto 34.7999996590 0.0000000000) (lineto 35.0999996560 0.0000000000) (moveto 35.3999996531 0.0000000000) (lineto 35.6999996502 0.0000000000) (moveto 35.9999996472 0.0000000000) (lineto 36.2999996443 0.0000000000) (moveto 36.5999996413 0.0000000000) (lineto 36.8999996384 0.0000000000) (moveto 37.1999996355 0.0000000000) (lineto 37.4999996325 0.0000000000) (moveto 37.7999996296 0.0000000000) (lineto 38.0999996266 0.0000000000) (moveto 38.3999996237 0.0000000000) (lineto 38.6999996208 0.0000000000) (moveto 38.9999996178 0.0000000000) (lineto 39.2999996149 0.0000000000) (moveto 39.5999996119 0.0000000000) (lineto 39.8999996090 0.0000000000) (moveto 40.1999996061 0.0000000000) (lineto 40.4999996031 0.0000000000) (moveto 40.7999996002 0.0000000000) (lineto 41.0999995972 0.0000000000) (moveto 41.3999995943 0.0000000000) (lineto 41.6999995914 0.0000000000) (moveto 41.9999995884 0.0000000000) (lineto 42.2999995855 0.0000000000) (moveto 42.5999995825 0.0000000000) (lineto 42.8999995796 0.0000000000) (moveto 43.1999995767 0.0000000000) (lineto 43.4999995737 0.0000000000) (moveto 43.7999995708 0.0000000000) (lineto 44.0999995678 0.0000000000) (moveto 44.3999995649 0.0000000000) (lineto 44.6999995620 0.0000000000) (moveto 44.9999995590 0.0000000000) (lineto 45.2999995561 0.0000000000) (moveto 45.5999995531 0.0000000000) (lineto 45.8999995502 0.0000000000) (moveto 46.1999995473 0.0000000000) (lineto 46.4999995443 0.0000000000) (moveto 46.7999995414 0.0000000000) (lineto 47.0999995384 0.0000000000) (moveto 47.3999995355 0.0000000000) (lineto 47.6999995326 0.0000000000) (moveto 47.9999995296 0.0000000000) (lineto 48.2999995267 0.0000000000) (moveto 48.5999995237 0.0000000000) (lineto 48.8999995208 0.0000000000) (moveto 49.1999995179 0.0000000000) (lineto 49.4999995149 0.0000000000) (moveto 49.7999995120 0.0000000000) (lineto 50.0999995091 0.0000000000) (moveto 50.3999995061 0.0000000000) (lineto 50.6999995032 0.0000000000) (moveto 50.9999995002 0.0000000000) (lineto 51.2999994973 0.0000000000) (moveto 51.5999994944 0.0000000000) (lineto 51.8999994914 0.0000000000) (moveto 52.1999994885 0.0000000000) (lineto 52.4999994855 0.0000000000) (moveto 52.7999994826 0.0000000000) (lineto 53.0999994797 0.0000000000) (moveto 53.3999994767 0.0000000000) (lineto 53.6999994738 0.0000000000) (moveto 53.9999994708 0.0000000000) (lineto 54.2999994679 0.0000000000) (moveto 54.5999994650 0.0000000000) (lineto 54.8999994620 0.0000000000) (moveto 55.1999994591 0.0000000000) (lineto 55.4999994561 0.0000000000) (moveto 55.7999994532 0.0000000000) (lineto 56.0999994503 0.0000000000) (moveto 56.3999994473 0.0000000000) (lineto 56.6999994444 0.0000000000) (moveto 56.9999994414 0.0000000000) (lineto 57.2999994385 0.0000000000) (moveto 57.5999994356 0.0000000000) (lineto 57.8999994326 0.0000000000) (moveto 58.1999994297 0.0000000000) (lineto 58.4999994267 0.0000000000) (moveto 58.7999994238 0.0000000000) (lineto 59.0999994209 0.0000000000) (moveto 59.3999994179 0.0000000000) (lineto 59.6999994150 0.0000000000) (moveto 59.9999994120 0.0000000000) (lineto 60.2999994091 0.0000000000) (moveto 60.5999994062 0.0000000000) (lineto 60.8999994032 0.0000000000) (moveto 61.1999994003 0.0000000000) (lineto 61.4999993973 0.0000000000) (moveto 61.7999993944 0.0000000000) (lineto 62.0999993915 0.0000000000) (moveto 62.3999993885 0.0000000000) (lineto 62.6999993856 0.0000000000) (moveto 62.9999993826 0.0000000000) (lineto 63.2999993797 0.0000000000) (moveto 63.5999993768 0.0000000000) (lineto 63.8999993738 0.0000000000) (moveto 64.1999993709 0.0000000000) (lineto 64.4999993679 0.0000000000) (moveto 64.7999993650 0.0000000000) (lineto 65.0999993621 0.0000000000) (moveto 65.3999993591 0.0000000000) (lineto 65.6999993562 0.0000000000) (moveto 65.9999993532 0.0000000000) (lineto 66.2999993503 0.0000000000) (moveto 66.5999993474 0.0000000000) (lineto 66.8999993444 0.0000000000) (moveto 67.1999993415 0.0000000000) (lineto 67.4999993385 0.0000000000) (moveto 67.7999993356 0.0000000000) (lineto 68.0999993327 0.0000000000) (moveto 68.3999993297 0.0000000000) (lineto 68.6999993268 0.0000000000) (moveto 68.9999993238 0.0000000000) (lineto 69.2999993209 0.0000000000) (moveto 69.5999993180 0.0000000000) (lineto 69.8999993150 0.0000000000) (moveto 70.1999993121 0.0000000000) (lineto 70.4999993091 0.0000000000) (moveto 70.7999993062 0.0000000000) (lineto 71.0999993033 0.0000000000) (moveto 71.3999993003 0.0000000000) (lineto 71.6999992974 0.0000000000) (moveto 71.9999992944 0.0000000000) (lineto 72.2999992915 0.0000000000) (moveto 72.5999992886 0.0000000000) (lineto 72.8999992856 0.0000000000) (moveto 73.1999992827 0.0000000000) (lineto 73.4999992797 0.0000000000) (moveto 73.7999992768 0.0000000000) (lineto 74.0999992739 0.0000000000) (moveto 74.3999992709 0.0000000000) (lineto 74.6999992680 0.0000000000) (moveto 74.9999992650 0.0000000000) (lineto 75.2999992621 0.0000000000) (moveto 75.5999992592 0.0000000000) (lineto 75.8999992562 0.0000000000) (moveto 76.1999992533 0.0000000000) (lineto 76.4999992503 0.0000000000) (moveto 76.7999992474 0.0000000000) (lineto 77.0999992445 0.0000000000) (moveto 77.3999992415 0.0000000000) (lineto 77.6999992386 0.0000000000) (moveto 77.9999992356 0.0000000000) (lineto 78.2999992327 0.0000000000) (moveto 78.5999992298 0.0000000000) (lineto 78.8999992268 0.0000000000) (moveto 79.1999992239 0.0000000000) (lineto 79.4999992209 0.0000000000) (moveto 79.7999992180 0.0000000000) (lineto 80.0999992151 0.0000000000) (moveto 80.3999992121 0.0000000000) (lineto 80.6999992092 0.0000000000) (moveto 80.9999992063 0.0000000000) (lineto 81.2999992033 0.0000000000) (moveto 81.5999992004 0.0000000000) (lineto 81.8999991974 0.0000000000) (moveto 82.1999991945 0.0000000000) (lineto 82.4999991916 0.0000000000) (moveto 82.7999991886 0.0000000000) (lineto 83.0999991857 0.0000000000) (moveto 83.3999991827 0.0000000000) (lineto 83.6999991798 0.0000000000) (moveto 83.9999991769 0.0000000000) (lineto 84.2999991739 0.0000000000) (moveto 84.5999991710 0.0000000000) (lineto 84.8999991680 0.0000000000) (moveto 85.1999991651 0.0000000000) (lineto 85.4999991622 0.0000000000) (moveto 85.7999991592 0.0000000000) (lineto 86.0999991563 0.0000000000) (moveto 86.3999991533 0.0000000000) (lineto 86.6999991504 0.0000000000) (moveto 86.9999991475 0.0000000000) (lineto 87.2999991445 0.0000000000) (moveto 87.5999991416 0.0000000000) (lineto 87.8999991386 0.0000000000) (moveto 88.1999991357 0.0000000000) (lineto 88.4999991328 0.0000000000) (moveto 88.7999991298 0.0000000000) (lineto 89.0999991269 0.0000000000) (moveto 89.3999991239 0.0000000000) (lineto 89.6999991210 0.0000000000) (moveto 89.9999991181 0.0000000000) (lineto 90.2999991151 0.0000000000) (moveto 90.5999991122 0.0000000000) (lineto 90.8999991092 0.0000000000) (moveto 91.1999991063 0.0000000000) (lineto 91.4999991034 0.0000000000) (moveto 91.7999991004 0.0000000000) (lineto 92.0999990975 0.0000000000) (moveto 92.3999990945 0.0000000000) (lineto 92.6999990916 0.0000000000) (moveto 92.9999990887 0.0000000000) (lineto 93.2999990857 0.0000000000) (moveto 93.5999990828 0.0000000000) (lineto 93.8999990798 0.0000000000) (moveto 94.1999990769 0.0000000000) (lineto 94.4999990740 0.0000000000) (moveto 94.7999990710 0.0000000000) (lineto 95.0999990681 0.0000000000) (moveto 95.3999990651 0.0000000000) (lineto 95.6999990622 0.0000000000) (moveto 95.9999990593 0.0000000000) (lineto 96.2999990563 0.0000000000) (moveto 96.5999990534 0.0000000000) (lineto 96.8999990504 0.0000000000) (moveto 97.1999990475 0.0000000000) (lineto 97.4999990446 0.0000000000) (moveto 97.7999990416 0.0000000000) (lineto 98.0999990387 0.0000000000) (moveto 98.3999990357 0.0000000000) (lineto 98.6999990328 0.0000000000) (moveto 98.9999990299 0.0000000000) (lineto 99.2999990269 0.0000000000) (moveto 99.5999990240 0.0000000000) (lineto 99.8999990210 0.0000000000) (moveto 100.1999990181 0.0000000000) (lineto 100.4999990152 0.0000000000) (moveto 100.7999990122 0.0000000000) (lineto 101.0999990093 0.0000000000) (moveto 101.3999990063 0.0000000000) (lineto 101.6999990034 0.0000000000) (moveto 101.9999990005 0.0000000000) (lineto 102.2999989975 0.0000000000) (moveto 102.5999989946 0.0000000000) (lineto 102.8999989916 0.0000000000) (moveto 103.1999989887 0.0000000000) (lineto 103.4999989858 0.0000000000) (moveto 103.7999989828 0.0000000000) (lineto 104.0999989799 0.0000000000) (moveto 104.3999989769 0.0000000000) (lineto 104.6999989740 0.0000000000) (moveto 104.9999989711 0.0000000000) (lineto 105.2999989681 0.0000000000) (moveto 105.5999989652 0.0000000000) (lineto 105.8999989622 0.0000000000) (moveto 106.1999989593 0.0000000000) (lineto 106.4999989564 0.0000000000) (moveto 106.7999989534 0.0000000000) (lineto 107.0999989505 0.0000000000) (moveto 107.3999989475 0.0000000000) (lineto 107.6999989446 0.0000000000) (moveto 107.9999989417 0.0000000000) (lineto 108.2999989387 0.0000000000) (moveto 108.5999989358 0.0000000000) (lineto 108.8999989328 0.0000000000) (moveto 109.1999989299 0.0000000000) (lineto 109.4999989270 0.0000000000) (moveto 109.7999989240 0.0000000000) (lineto 110.0999989211 0.0000000000) (moveto 110.3999989181 0.0000000000) (lineto 110.6999989152 0.0000000000) (moveto 110.9999989123 0.0000000000) (lineto 111.2999989093 0.0000000000) (moveto 111.5999989064 0.0000000000) (lineto 111.8999989034 0.0000000000) (moveto 112.1999989005 0.0000000000) (lineto 112.4999988976 0.0000000000) (moveto 112.7999988946 0.0000000000) (lineto 113.0999988917 0.0000000000) (moveto 113.3999988888 0.0000000000) (lineto 113.6999988858 0.0000000000) (moveto 113.9999988829 0.0000000000) (lineto 114.2999988799 0.0000000000) (moveto 114.5999988770 0.0000000000) (lineto 114.8999988741 0.0000000000) (moveto 115.1999988711 0.0000000000) (lineto 115.4999988682 0.0000000000)) } "ottava_bracket" "op47-ottava_bracket-0012" % source p10 system 49, print m213; anchor m213
  \markAt #11.2588017544 #7.2798184676 \markup { \referenceInkBox #1.1386961456 #1.5781754256 { \musicglyph "eight" } } "ottava_text" "op47-ottava_text-0013" % source p10 system 49, print m213; anchor m213
  s1*9/4
  \markAt #-1.1518100720 #4.0000071945 \markup { \referenceText #2.3029312865 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "216" } } "bar_number" "op47-bar_number-0045" % source p10 system 50, print m216; anchor m216
  \markAt #11.0537381325 #5.2918749772 \markup { \override #'(line-cap-style . square) \path #0.1000000044 #'((moveto 0.0000000000 0.0000000000) (lineto 0.2999999971 0.0000000000) (moveto 0.5999999941 0.0000000000) (lineto 0.8999999912 0.0000000000) (moveto 1.1999999882 0.0000000000) (lineto 1.4999999853 0.0000000000) (moveto 1.7999999824 0.0000000000) (lineto 2.0999999794 0.0000000000) (moveto 2.3999999765 0.0000000000) (lineto 2.6999999735 0.0000000000) (moveto 2.9999999706 0.0000000000) (lineto 3.2999999677 0.0000000000) (moveto 3.5999999647 0.0000000000) (lineto 3.8999999618 0.0000000000) (moveto 4.1999999588 0.0000000000) (lineto 4.4999999559 0.0000000000) (moveto 4.7999999530 0.0000000000) (lineto 5.0999999500 0.0000000000) (moveto 5.3999999471 0.0000000000) (lineto 5.6999999441 0.0000000000) (moveto 5.9999999412 0.0000000000) (lineto 6.2999999383 0.0000000000) (moveto 6.5999999353 0.0000000000) (lineto 6.8999999324 0.0000000000) (moveto 7.1999999294 0.0000000000) (lineto 7.4999999265 0.0000000000) (moveto 7.7999999236 0.0000000000) (lineto 8.0999999206 0.0000000000) (moveto 8.3999999177 0.0000000000) (lineto 8.6999999147 0.0000000000) (moveto 8.9999999118 0.0000000000) (lineto 9.2999999089 0.0000000000) (moveto 9.5999999059 0.0000000000) (lineto 9.8999999030 0.0000000000) (moveto 10.1999999000 0.0000000000) (lineto 10.4999998971 0.0000000000) (moveto 10.7999998942 0.0000000000) (lineto 11.0999998912 0.0000000000) (moveto 11.3999998883 0.0000000000) (lineto 11.6999998853 0.0000000000) (moveto 11.9999998824 0.0000000000) (lineto 12.2999998795 0.0000000000) (moveto 12.5999998765 0.0000000000) (lineto 12.8999998736 0.0000000000) (moveto 13.1999998706 0.0000000000) (lineto 13.4999998677 0.0000000000) (moveto 13.7999998648 0.0000000000) (lineto 14.0999998618 0.0000000000) (moveto 14.3999998589 0.0000000000) (lineto 14.6999998559 0.0000000000) (moveto 14.7196661432 0.0000000000) (lineto 14.7196661432 -0.2999999971) (moveto 14.7196661432 -0.5999999941) (lineto 14.7196661432 -0.8999999912) (moveto 14.7196661432 -1.1999999882) (lineto 14.7196661432 -1.4999999853) (moveto 14.7196661432 -1.7999999824) (lineto 14.7196661432 -1.8999989273)) } "ottava_bracket" "op47-ottava_bracket-0013" % source p10 system 50, print m216; anchor m216
  \markAt #9.3787997659 #4.5067020754 \markup { \referenceInkBox #1.1386961456 #1.5781754256 { \musicglyph "eight" } } "ottava_text" "op47-ottava_text-0012" % source p10 system 50, print m216; anchor m216
  \markAt #57.4137220077 #7.7094564534 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 0.0000000000) (lineto 44.7792591817 -0.5644502034) (moveto 0.0000000000 0.0000000000) (lineto 44.7792591817 0.5644502034)) } "wedge" "op47-wedge-0039" % source p10 system 50, print m217; anchor m216
  s1*9/4
  \markAt #-1.1518098146 #4.0000004674 \markup { \referenceText #2.2919984259 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "219" } } "bar_number" "op47-bar_number-0054" % source p11 system 51, print m219; anchor m219
  \markAt #114.2401822087 #5.0415055642 \markup { \override #'(line-cap-style . square) \path #0.0999999821 #'((moveto 0.0000000000 0.0000000000) (lineto 0.2999999300 0.0000000000) (moveto 0.5999998601 0.0000000000) (lineto 0.8999997901 0.0000000000) (moveto 1.1999997201 0.0000000000) (lineto 1.4999996502 0.0000000000) (moveto 1.7999995802 0.0000000000) (lineto 2.0999995102 0.0000000000) (moveto 2.3999994403 0.0000000000) (lineto 2.6999993703 0.0000000000) (moveto 2.9999993003 0.0000000000) (lineto 3.2999992304 0.0000000000) (moveto 3.5999991604 0.0000000000) (lineto 3.8999990904 0.0000000000) (moveto 4.1999990205 0.0000000000) (lineto 4.4999989505 0.0000000000) (moveto 4.7999988805 0.0000000000) (lineto 5.0999988106 0.0000000000) (moveto 5.3999987406 0.0000000000) (lineto 5.6999986706 0.0000000000) (moveto 5.9999986006 0.0000000000) (lineto 6.2999985307 0.0000000000) (moveto 6.5999984607 0.0000000000) (lineto 6.8999983907 0.0000000000) (moveto 7.1999983208 0.0000000000) (lineto 7.4999982508 0.0000000000) (moveto 7.7999981808 0.0000000000) (lineto 8.0999981109 0.0000000000) (moveto 8.3999980409 0.0000000000) (lineto 8.6999979709 0.0000000000) (moveto 8.9999979010 0.0000000000) (lineto 9.2999978310 0.0000000000) (moveto 9.5999977610 0.0000000000) (lineto 9.8999976911 0.0000000000) (moveto 10.1999976211 0.0000000000) (lineto 10.4999975511 0.0000000000) (moveto 10.7999974812 0.0000000000) (lineto 11.0999974112 0.0000000000) (moveto 11.3999973412 0.0000000000) (lineto 11.6999972713 0.0000000000) (moveto 11.9999972013 0.0000000000) (lineto 12.2999971313 0.0000000000) (moveto 12.5999970614 0.0000000000) (lineto 12.8999969914 0.0000000000) (moveto 13.1999969214 0.0000000000) (lineto 13.4999968515 0.0000000000) (moveto 13.7999967815 0.0000000000) (lineto 14.0999967115 0.0000000000)) } "ottava_bracket" "op47-ottava_bracket-0014" % source p11 system 51, print m222; anchor m219
  \markAt #112.5652523375 #4.2563220749 \markup { \referenceInkBox #1.1386958912 #1.5781750730 { \musicglyph "eight" } } "ottava_text" "op47-ottava_text-0014" % source p11 system 51, print m222; anchor m219
  \markAt #31.0567851686 #-5.4999974297 \markup { \override #'(line-cap-style . square) \path #0.1299999718 #'((moveto 0.0000000000 0.0000000000) (lineto 23.5185175657 -0.5644446943) (moveto 0.0000000000 0.0000000000) (lineto 23.5185175657 0.5644446943)) } "wedge" "op47-wedge-0042" % source p11 system 51, print m219; anchor m219
  \markAt #112.5642584148 #-5.5822939266 \markup { \override #'(line-cap-style . square) \path #0.1299999718 #'((moveto 0.0000000000 0.0000000000) (lineto 6.0677737352 -0.5644446943) (moveto 0.0000000000 0.0000000000) (lineto 6.0677737352 0.5644446943)) } "wedge" "op47-wedge-0043" % source p11 system 51, print m222; anchor m219
  s1*3
  \markAt #-1.1282915527 #4.0000000026 \markup { \referenceText #2.2513930386 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "223" } } "bar_number" "op47-bar_number-0053" % source p11 system 52, print m223; anchor m223
  \markAt #11.0537381325 #5.0000000046 \markup { \override #'(line-cap-style . square) \path #0.1000000044 #'((moveto 0.0000000000 0.0000000000) (lineto 0.2999999971 0.0000000000) (moveto 0.5999999941 0.0000000000) (lineto 0.8999999912 0.0000000000) (moveto 1.1999999882 0.0000000000) (lineto 1.4999999853 0.0000000000) (moveto 1.7999999824 0.0000000000) (lineto 2.0999999794 0.0000000000) (moveto 2.3999999765 0.0000000000) (lineto 2.6999999735 0.0000000000) (moveto 2.9999999706 0.0000000000) (lineto 3.2999999677 0.0000000000) (moveto 3.5999999647 0.0000000000) (lineto 3.8999999618 0.0000000000) (moveto 4.1999999588 0.0000000000) (lineto 4.4999999559 0.0000000000) (moveto 4.7999999530 0.0000000000) (lineto 5.0999999500 0.0000000000) (moveto 5.3999999471 0.0000000000) (lineto 5.6999999441 0.0000000000) (moveto 5.9999999412 0.0000000000) (lineto 6.2999999383 0.0000000000) (moveto 6.5999999353 0.0000000000) (lineto 6.8999999324 0.0000000000) (moveto 7.1999999294 0.0000000000) (lineto 7.4999999265 0.0000000000) (moveto 7.7999999236 0.0000000000) (lineto 8.0999999206 0.0000000000) (moveto 8.3999999177 0.0000000000) (lineto 8.6999999147 0.0000000000) (moveto 8.8863369846 0.0000000000) (lineto 8.8863369846 -0.2999999971) (moveto 8.8863369846 -0.5999999941) (lineto 8.8863369846 -0.8999999912) (moveto 8.8863369846 -1.1999999882) (lineto 8.8863369846 -1.4999999853) (moveto 8.8863369846 -1.7999999824) (lineto 8.8863369846 -1.8999989273)) } "ottava_bracket" "op47-ottava_bracket-0015" % source p11 system 52, print m223; anchor m223
  \markAt #9.3787997659 #4.2148175197 \markup { \referenceInkBox #1.1386961456 #1.5781754256 { \musicglyph "eight" } } "ottava_text" "op47-ottava_text-0015" % source p11 system 52, print m223; anchor m223
  \markAt #30.5573896153 #-5.5000018114 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 0.0000000000) (lineto 12.7470367059 -0.5644430261) (moveto 0.0000000000 0.0000000000) (lineto 12.7470367059 0.5644430261)) } "wedge" "op47-wedge-0044" % source p11 system 52, print m223; anchor m223
  \markAt #49.3438906212 #-5.5000018114 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 -0.5644430261) (lineto 4.7037074350 0.0000000000) (moveto 0.0000000000 0.5644430261) (lineto 4.7037074350 0.0000000000)) } "wedge" "op47-wedge-0045" % source p11 system 52, print m224; anchor m223
  \markAt #105.2919882187 #-5.5000018114 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 0.0000000000) (lineto 23.1892542206 -0.5644430261) (moveto 0.0000000000 0.0000000000) (lineto 23.1892542206 0.5644430261)) } "wedge" "op47-wedge-0046" % source p11 system 52, print m225; anchor m223
  \markAt #12.3784383940 #-5.5794435625 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 -0.5644430261) (lineto 4.2333334617 0.0000000000) (moveto 0.0000000000 0.5644430261) (lineto 4.2333334617 0.0000000000)) } "wedge" "op47-wedge-0047" % source p11 system 52, print m223; anchor m223
  \markAt #68.5672907550 #-5.5808000689 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 0.0000000000) (lineto 14.0170388975 -0.5644430261) (moveto 0.0000000000 0.0000000000) (lineto 14.0170388975 0.5644430261)) } "wedge" "op47-wedge-0048" % source p11 system 52, print m224; anchor m223
  \markAt #111.1022816580 #6.0292797306 \markup { \referenceText #10.1769571605 { \override #'(font-name . "Nimbus Roman, Italic") \abs-fontsize #10.2382498085 "allargando" } } "words" "op47-words-0029" % source p11 system 52, print m225; anchor m223
  s1*9/4
  \markAt #-1.1518100720 #3.9999999982 \markup { \referenceText #2.3029312865 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "226" } } "bar_number" "op47-bar_number-0052" % source p11 system 53, print m226; anchor m226
  \markAt #51.3934570362 #-6.5200747172 \markup { \referenceInkBox #1.8043647843 #1.6117535211 { \dynamic "p" } } "dynamics" "op47-dynamics-0029" % source p11 system 53, print m227; anchor m226
  \markAt #45.7278168255 #-6.5634139388 \markup { \referenceInkBox #3.9615188812 #2.4293435626 { \dynamic "sffz" } } "dynamics" "op47-dynamics-0030" % source p11 system 53, print m227; anchor m226
  \markAt #9.3778121699 #-5.5000018158 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 -0.2351851923) (lineto 19.3322238850 -0.5644430261) (moveto 0.0000000000 0.2351851923) (lineto 19.3322238850 0.5644430261)) } "wedge" "op47-wedge-0049" % source p11 system 53, print m226; anchor m226
  \markAt #99.8293441683 #-5.6308221436 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 0.0000000000) (lineto 28.6925934627 -0.5644430261) (moveto 0.0000000000 0.0000000000) (lineto 28.6925934627 0.5644430261)) } "wedge" "op47-wedge-0050" % source p11 system 53, print m229; anchor m226
  \markAt #51.6411721900 #5.2970354243 \markup { \referenceText #5.5073238874 { \override #'(font-name . "Nimbus Roman, Italic") \abs-fontsize #10.2382498085 "stretto" } } "words" "op47-words-0027" % source p11 system 53, print m227; anchor m226
  s1*3
  \markAt #-1.1753288264 #3.9999928372 \markup { \referenceText #2.3005890772 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "230" } } "bar_number" "op47-bar_number-0051" % source p11 system 54, print m230; anchor m230
  \markAt #49.4317032638 #-6.1270992402 \markup { \referenceInkBox #3.0793171175 #2.4293435626 { \dynamic "ff" } } "dynamics" "op47-dynamics-0028" % source p11 system 54, print m231; anchor m230
  \markAt #9.3778121699 #-5.0636876202 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 -0.2351851923) (lineto 39.5111141036 -0.5644430261) (moveto 0.0000000000 0.2351851923) (lineto 39.5111141036 0.5644430261)) } "wedge" "op47-wedge-0051" % source p11 system 54, print m230; anchor m230
  \markAt #50.5067187853 #6.5967192841 \markup { \referenceText #9.6784266416 { \override #'(font-name . "Nimbus Roman, Italic") \abs-fontsize #10.2382498085 "Più mosso." } } "words" "op47-words-0026" % source p11 system 54, print m231; anchor m230
  \markAt #22.2767360070 #5.5592718107 \markup { \referenceText #7.4903257012 { \override #'(font-name . "Nimbus Roman, Italic") \abs-fontsize #10.2382498085 "poco rit." } } "words" "op47-words-0028" % source p11 system 54, print m230; anchor m230
  s1*9/4
  \markAt #-1.1282915527 #3.9999928287 \markup { \referenceText #2.2513930386 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "233" } } "bar_number" "op47-bar_number-0050" % source p11 system 55, print m233; anchor m233
  \markAt #88.5517183556 #4.9925307829 \markup { \referenceInkBox #2.3984376412 #2.2031252761 { \musicglyph "scripts.trill" } } "reference-trill" "op47-reference-trill-0012" % source p11 system 55, print m235; anchor m233
  s1*3
  \markAt #-1.1518098146 #4.0000004674 \markup { \referenceText #2.2685718693 { \override #'(font-name . "Nimbus Roman,") \abs-fontsize #6.8255001915 "237" } } "bar_number" "op47-bar_number-0055" % source p12 system 56, print m237; anchor m237
  \markAt #18.3769701348 #7.5415041136 \markup { \override #'(line-cap-style . square) \path #0.0999999821 #'((moveto 0.0000000000 0.0000000000) (lineto 0.2999999300 0.0000000000) (moveto 0.5999998601 0.0000000000) (lineto 0.8999997901 0.0000000000) (moveto 1.1999997201 0.0000000000) (lineto 1.4999996502 0.0000000000) (moveto 1.7999995802 0.0000000000) (lineto 2.0999995102 0.0000000000) (moveto 2.3999994403 0.0000000000) (lineto 2.6999993703 0.0000000000) (moveto 2.9999993003 0.0000000000) (lineto 3.2999992304 0.0000000000) (moveto 3.5999991604 0.0000000000) (lineto 3.8999990904 0.0000000000) (moveto 4.1999990205 0.0000000000) (lineto 4.4999989505 0.0000000000) (moveto 4.7999988805 0.0000000000) (lineto 5.0999988106 0.0000000000) (moveto 5.3999987406 0.0000000000) (lineto 5.6999986706 0.0000000000) (moveto 5.9999986006 0.0000000000) (lineto 6.2999985307 0.0000000000) (moveto 6.5999984607 0.0000000000) (lineto 6.8999983907 0.0000000000) (moveto 7.1999983208 0.0000000000) (lineto 7.4999982508 0.0000000000) (moveto 7.7999981808 0.0000000000) (lineto 8.0999981109 0.0000000000) (moveto 8.3999980409 0.0000000000) (lineto 8.6999979709 0.0000000000) (moveto 8.9999979010 0.0000000000) (lineto 9.2999978310 0.0000000000) (moveto 9.4000201688 0.0000000000) (lineto 9.4000201688 -0.2999999300) (moveto 9.4000201688 -0.5999998601) (lineto 9.4000201688 -0.8999997901) (moveto 9.4000201688 -1.1999997201) (lineto 9.4000201688 -1.4999996502) (moveto 9.4000201688 -1.7999995802) (lineto 9.4000201688 -1.8999994000)) } "ottava_bracket" "op47-ottava_bracket-0016" % source p12 system 56, print m237; anchor m237
  \markAt #16.7020325341 #6.7563212959 \markup { \referenceInkBox #1.1386958912 #1.5781750730 { \musicglyph "eight" } } "ottava_text" "op47-ottava_text-0016" % source p12 system 56, print m237; anchor m237
}
referenceMarksLower = {
  \markAt #58.3670900422 #4.9999990416 \markup { \referenceInkBox #2.0078124405 #1.0000001470 { \musicglyph "scripts.prall" } } "ornament" "op47-ornament-0001" % source p1 system 1, print m3; anchor m1
  s1*9/2
  \markAt #63.3966831514 #5.4999946262 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 -0.5644430261) (lineto 10.6303735636 0.0000000000) (moveto 0.0000000000 0.5644430261) (lineto 10.6303735636 0.0000000000)) } "wedge" "op47-wedge-0003" % source p1 system 2, print m9; anchor m7
  s1*15/4
  \markAt #90.0885660590 #5.9205546837 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 -0.5644430261) (lineto 8.2314817311 0.0000000000) (moveto 0.0000000000 0.5644430261) (lineto 8.2314817311 0.0000000000)) } "wedge" "op47-wedge-0005" % source p1 system 3, print m15; anchor m12
  s1*15/4
  \markAt #103.2087330612 #4.4365819866 \markup { \referenceInkBox #2.0217198817 #2.4293435626 { \dynamic "f" } } "dynamics" "op47-dynamics-0001" % source p1 system 4, print m21; anchor m17
  \markAt #95.5819432330 #6.1105588766 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 0.0000000000) (lineto 5.2211141403 -0.5644502034) (moveto 0.0000000000 0.0000000000) (lineto 5.2211141403 0.5644502034)) } "wedge" "op47-wedge-0006" % source p1 system 4, print m20; anchor m17
  \markAt #77.9209233888 #4.5418489540 \markup { \referenceText #3.1978043581 { \override #'(font-name . "Nimbus Roman, Italic") \abs-fontsize #8.6322503829 "dim." } } "words" "op47-words-0003" % source p1 system 4, print m20; anchor m17
  \markAt #32.2329899737 #5.2633237435 \markup { \referenceText #8.4865567703 { \override #'(font-name . "Nimbus Roman, Italic") \abs-fontsize #8.6322503829 "poco cresc." } } "words" "op47-words-0005" % source p1 system 4, print m18; anchor m17
  s1*15/4
  \markAt #80.5381133626 #5.3050961603 \markup { \referenceInkBox #3.1528425938 #2.4293435626 { \dynamic "mf" } } "dynamics" "op47-dynamics-0003" % source p1 system 5, print m24; anchor m22
  \markAt #62.4438303824 #4.5418489437 \markup { \referenceText #3.1978043581 { \override #'(font-name . "Nimbus Roman, Italic") \abs-fontsize #8.6322503829 "dim." } } "words" "op47-words-0004" % source p1 system 5, print m24; anchor m22
  s1*15/4
  \markAt #79.0641210312 #6.0118784193 \markup { \referenceText #4.6912324256 { \override #'(font-name . "Nimbus Roman, Italic") \abs-fontsize #8.6322503829 "dimin." } } "words" "op47-words-0008" % source p2 system 6, print m30; anchor m27
  \markAt #11.2601621583 #5.5118781948 \markup { \referenceText #4.0999859953 { \override #'(font-name . "Nimbus Roman, Italic") \abs-fontsize #8.6322503829 "cresc." } } "words" "op47-words-0009" % source p2 system 6, print m27; anchor m27
  s1*27/4
  \markAt #77.4838526404 #4.9999948318 \markup { \referenceInkBox #2.0078124405 #0.9999999118 { \musicglyph "scripts.prall" } } "ornament" "op47-ornament-0002" % source p2 system 8, print m39; anchor m36
  s1*9/2
  \markAt #120.7396125095 #4.4799332733 \markup { \referenceInkBox #3.2169387901 #1.6117535211 { \dynamic "pp" } } "dynamics" "op47-dynamics-0010" % source p2 system 9, print m47; anchor m42
  \markAt #38.3607937818 #5.1063063189 \markup { \referenceText #4.0999865151 { \override #'(font-name . "Nimbus Roman, Italic") \abs-fontsize #8.6322503829 "cresc." } } "words" "op47-words-0007" % source p2 system 9, print m43; anchor m42
  s1*9/2
  \markAt #66.7647912598 #5.0592592361 \markup { \referenceText #8.8594102020 { \override #'(font-name . "Nimbus Roman, Italic") \abs-fontsize #8.6322503829 "mezza voce" } } "words" "op47-words-0006" % source p2 system 10, print m52; anchor m48
  s1*39/4
  \markAt #105.8338883307 #4.4365858977 \markup { \referenceInkBox #3.1528397575 #2.4293413772 { \dynamic "mf" } } "dynamics" "op47-dynamics-0014" % source p3 system 12, print m65; anchor m61
  \markAt #70.5357579713 #6.5649987459 \markup { \referenceText #4.0999851786 { \override #'(font-name . "Nimbus Roman, Italic") \abs-fontsize #8.6322503829 "cresc." } } "words" "op47-words-0012" % source p3 system 12, print m63; anchor m61
  s1*45/4
  \markAt #47.8005770680 #5.5118873797 \markup { \referenceText #7.6095330789 { \override #'(font-name . "Nimbus Roman, Italic") \abs-fontsize #8.6322503829 "crescendo" } } "words" "op47-words-0011" % source p3 system 15, print m77; anchor m76
  s1*15/2
  \markAt #66.2889504676 #4.4365879132 \markup { \referenceInkBox #2.3286549021 #2.4293435626 { \dynamic "sf" } } "dynamics" "op47-dynamics-0015" % source p4 system 17, print m88; anchor m86
  \markAt #70.6030264486 #7.3020344172 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 -0.5644430261) (lineto 9.0311099495 0.0000000000) (moveto 0.0000000000 0.5644430261) (lineto 9.0311099495 0.0000000000)) } "wedge" "op47-wedge-0013" % source p4 system 17, print m88; anchor m86
  \markAt #113.1331262648 #6.0520389004 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 -0.5644430261) (lineto 14.2051913578 0.0000000000) (moveto 0.0000000000 0.5644430261) (lineto 14.2051913578 0.0000000000)) } "wedge" "op47-wedge-0014" % source p4 system 17, print m90; anchor m86
  s1*75/4
  \markAt #93.2001535664 #4.5418538462 \markup { \referenceText #3.1978014814 { \override #'(font-name . "Nimbus Roman, Italic") \abs-fontsize #8.6322503829 "dim." } } "words" "op47-words-0017" % source p5 system 22, print m114; anchor m111
  s1*15
  \markAt #48.9015511133 #6.1442813404 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 -0.5644430261) (lineto 57.1970344651 0.0000000000) (moveto 0.0000000000 0.5644430261) (lineto 57.1970344651 0.0000000000)) } "wedge" "op47-wedge-0025" % source p6 system 27, print m132; anchor m131
  \markAt #108.8414473450 #5.5418740786 \markup { \referenceText #4.0999912188 { \override #'(font-name . "Nimbus Roman, Italic") \abs-fontsize #8.6322503829 "cresc." } } "words" "op47-words-0018" % source p6 system 27, print m134; anchor m131
  s1*3
  \markAt #111.6534361768 #5.4999946309 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 -0.5644430261) (lineto 15.7103751531 0.0000000000) (moveto 0.0000000000 0.5644430261) (lineto 15.7103751531 0.0000000000)) } "wedge" "op47-wedge-0029" % source p6 system 28, print m138; anchor m135
  s1*3
  \markAt #15.4943784270 #6.1055563039 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 0.0000000000) (lineto 33.1140740016 -0.5644430261) (moveto 0.0000000000 0.0000000000) (lineto 33.1140740016 0.5644430261)) } "wedge" "op47-wedge-0032" % source p6 system 29, print m139; anchor m139
  s1*3
  \markAt #15.2298237948 #5.5000017994 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 -0.5644502034) (lineto 26.5759285261 0.0000000000) (moveto 0.0000000000 0.5644502034) (lineto 26.5759285261 0.0000000000)) } "wedge" "op47-wedge-0033" % source p6 system 30, print m143; anchor m143
  s1*15/2
  \markAt #101.1432567393 #-6.9711078593 \markup { \referenceText #4.5809035445 { \override #'(font-name . "Nimbus Roman, Italic") \abs-fontsize #8.6322503829 "legato" } } "words" "op47-words-0022" % source p7 system 32, print m157; anchor m153
  \markAt #103.8363228654 #5.0592628364 \markup { \referenceText #8.8594078501 { \override #'(font-name . "Nimbus Roman, Italic") \abs-fontsize #8.6322503829 "mezza voce" } } "words" "op47-words-0023" % source p7 system 32, print m157; anchor m153
  s1*9
  \markAt #20.3002690489 #5.1063135178 \markup { \referenceText #4.0999841632 { \override #'(font-name . "Nimbus Roman, Italic") \abs-fontsize #8.6322503829 "cresc." } } "words" "op47-words-0021" % source p7 system 35, print m165; anchor m165
  s1*3
  \markAt #70.5575861813 #4.5888918156 \markup { \referenceText #8.9966875856 { \override #'(font-name . "Nimbus Roman, Italic") \abs-fontsize #8.6322503829 "molto cresc." } } "words" "op47-words-0024" % source p8 system 36, print m171; anchor m169
  s1*3
  \markAt #9.9370868417 #5.3051084389 \markup { \referenceInkBox #3.0793166992 #2.4293413772 { \dynamic "ff" } } "dynamics" "op47-dynamics-0024" % source p8 system 37, print m173; anchor m173
  s1*21/4
  \markAt #92.7097455073 #5.5000018012 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 0.0000000000) (lineto 34.6192560027 -0.5644430261) (moveto 0.0000000000 0.0000000000) (lineto 34.6192560027 0.5644430261)) } "wedge" "op47-wedge-0034" % source p8 system 39, print m182; anchor m180
  s1*9/4
  \markAt #17.7037318628 #4.4365995549 \markup { \referenceInkBox #2.5969821565 #2.4293435626 { \dynamic "fz" } } "dynamics" "op47-dynamics-0019" % source p8 system 40, print m183; anchor m183
  \markAt #10.5747162336 #4.4365995549 \markup { \referenceInkBox #3.9615146479 #2.4293435626 { \dynamic "sffz" } } "dynamics" "op47-dynamics-0020" % source p8 system 40, print m183; anchor m183
  \markAt #36.9328045651 #5.5000018089 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 -0.5644502034) (lineto 39.4170360791 0.0000000000) (moveto 0.0000000000 0.5644502034) (lineto 39.4170360791 0.0000000000)) } "wedge" "op47-wedge-0035" % source p8 system 40, print m184; anchor m183
  s1*33/4
  \markAt #52.1056796430 #4.5418489473 \markup { \referenceText #4.6912326811 { \override #'(font-name . "Nimbus Roman, Italic") \abs-fontsize #8.6322503829 "dimin." } } "words" "op47-words-0025" % source p9 system 43, print m195; anchor m194
  s1*21/4
  \markAt #95.4092291074 #5.5000018144 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 0.0000000000) (lineto 33.1140722073 -0.5644502034) (moveto 0.0000000000 0.0000000000) (lineto 33.1140722073 0.5644502034)) } "wedge" "op47-wedge-0036" % source p9 system 45, print m203; anchor m201
  s1*9/4
  \markAt #9.3778163604 #5.5000033756 \markup { \override #'(line-cap-style . square) \path #0.1300000589 #'((moveto 0.0000000000 -0.2351852974) (lineto 17.5448228279 -0.5644450726) (moveto 0.0000000000 0.2351852974) (lineto 17.5448228279 0.5644450726)) } "wedge" "op47-wedge-0037" % source p10 system 46, print m204; anchor m204
  s1*27/4
  \markAt #10.1827965736 #4.4365826451 \markup { \referenceInkBox #3.0793194693 #2.4293435626 { \dynamic "ff" } } "dynamics" "op47-dynamics-0027" % source p10 system 49, print m213; anchor m213
  s1*9/4
  \markAt #44.8689788291 #4.4365865492 \markup { \referenceInkBox #2.0217198817 #2.4293435626 { \dynamic "f" } } "dynamics" "op47-dynamics-0026" % source p10 system 50, print m216; anchor m216
  \markAt #96.9136234017 #-5.4999874542 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 0.0000000000) (lineto 11.5711143329 -0.5644502034) (moveto 0.0000000000 0.0000000000) (lineto 11.5711143329 0.5644502034)) } "wedge" "op47-wedge-0040" % source p10 system 50, print m218; anchor m216
  \markAt #51.1197799799 #-5.8405495078 \markup { \override #'(line-cap-style . square) \path #0.1300000008 #'((moveto 0.0000000000 -0.5644502034) (lineto 30.4329660390 0.0000000000) (moveto 0.0000000000 0.5644502034) (lineto 30.4329660390 0.0000000000)) } "wedge" "op47-wedge-0041" % source p10 system 50, print m217; anchor m216
  s1*15/2
  \markAt #72.8919066807 #5.1062991624 \markup { \referenceText #4.0999912188 { \override #'(font-name . "Nimbus Roman, Italic") \abs-fontsize #8.6322503829 "cresc." } } "words" "op47-words-0030" % source p11 system 53, print m228; anchor m226
  s1*3
  \markAt #117.4866278256 #-10.5074703196 \markup { \referenceInkBox #2.3984376412 #2.2031252761 { \musicglyph "scripts.trill" } } "reference-trill" "op47-reference-trill-0011" % source p11 system 54, print m232; anchor m230
}

% Original PDF Tie contours, expressed as native vector stencils.
% Music, Tie grobs, and endpoint associations remain native LilyPond.
#(define op47-source-curve-contours
  '(
    (("op47-tie-0001" . 0) 0.070000001 (moveto 41.636145714 1.894969439 curveto 43.101301796 3.088486913 47.496766455 3.088486913 48.961922537 1.894969439 curveto 47.496766455 2.928487344 43.101301796 2.928487344 41.636145714 1.894969439 closepath))
    (("op47-tie-0002" . 0) 0.070000001 (moveto 50.309012323 1.916625094 curveto 54.356737648 3.296624515 66.499895677 3.296624515 70.547624590 1.916625094 curveto 66.499895677 3.136624946 54.356737648 3.136624946 50.309012323 1.916625094 closepath))
    (("op47-tie-0003" . 0) 0.070000001 (moveto 89.585495449 -1.583374892 curveto 93.982399152 -0.203375472 107.173110263 -0.203375472 111.570006789 -1.583374892 curveto 107.173110263 -0.363375041 93.982399152 -0.363375041 89.585495449 -1.583374892 closepath))
    (("op47-tie-0004" . 0) 0.070000001 (moveto 122.707060544 -4.394969423 curveto 123.870555446 -5.199214423 127.360997086 -5.199214423 128.524477633 -4.394969423 curveto 127.360997086 -5.359213992 123.870555446 -5.359213992 122.707060544 -4.394969423 closepath))
    (("op47-tie-0005" . 0) 0.070000001 (moveto 122.707060544 -3.394969426 curveto 123.870555446 -4.199216221 127.360997086 -4.199216221 128.524477633 -3.394969426 curveto 127.360997086 -4.359215790 123.870555446 -4.359215790 122.707060544 -3.394969426 closepath))
    (("op47-tie-0006" . 0) 0.070000001 (moveto 122.707060544 -1.605030548 curveto 123.870555446 -0.640784184 127.360997086 -0.640784184 128.524477633 -1.605030548 curveto 127.360997086 -0.800785547 123.870555446 -0.800785547 122.707060544 -1.605030548 closepath))
    (("op47-tie-0007" . 0) 0.070000001 (moveto 122.707060544 0.105032355 curveto 123.870555446 -0.699214440 127.360997086 -0.699214440 128.524477633 0.105032355 curveto 127.360997086 -0.859214009 123.870555446 -0.859214009 122.707060544 0.105032355 closepath))
    (("op47-tie-0004" . 9/2) 0.070000001 (moveto 9.377812115 -4.394965847 curveto 9.722215807 -4.714972162 10.755423295 -4.714972162 11.099825192 -4.394965847 curveto 10.755423295 -4.874968142 9.722215807 -4.874968142 9.377812115 -4.394965847 closepath))
    (("op47-tie-0005" . 9/2) 0.070000001 (moveto 9.377812115 -3.394969440 curveto 9.722215807 -3.714968577 10.755423295 -3.714968577 11.099825192 -3.394969440 curveto 10.755423295 -3.874971734 9.722215807 -3.874971734 9.377812115 -3.394969440 closepath))
    (("op47-tie-0006" . 9/2) 0.070000001 (moveto 9.377812115 -1.605030561 curveto 9.722215807 -1.125031855 10.755423295 -1.125031855 11.099825192 -1.605030561 curveto 10.755423295 -1.285031423 9.722215807 -1.285031423 9.377812115 -1.605030561 closepath))
    (("op47-tie-0007" . 9/2) 0.070000001 (moveto 9.377812115 -0.140000073 curveto 9.722215807 -0.459999211 10.755423295 -0.459999211 11.099825192 -0.140000073 curveto 10.755423295 -0.620002368 9.722215807 -0.620002368 9.377812115 -0.140000073 closepath))
    (("op47-tie-0008" . 9/2) 0.070000001 (moveto 12.732362678 0.105032349 curveto 14.791481946 -1.114969297 20.968837955 -1.114969297 23.027957223 0.105032349 curveto 20.968837955 -1.274972455 14.791481946 -1.274972455 12.732362678 0.105032349 closepath))
    (("op47-tie-0009" . 33/4) 0.070000001 (moveto 106.963591034 -2.394965841 curveto 107.531328429 -2.746458894 109.234576502 -2.746458894 109.802328252 -2.394965841 curveto 109.234576502 -2.906454874 107.531328429 -2.906454874 106.963591034 -2.394965841 closepath))
    (("op47-tie-0010" . 33/4) 0.070000001 (moveto 106.963591034 2.116386808 curveto 107.531328429 2.627868664 109.234576502 2.627868664 109.802328252 2.116386808 curveto 109.234576502 2.467872683 107.531328429 2.467872683 106.963591034 2.116386808 closepath))
    (("op47-tie-0011" . 33/4) 0.070000001 (moveto 127.104954713 -2.394965841 curveto 127.388859297 -2.714972156 128.240573049 -2.714972156 128.524477633 -2.394965841 curveto 128.240573049 -2.874968136 127.388859297 -2.874968136 127.104954713 -2.394965841 closepath))
    (("op47-tie-0012" . 33/4) 0.070000001 (moveto 127.104954713 2.140000067 curveto 127.388859297 2.620002362 128.240573049 2.620002362 128.524477633 2.140000067 curveto 128.240573049 2.459999205 127.388859297 2.459999205 127.104954713 2.140000067 closepath))
    (("op47-tie-0011" . 12) 0.070000001 (moveto 9.377812115 -2.394965848 curveto 9.722215807 -2.714972162 10.755423295 -2.714972162 11.099825192 -2.394965848 curveto 10.755423295 -2.874968143 9.722215807 -2.874968143 9.377812115 -2.394965848 closepath))
    (("op47-tie-0012" . 12) 0.070000001 (moveto 9.377812115 2.140000061 curveto 9.722215807 2.620002356 10.755423295 2.620002356 11.099825192 2.140000061 curveto 10.755423295 2.459999198 9.722215807 2.459999198 9.377812115 2.140000061 closepath))
    (("op47-tie-0013" . 12) 0.070000001 (moveto 19.535193732 -2.140000066 curveto 19.813381610 -2.460006381 20.647947041 -2.460006381 20.926134919 -2.140000066 curveto 20.647947041 -2.620002361 19.813381610 -2.620002361 19.535193732 -2.140000066 closepath))
    (("op47-tie-0014" . 12) 0.070000001 (moveto 19.535193732 2.394965842 curveto 19.813381610 2.874968137 20.647947041 2.874968137 20.926134919 2.394965842 curveto 20.647947041 2.714972157 19.813381610 2.714972157 19.535193732 2.394965842 closepath))
    (("op47-tie-0015" . 12) 0.070000001 (moveto 66.788903309 0.394965850 curveto 69.047493611 1.774970653 75.823271692 1.774970653 78.081861993 0.394965850 curveto 75.823271692 1.614967496 69.047493611 1.614967496 66.788903309 0.394965850 closepath))
    (("op47-tie-0016" . 12) 0.070000001 (moveto 115.335187625 1.500001786 curveto 115.763226395 1.180002648 117.047371414 1.180002648 117.475410184 1.500001786 curveto 117.047371414 1.019999491 115.763226395 1.019999491 115.335187625 1.500001786 closepath))
    (("op47-tie-0017" . 12) 0.070000001 (moveto 115.335187625 3.394969427 curveto 115.763226395 3.874971722 117.047371414 3.874971722 117.475410184 3.394969427 curveto 117.047371414 3.714968565 115.763226395 3.714968565 115.335187625 3.394969427 closepath))
    (("op47-tie-0018" . 12) 0.070000001 (moveto 115.335187625 5.394969419 curveto 115.763226395 5.874971714 117.047371414 5.874971714 117.475410184 5.394969419 curveto 117.047371414 5.714968557 115.763226395 5.714968557 115.335187625 5.394969419 closepath))
    (("op47-tie-0019" . 63/4) 0.070000001 (moveto 21.485731482 0.605037743 curveto 21.854586381 0.285031428 22.961147490 0.285031428 23.329998800 0.605037743 curveto 22.961147490 0.125035448 21.854586381 0.125035448 21.485731482 0.605037743 closepath))
    (("op47-tie-0020" . 63/4) 0.070000001 (moveto 21.485731482 3.394962263 curveto 21.854586381 3.874964558 22.961147490 3.874964558 23.329998800 3.394962263 curveto 22.961147490 3.714968578 21.854586381 3.714968578 21.485731482 3.394962263 closepath))
    (("op47-tie-0021" . 63/4) 0.070000001 (moveto 21.485731482 4.894971229 curveto 21.854586381 5.374973524 22.961147490 5.374973524 23.329998800 4.894971229 curveto 22.961147490 5.214963189 21.854586381 5.214963189 21.485731482 4.894971229 closepath))
    (("op47-tie-0022" . 63/4) 0.070000001 (moveto 31.086218783 3.276479685 curveto 31.470748867 3.756481979 32.624342707 3.756481979 33.008876380 3.276479685 curveto 32.624342707 3.596471645 31.470748867 3.596471645 31.086218783 3.276479685 closepath))
    (("op47-tie-0023" . 63/4) 0.070000001 (moveto 51.593311654 3.894974821 curveto 53.795596175 5.274965270 60.402478446 5.274965270 62.604770144 3.894974821 curveto 60.402478446 5.114969290 53.795596175 5.114969290 51.593311654 3.894974821 closepath))
    (("op47-tie-0024" . 93/4) 0.069999938 (moveto 52.477764333 -0.894965049 curveto 55.335080982 -2.114965605 63.907052460 -2.114965605 66.764376286 -0.894965049 curveto 63.907052460 -2.274961442 55.335080982 -2.274961442 52.477764333 -0.894965049 closepath))
    (("op47-tie-0025" . 93/4) 0.069999938 (moveto 52.477764333 1.894967744 curveto 55.335080982 3.274967726 63.907052460 3.274967726 66.764376286 1.894967744 curveto 63.907052460 3.114968300 55.335080982 3.114968300 52.477764333 1.894967744 closepath))
    (("op47-tie-0026" . 93/4) 0.069999938 (moveto 52.477764333 4.394967295 curveto 55.335080982 5.774963687 63.907052460 5.774963687 66.764376286 4.394967295 curveto 63.907052460 5.614964262 55.335080982 5.614964262 52.477764333 4.394967295 closepath))
    (("op47-tie-0027" . 105/4) 0.070000001 (moveto 61.027906837 1.894967652 curveto 62.467676872 3.069192591 66.786979798 3.069192591 68.226749832 1.894967652 curveto 66.786979798 2.909189433 62.467676872 2.909189433 61.027906837 1.894967652 closepath))
    (("op47-tie-0028" . 105/4) 0.070000001 (moveto 69.573832441 1.916621513 curveto 73.562334419 3.296626317 85.527826000 3.296626317 89.516320801 1.916621513 curveto 85.527826000 3.136623159 73.562334419 3.136623159 69.573832441 1.916621513 closepath))
    (("op47-tie-0029" . 105/4) 0.070000001 (moveto 108.258085695 -1.583373091 curveto 112.311369824 -0.203375464 124.471207858 -0.203375464 128.524477633 -1.583373091 curveto 124.471207858 -0.363371444 112.311369824 -0.363371444 108.258085695 -1.583373091 closepath))
    (("op47-tie-0029" . 123/4) 0.070000001 (moveto 9.377812115 -1.583373099 curveto 9.793310378 -1.103377981 11.039799785 -1.103377981 11.455296254 -1.583373099 curveto 11.039799785 -1.263373962 9.793310378 -1.263373962 9.377812115 -1.583373099 closepath))
    (("op47-tie-0030" . 123/4) 0.070000001 (moveto 16.739862923 -1.605034138 curveto 18.188294143 -2.553145970 21.990491813 -2.553145970 23.076863226 -1.605034138 curveto 21.990491813 -2.713149128 18.188294143 -2.713149128 16.739862923 -1.605034138 closepath))
    (("op47-tie-0031" . 123/4) 0.070000001 (moveto 17.926425611 -0.949446805 curveto 18.609670601 -0.350186785 20.659403778 -0.350186785 21.342646974 -0.949446805 curveto 20.659403778 -0.510182765 18.609670601 -0.510182765 17.926425611 -0.949446805 closepath))
    (("op47-tie-0032" . 123/4) 0.070000001 (moveto 22.619713398 -1.105028756 curveto 25.037456349 0.274968870 32.290688790 0.274968870 34.708431741 -1.105028756 curveto 32.290688790 0.114965712 25.037456349 0.114965712 22.619713398 -1.105028756 closepath))
    (("op47-tie-0033" . 123/4) 0.070000001 (moveto 39.832997047 -0.605030553 curveto 41.038091477 -1.738079422 44.110284161 -1.738079422 44.953320579 -0.605030553 curveto 44.110284161 -1.898082579 41.038091477 -1.898082579 39.832997047 -0.605030553 closepath))
    (("op47-tie-0034" . 123/4) 0.070000001 (moveto 44.496170752 -0.105032349 curveto 46.594578464 1.274965277 52.889801599 1.274965277 54.988216488 -0.105032349 curveto 52.889801599 1.114969297 46.594578464 1.114969297 44.496170752 -0.105032349 closepath))
    (("op47-tie-0035" . 123/4) 0.070000001 (moveto 59.892776556 -0.105032349 curveto 61.196939016 -1.343824120 64.566321434 -1.343824120 65.508418704 -0.105032349 curveto 64.566321434 -1.503827278 61.196939016 -1.503827278 59.892776556 -0.105032349 closepath))
    (("op47-tie-0036" . 123/4) 0.070000001 (moveto 78.358000758 0.083378479 curveto 81.994177118 -1.136630344 92.902691846 -1.136630344 96.538861029 0.083378479 curveto 92.902691846 -1.296626324 81.994177118 -1.296626324 78.358000758 0.083378479 closepath))
    (("op47-tie-0037" . 123/4) 0.070000001 (moveto 123.214465703 -6.894964044 curveto 124.276473831 -7.622094528 127.462483860 -7.622094528 128.524477633 -6.894964044 curveto 127.462483860 -7.782090508 124.276473831 -7.782090508 123.214465703 -6.894964044 closepath))
    (("op47-tie-0038" . 123/4) 0.070000001 (moveto 123.214465703 -2.605030558 curveto 124.276473831 -1.717904094 127.462483860 -1.717904094 128.524477633 -2.605030558 curveto 127.462483860 -1.877914429 124.276473831 -1.877914429 123.214465703 -2.605030558 closepath))
    (("op47-tie-0037" . 141/4) 0.070000001 (moveto 9.377812115 -6.894964041 curveto 9.722215807 -7.214970355 10.755423295 -7.214970355 11.099825192 -6.894964041 curveto 10.755423295 -7.374966335 9.722215807 -7.374966335 9.377812115 -6.894964041 closepath))
    (("op47-tie-0038" . 141/4) 0.070000001 (moveto 9.377812115 -2.605030554 curveto 9.722215807 -2.125028260 10.755423295 -2.125028260 11.099825192 -2.605030554 curveto 10.755423295 -2.285038594 9.722215807 -2.285038594 9.377812115 -2.605030554 closepath))
    (("op47-tie-0039" . 141/4) 0.070000001 (moveto 47.746101658 2.583369510 curveto 48.958039627 1.742292490 52.593867890 1.742292490 53.805809448 2.583369510 curveto 52.593867890 1.582296510 48.958039627 1.582296510 47.746101658 2.583369510 closepath))
    (("op47-tie-0040" . 141/4) 0.070000001 (moveto 47.746101658 6.916625073 curveto 48.958039627 7.917698072 52.593867890 7.917698072 53.805809448 6.916625073 curveto 52.593867890 7.757702092 48.958039627 7.757702092 47.746101658 6.916625073 closepath))
    (("op47-tie-0041" . 141/4) 0.070000001 (moveto 47.746101658 -3.416623298 curveto 48.958039627 -4.257700318 52.593867890 -4.257700318 53.805809448 -3.416623298 curveto 52.593867890 -4.417696298 48.958039627 -4.417696298 47.746101658 -3.416623298 closepath))
    (("op47-tie-0042" . 141/4) 0.070000001 (moveto 47.746101658 -2.416626890 curveto 48.958039627 -3.257703910 52.593867890 -3.257703910 53.805809448 -2.416626890 curveto 52.593867890 -3.417699890 48.958039627 -3.417699890 47.746101658 -2.416626890 closepath))
    (("op47-tie-0043" . 141/4) 0.070000001 (moveto 47.746101658 -0.916617925 curveto 48.958039627 -1.757694944 52.593867890 -1.757694944 53.805809448 -0.916617925 curveto 52.593867890 -1.917705279 48.958039627 -1.917705279 47.746101658 -0.916617925 closepath))
    (("op47-tie-0044" . 141/4) 0.070000001 (moveto 47.746101658 0.916617910 curveto 48.958039627 1.917705265 52.593867890 1.917705265 53.805809448 0.916617910 curveto 52.593867890 1.757694930 48.958039627 1.757694930 47.746101658 0.916617910 closepath))
    (("op47-tie-0045" . 141/4) 0.070000001 (moveto 55.527862000 2.583369510 curveto 56.741533283 1.740986224 60.382554310 1.740986224 61.596232770 2.583369510 curveto 60.382554310 1.580975890 56.741533283 1.580975890 55.527862000 2.583369510 closepath))
    (("op47-tie-0046" . 141/4) 0.070000001 (moveto 55.527862000 6.916625073 curveto 56.741533283 7.919018692 60.382554310 7.919018692 61.596232770 6.916625073 curveto 60.382554310 7.759022712 56.741533283 7.759022712 55.527862000 6.916625073 closepath))
    (("op47-tie-0047" . 141/4) 0.070000001 (moveto 55.527862000 -3.416623298 curveto 56.741533283 -4.259020938 60.382554310 -4.259020938 61.596232770 -3.416623298 curveto 60.382554310 -4.419016918 56.741533283 -4.419016918 55.527862000 -3.416623298 closepath))
    (("op47-tie-0048" . 141/4) 0.070000001 (moveto 55.527862000 -2.416626890 curveto 56.741533283 -3.259024530 60.382554310 -3.259024530 61.596232770 -2.416626890 curveto 60.382554310 -3.419020510 56.741533283 -3.419020510 55.527862000 -2.416626890 closepath))
    (("op47-tie-0049" . 141/4) 0.070000001 (moveto 55.527862000 -0.916617925 curveto 56.741533283 -1.759015564 60.382554310 -1.759015564 61.596232770 -0.916617925 curveto 60.382554310 -1.919011544 56.741533283 -1.919011544 55.527862000 -0.916617925 closepath))
    (("op47-tie-0050" . 141/4) 0.070000001 (moveto 55.527862000 0.916617910 curveto 56.741533283 1.919011530 60.382554310 1.919011530 61.596232770 0.916617910 curveto 60.382554310 1.759015550 56.741533283 1.759015550 55.527862000 0.916617910 closepath))
    (("op47-tie-0051" . 141/4) 0.070000001 (moveto 116.711589432 -1.140003655 curveto 117.102263270 -1.459995616 118.274227365 -1.459995616 118.664872493 -1.140003655 curveto 118.274227365 -1.620005950 117.102263270 -1.620005950 116.711589432 -1.140003655 closepath))
    (("op47-tie-0052" . 165/4) 0.069999986 (moveto 42.872724985 -2.394967574 curveto 43.622768784 -2.885000017 45.872896593 -2.885000017 46.622936804 -2.394967574 curveto 45.872896593 -3.044999552 43.622768784 -3.044999552 42.872724985 -2.394967574 closepath))
    (("op47-tie-0053" . 165/4) 0.069999986 (moveto 56.429948331 -2.394967574 curveto 57.268886343 -2.952561557 59.785707557 -2.952561557 60.624645569 -2.394967574 curveto 59.785707557 -3.112561092 57.268886343 -3.112561092 56.429948331 -2.394967574 closepath))
    (("op47-tie-0054" . 165/4) 0.069999986 (moveto 56.429948331 0.961804545 curveto 57.268886343 1.679398960 59.785707557 1.679398960 60.624645569 0.961804545 curveto 59.785707557 1.519398528 57.268886343 1.519398528 56.429948331 0.961804545 closepath))
    (("op47-tie-0055" . 165/4) 0.070000032 (moveto 42.872753217 0.987523639 curveto 43.622797511 0.497490872 45.872926801 0.497490872 46.622967506 0.987523639 curveto 45.872926801 0.337491232 43.622797511 0.337491232 42.872753217 0.987523639 closepath))
    (("op47-tie-0056" . 165/4) 0.070000032 (moveto 42.872753217 2.605030824 curveto 43.693892114 2.060967451 46.157305213 2.060967451 46.978440521 2.605030824 curveto 46.157305213 1.900967811 43.693892114 1.900967811 42.872753217 2.605030824 closepath))
    (("op47-tie-0057" . 165/4) 0.070000032 (moveto 56.429985491 1.038195275 curveto 57.268924056 0.480600925 59.785746927 0.480600925 60.624685491 1.038195275 curveto 59.785746927 0.320601285 57.268924056 0.320601285 56.429985491 1.038195275 closepath))
    (("op47-tie-0058" . 165/4) 0.069999986 (moveto 90.874121389 -1.140000268 curveto 91.342309778 -1.459999337 92.746874945 -1.459999337 93.215056156 -1.140000268 curveto 92.746874945 -1.619998872 91.342309778 -1.619998872 90.874121389 -1.140000268 closepath))
    (("op47-tie-0059" . 45) 0.070000001 (moveto 20.593186170 -2.394969442 curveto 21.343228334 -2.885001989 23.593354825 -2.885001989 24.343398783 -2.394969442 curveto 23.593354825 -3.045001558 21.343228334 -3.045001558 20.593186170 -2.394969442 closepath))
    (("op47-tie-0060" . 45) 0.070000001 (moveto 33.836757966 -2.394969442 curveto 34.608333771 -2.901366193 36.923057598 -2.901366193 37.694633404 -2.394969442 curveto 36.923057598 -3.061365762 34.608333771 -3.061365762 33.836757966 -2.394969442 closepath))
    (("op47-tie-0061" . 45) 0.070000001 (moveto 33.836757966 1.000200951 curveto 34.608333771 1.666600860 36.923057598 1.666600860 37.694633404 1.000200951 curveto 36.923057598 1.506597702 34.608333771 1.506597702 33.836757966 1.000200951 closepath))
    (("op47-tie-0062" . 45) 0.069999938 (moveto 20.593167766 1.105033145 curveto 21.614303946 0.408970150 24.677712487 0.408970150 25.698848668 1.105033145 curveto 24.677712487 0.248967136 21.614303946 0.248967136 20.593167766 1.105033145 closepath))
    (("op47-tie-0063" . 45) 0.069999938 (moveto 20.593167766 2.605030004 curveto 21.414305561 2.060967361 23.877711770 2.060967361 24.698849565 2.605030004 curveto 23.877711770 1.900967936 21.414305561 1.900967936 20.593167766 2.605030004 closepath))
    (("op47-tie-0064" . 45) 0.069999938 (moveto 26.357126893 0.750002009 curveto 27.650296189 -0.152806010 31.529807666 -0.152806010 32.822976962 0.750002009 curveto 31.529807666 -0.312809024 27.650296189 -0.312809024 26.357126893 0.750002009 closepath))
    (("op47-tie-0065" . 45) 0.069999938 (moveto 33.217946051 0.750002009 curveto 34.113275348 0.149551097 36.799266830 0.149551097 37.694599716 0.750002009 curveto 36.799266830 -0.010451917 34.113275348 -0.010451917 33.217946051 0.750002009 closepath))
    (("op47-tie-0066" . 45) 0.070000001 (moveto 46.885940244 -2.394969442 curveto 47.635984202 -2.885001989 49.886108899 -2.885001989 50.636152857 -2.394969442 curveto 49.886108899 -3.045001558 47.635984202 -3.045001558 46.885940244 -2.394969442 closepath))
    (("op47-tie-0067" . 45) 0.070000001 (moveto 59.934634467 -2.394969442 curveto 60.676011857 -2.878409656 62.900115316 -2.878409656 63.641485528 -2.394969442 curveto 62.900115316 -3.038409224 60.676011857 -3.038409224 59.934634467 -2.394969442 closepath))
    (("op47-tie-0068" . 45) 0.070000001 (moveto 59.934634467 1.017419252 curveto 60.676011857 1.660859034 62.900115316 1.660859034 63.641485528 1.017419252 curveto 62.900115316 1.500859465 60.676011857 1.500859465 59.934634467 1.017419252 closepath))
    (("op47-tie-0069" . 45) 0.069999938 (moveto 46.885898342 1.105033145 curveto 47.907034522 0.408970150 50.970439475 0.408970150 51.991582833 1.105033145 curveto 50.970439475 0.248967136 47.907034522 0.248967136 46.885898342 1.105033145 closepath))
    (("op47-tie-0070" . 45) 0.069999938 (moveto 46.885898342 2.605030004 curveto 47.707036137 2.060967361 50.170445935 2.060967361 50.991583730 2.605030004 curveto 50.170445935 1.900967936 47.707036137 1.900967936 46.885898342 2.605030004 closepath))
    (("op47-tie-0071" . 45) 0.069999938 (moveto 52.649861058 0.750002009 curveto 53.904054156 -0.123185392 57.666640630 -0.123185392 58.920833729 0.750002009 curveto 57.666640630 -0.283188406 53.904054156 -0.283188406 52.649861058 0.750002009 closepath))
    (("op47-tie-0072" . 45) 0.069999938 (moveto 59.315806406 0.750002009 curveto 60.180933726 0.172504026 62.776301331 0.172504026 63.641428652 0.750002009 curveto 62.776301331 0.012508189 60.180933726 0.012508189 59.315806406 0.750002009 closepath))
    (("op47-tie-0073" . 45) 0.070000001 (moveto 82.109027992 1.046706153 curveto 82.799016039 1.651097930 84.868973004 1.651097930 85.558968228 1.046706153 curveto 84.868973004 1.491098361 82.799016039 1.491098361 82.109027992 1.046706153 closepath))
    (("op47-tie-0074" . 45) 0.070000001 (moveto 103.361686197 1.071711805 curveto 104.007799517 1.642761516 105.946161007 1.642761516 106.592281504 1.071711805 curveto 105.946161007 1.482761947 104.007799517 1.482761947 103.361686197 1.071711805 closepath))
    (("op47-tie-0075" . 45) 0.070000001 (moveto 103.361686197 -2.394969442 curveto 104.007799517 -2.806019585 105.946161007 -2.806019585 106.592281504 -2.394969442 curveto 105.946161007 -2.966019154 104.007799517 -2.966019154 103.361686197 -2.394969442 closepath))
    (("op47-tie-0076" . 45) 0.070000001 (moveto 115.429554534 1.140000059 curveto 115.894613727 1.619998765 117.289791305 1.619998765 117.754864853 1.140000059 curveto 117.289791305 1.459999196 115.894613727 1.459999196 115.429554534 1.140000059 closepath))
    (("op47-tie-0077" . 45) 0.070000001 (moveto 126.236675792 -1.140000076 curveto 126.694227548 -1.459999214 128.066925878 -1.459999214 128.524477633 -1.140000076 curveto 128.066925878 -1.619998782 126.694227548 -1.619998782 126.236675792 -1.140000076 closepath))
    (("op47-tie-0077" . 195/4) 0.070000001 (moveto 9.377812115 -1.076764621 curveto 10.015065079 -1.481075295 11.926822178 -1.481075295 12.564075143 -1.076764621 curveto 11.926822178 -1.641078453 10.015065079 -1.641078453 9.377812115 -1.076764621 closepath))
    (("op47-tie-0078" . 195/4) 0.070000001 (moveto 54.330648226 0.499998203 curveto 55.184701772 1.229080908 57.746869589 1.229080908 58.600923135 0.499998203 curveto 57.746869589 1.069084928 55.184701772 1.069084928 54.330648226 0.499998203 closepath))
    (("op47-tie-0079" . 195/4) 0.070000001 (moveto 79.177201421 -0.027725839 curveto 79.900484881 -0.497421556 82.070320908 -0.497421556 82.793611546 -0.027725839 curveto 82.070320908 -0.657424714 79.900484881 -0.657424714 79.177201421 -0.027725839 closepath))
    (("op47-tie-0080" . 195/4) 0.070000001 (moveto 103.561717059 0.499998203 curveto 104.343725044 1.174325420 106.689749000 1.174325420 107.471764163 0.499998203 curveto 106.689749000 1.014329440 104.343725044 1.014329440 103.561717059 0.499998203 closepath))
    (("op47-tie-0081" . 105/2) 0.070000001 (moveto 92.535358531 -1.394969442 curveto 92.950191101 -1.714968580 94.194695989 -1.714968580 94.609521383 -1.394969442 curveto 94.194695989 -1.874971737 92.950191101 -1.874971737 92.535358531 -1.394969442 closepath))
    (("op47-tie-0082" . 105/2) 0.070000001 (moveto 92.535358531 0.394965848 curveto 92.950191101 0.874968143 94.194695989 0.874968143 94.609521383 0.394965848 curveto 94.194695989 0.714972163 92.950191101 0.714972163 92.535358531 0.394965848 closepath))
    (("op47-tie-0083" . 105/2) 0.070000001 (moveto 126.352890350 -0.499998209 curveto 126.787202065 -0.819997346 128.090165918 -0.819997346 128.524477633 -0.499998209 curveto 128.090165918 -0.980000503 126.787202065 -0.980000503 126.352890350 -0.499998209 closepath))
    (("op47-tie-0084" . 105/2) 0.070000001 (moveto 126.352890350 0.499998199 curveto 126.787202065 0.980000494 128.090165918 0.980000494 128.524477633 0.499998199 curveto 128.090165918 0.819997337 126.787202065 0.819997337 126.352890350 0.499998199 closepath))
    (("op47-tie-0085" . 105/2) 0.070000001 (moveto 126.352890350 2.394965840 curveto 126.787202065 2.874968135 128.090165918 2.874968135 128.524477633 2.394965840 curveto 128.090165918 2.714972155 126.787202065 2.714972155 126.352890350 2.394965840 closepath))
    (("op47-tie-0083" . 225/4) 0.070000001 (moveto 9.377812115 -0.500005371 curveto 9.646215563 -0.819997331 10.451424114 -0.819997331 10.719825768 -0.500005371 curveto 10.451424114 -0.979993311 9.646215563 -0.979993311 9.377812115 -0.500005371 closepath))
    (("op47-tie-0084" . 225/4) 0.070000001 (moveto 9.377812115 0.500005391 curveto 9.646215563 0.979993332 10.451424114 0.979993332 10.719825768 0.500005391 curveto 10.451424114 0.819997351 9.646215563 0.819997351 9.377812115 0.500005391 closepath))
    (("op47-tie-0085" . 225/4) 0.070000001 (moveto 9.377812115 2.394965855 curveto 9.646215563 2.874968150 10.451424114 2.874968150 10.719825768 2.394965855 curveto 10.451424114 2.714972170 9.646215563 2.714972170 9.377812115 2.394965855 closepath))
    (("op47-tie-0086" . 225/4) 0.070000001 (moveto 20.361356358 -1.394969427 curveto 20.835747813 -1.714975742 22.258922176 -1.714975742 22.733311836 -1.394969427 curveto 22.258922176 -1.874971722 20.835747813 -1.874971722 20.361356358 -1.394969427 closepath))
    (("op47-tie-0087" . 225/4) 0.070000001 (moveto 20.361356358 0.394973040 curveto 20.835747813 0.874975335 22.258922176 0.874975335 22.733311836 0.394973040 curveto 22.258922176 0.714965000 20.835747813 0.714965000 20.361356358 0.394973040 closepath))
    (("op47-tie-0088" . 225/4) 0.070000001 (moveto 55.641851600 0.500005391 curveto 56.580216683 -0.133160111 59.395319110 -0.133160111 60.333691371 0.500005391 curveto 59.395319110 -0.293156091 56.580216683 -0.293156091 55.641851600 0.500005391 closepath))
    (("op47-tie-0089" . 225/4) 0.070000001 (moveto 56.828414287 1.394969448 curveto 57.766779370 2.188130930 60.581881798 2.188130930 61.520246881 1.394969448 curveto 60.581881798 2.028134950 57.766779370 2.028134950 56.828414287 1.394969448 closepath))
    (("op47-tie-0090" . 225/4) 0.070000001 (moveto 56.828414287 4.394973025 curveto 57.766779370 5.188134507 60.581881798 5.188134507 61.520246881 4.394973025 curveto 60.581881798 5.028124172 57.766779370 5.028124172 56.828414287 4.394973025 closepath))
    (("op47-tie-0091" . 225/4) 0.070000001 (moveto 80.442340996 0.500005391 curveto 81.155418361 0.038061139 83.294643278 0.038061139 84.007713466 0.500005391 curveto 83.294643278 -0.121934841 81.155418361 -0.121934841 80.442340996 0.500005391 closepath))
    (("op47-tie-0092" . 225/4) 0.070000001 (moveto 80.442340996 1.500001799 curveto 81.155418361 2.121942031 83.294643278 2.121942031 84.007713466 1.500001799 curveto 83.294643278 1.961931697 81.155418361 1.961931697 80.442340996 1.500001799 closepath))
    (("op47-tie-0093" . 225/4) 0.070000001 (moveto 80.442340996 4.394973025 curveto 81.155418361 5.016898903 83.294643278 5.016898903 84.007713466 4.394973025 curveto 83.294643278 4.856902923 81.155418361 4.856902923 80.442340996 4.394973025 closepath))
    (("op47-tie-0094" . 225/4) 0.070000001 (moveto 103.733010081 0.500005391 curveto 104.478205785 0.013644024 106.713821605 0.013644024 107.459017309 0.500005391 curveto 106.713821605 -0.146351956 104.478205785 -0.146351956 103.733010081 0.500005391 closepath))
    (("op47-tie-0095" . 225/4) 0.070000001 (moveto 103.733010081 1.500001799 curveto 104.478205785 2.146359146 106.713821605 2.146359146 107.459017309 1.500001799 curveto 106.713821605 1.986348811 104.478205785 1.986348811 103.733010081 1.500001799 closepath))
    (("op47-tie-0096" . 225/4) 0.070000001 (moveto 103.733010081 4.394973025 curveto 104.478205785 5.041316017 106.713821605 5.041316017 107.459017309 4.394973025 curveto 106.713821605 4.881320037 104.478205785 4.881320037 103.733010081 4.394973025 closepath))
    (("op47-tie-0097" . 60) 0.069999986 (moveto 126.462647294 0.500001245 curveto 126.875010792 0.180000381 128.112101286 0.180000381 128.524450429 0.500001245 curveto 128.112101286 0.020000846 126.875010792 0.020000846 126.462647294 0.500001245 closepath))
    (("op47-tie-0098" . 60) 0.069999986 (moveto 126.462647294 2.394968485 curveto 126.875010792 2.874968884 128.112101286 2.874968884 128.524450429 2.394968485 curveto 128.112101286 2.714968452 126.875010792 2.714968452 126.462647294 2.394968485 closepath))
    (("op47-tie-0099" . 60) 0.069999986 (moveto 126.462647294 3.394968270 curveto 126.875010792 3.874968669 128.112101286 3.874968669 128.524450429 3.394968270 curveto 128.112101286 3.714968237 126.875010792 3.714968237 126.462647294 3.394968270 closepath))
    (("op47-tie-0100" . 60) 0.069999986 (moveto 126.462647294 4.394968054 curveto 126.875010792 4.874968453 128.112101286 4.874968453 128.524450429 4.394968054 curveto 128.112101286 4.714968021 126.875010792 4.714968021 126.462647294 4.394968054 closepath))
    (("op47-tie-0097" . 255/4) 0.070000001 (moveto 9.377812115 0.500001784 curveto 9.722215807 0.179999057 10.755423295 0.179999057 11.099825192 0.500001784 curveto 10.755423295 0.019999489 9.722215807 0.019999489 9.377812115 0.500001784 closepath))
    (("op47-tie-0098" . 255/4) 0.070000001 (moveto 9.377812115 2.394969425 curveto 9.722215807 2.874968131 10.755423295 2.874968131 11.099825192 2.394969425 curveto 10.755423295 2.714968562 9.722215807 2.714968562 9.377812115 2.394969425 closepath))
    (("op47-tie-0099" . 255/4) 0.070000001 (moveto 9.377812115 3.394969421 curveto 9.722215807 3.874968127 10.755423295 3.874968127 11.099825192 3.394969421 curveto 10.755423295 3.714968559 9.722215807 3.714968559 9.377812115 3.394969421 closepath))
    (("op47-tie-0100" . 255/4) 0.070000001 (moveto 9.377812115 4.394969417 curveto 9.722215807 4.874968123 10.755423295 4.874968123 11.099825192 4.394969417 curveto 10.755423295 4.714968555 9.722215807 4.714968555 9.377812115 4.394969417 closepath))
    (("op47-tie-0101" . 255/4) 0.070000001 (moveto 68.234099369 0.140000062 curveto 68.747389900 0.619998769 70.287232783 0.619998769 70.800516137 0.140000062 curveto 70.287232783 0.459999200 68.747389900 0.459999200 68.234099369 0.140000062 closepath))
    (("op47-tie-0102" . 255/4) 0.070000001 (moveto 68.234099369 -4.894967639 curveto 68.676291740 -5.214970365 70.002854499 -5.214970365 70.445046870 -4.894967639 curveto 70.002854499 -5.374969933 68.676291740 -5.374969933 68.234099369 -4.894967639 closepath))
    (("op47-tie-0103" . 255/4) 0.070000001 (moveto 68.234099369 -3.394969439 curveto 68.676291740 -3.714968576 70.002854499 -3.714968576 70.445046870 -3.394969439 curveto 70.002854499 -3.874968145 68.676291740 -3.874968145 68.234099369 -3.394969439 closepath))
    (("op47-tie-0104" . 255/4) 0.070000001 (moveto 68.234099369 -5.394969421 curveto 68.676291740 -5.714968558 70.002854499 -5.714968558 70.445046870 -5.394969421 curveto 70.002854499 -5.874971716 68.676291740 -5.874971716 68.234099369 -5.394969421 closepath))
    (("op47-tie-0105" . 255/4) 0.070000001 (moveto 68.234099369 -0.860003512 curveto 68.676291740 -0.380001217 70.002854499 -0.380001217 70.445046870 -0.860003512 curveto 70.002854499 -0.539997197 68.676291740 -0.539997197 68.234099369 -0.860003512 closepath))
    (("op47-tie-0106" . 255/4) 0.070000001 (moveto 114.607669567 0.140000062 curveto 115.120945744 0.619998769 116.660788627 0.619998769 117.174079158 0.140000062 curveto 116.660788627 0.459999200 115.120945744 0.459999200 114.607669567 0.140000062 closepath))
    (("op47-tie-0107" . 255/4) 0.070000001 (moveto 114.607669567 -4.894967639 curveto 115.049847584 -5.214970365 116.376424697 -5.214970365 116.818617068 -4.894967639 curveto 116.376424697 -5.374969933 115.049847584 -5.374969933 114.607669567 -4.894967639 closepath))
    (("op47-tie-0108" . 255/4) 0.070000001 (moveto 114.607669567 -3.394969439 curveto 115.049847584 -3.714968576 116.376424697 -3.714968576 116.818617068 -3.394969439 curveto 116.376424697 -3.874968145 115.049847584 -3.874968145 114.607669567 -3.394969439 closepath))
    (("op47-tie-0109" . 255/4) 0.070000001 (moveto 114.607669567 -5.394969421 curveto 115.049847584 -5.714968558 116.376424697 -5.714968558 116.818617068 -5.394969421 curveto 116.376424697 -5.874971716 115.049847584 -5.874971716 114.607669567 -5.394969421 closepath))
    (("op47-tie-0110" . 255/4) 0.070000001 (moveto 114.607669567 -0.860003512 curveto 115.049847584 -0.380001217 116.376424697 -0.380001217 116.818617068 -0.860003512 curveto 116.376424697 -0.539997197 115.049847584 -0.539997197 114.607669567 -0.860003512 closepath))
    (("op47-tie-0111" . 135/2) 0.070000001 (moveto 20.294460498 4.894971208 curveto 20.859309037 5.404256815 22.553854654 5.404256815 23.118703194 4.894971208 curveto 22.553854654 5.244253658 20.859309037 5.244253658 20.294460498 4.894971208 closepath))
    (("op47-tie-0112" . 135/2) 0.070000001 (moveto 20.294460498 0.605030544 curveto 20.788214466 0.285031407 22.269476370 0.285031407 22.763233926 0.605030544 curveto 22.269476370 0.125028250 20.788214466 0.125028250 20.294460498 0.605030544 closepath))
    (("op47-tie-0113" . 135/2) 0.070000001 (moveto 20.294460498 3.105028741 curveto 20.788214466 2.785029603 22.269476370 2.785029603 22.763233926 3.105028741 curveto 22.269476370 2.625033623 20.788214466 2.625033623 20.294460498 3.105028741 closepath))
    (("op47-tie-0114" . 135/2) 0.070000001 (moveto 24.395767824 0.605030544 curveto 26.878048898 -0.614971102 34.324884944 -0.614971102 36.807162430 0.605030544 curveto 34.324884944 -0.774967082 26.878048898 -0.774967082 24.395767824 0.605030544 closepath))
    (("op47-tie-0115" . 135/2) 0.070000001 (moveto 24.395767824 3.105028741 curveto 26.878048898 1.885034272 34.324884944 1.885034272 36.807162430 3.105028741 curveto 34.324884944 1.725031114 26.878048898 1.725031114 24.395767824 3.105028741 closepath))
    (("op47-tie-0116" . 135/2) 0.070000001 (moveto 20.294460498 -5.894967629 curveto 20.788214466 -6.214966766 22.269476370 -6.214966766 22.763233926 -5.894967629 curveto 22.269476370 -6.374969924 20.788214466 -6.374969924 20.294460498 -5.894967629 closepath))
    (("op47-tie-0117" . 135/2) 0.070000001 (moveto 20.294460498 -1.605034143 curveto 20.788214466 -1.125031848 22.269476370 -1.125031848 22.763233926 -1.605034143 curveto 22.269476370 -1.285027828 20.788214466 -1.285027828 20.294460498 -1.605034143 closepath))
    (("op47-tie-0118" . 135/2) 0.070000001 (moveto 46.022922272 3.894967623 curveto 46.465111054 4.374969918 47.791673813 4.374969918 48.233859006 3.894967623 curveto 47.791673813 4.214966760 46.465111054 4.214966760 46.022922272 3.894967623 closepath))
    (("op47-tie-0119" . 135/2) 0.070000001 (moveto 46.022922272 4.894971208 curveto 46.465111054 5.374966325 47.791673813 5.374966325 48.233859006 4.894971208 curveto 47.791673813 5.214970345 46.465111054 5.214970345 46.022922272 4.894971208 closepath))
    (("op47-tie-0120" . 135/2) 0.070000001 (moveto 46.022922272 0.605030544 curveto 46.465111054 0.285031407 47.791673813 0.285031407 48.233859006 0.605030544 curveto 47.791673813 0.125028250 46.465111054 0.125028250 46.022922272 0.605030544 closepath))
    (("op47-tie-0121" . 135/2) 0.070000001 (moveto 38.439699916 -5.894967629 curveto 39.629836890 -6.719472304 43.200247812 -6.719472304 44.390384786 -5.894967629 curveto 43.200247812 -6.879475461 39.629836890 -6.879475461 38.439699916 -5.894967629 closepath))
    (("op47-tie-0122" . 135/2) 0.070000001 (moveto 38.439699916 -1.605034143 curveto 39.629836890 -0.620526311 43.200247812 -0.620526311 44.390384786 -1.605034143 curveto 43.200247812 -0.780529468 39.629836890 -0.780529468 38.439699916 -1.605034143 closepath))
    (("op47-tie-0123" . 135/2) 0.070000001 (moveto 69.991758420 4.894971208 curveto 70.505041774 5.374966325 72.044891834 5.374966325 72.558168011 4.894971208 curveto 72.044891834 5.214970345 70.505041774 5.214970345 69.991758420 4.894971208 closepath))
    (("op47-tie-0124" . 135/2) 0.070000001 (moveto 69.991758420 0.605030544 curveto 70.433950791 0.285031407 71.760513550 0.285031407 72.202698743 0.605030544 curveto 71.760513550 0.125028250 70.433950791 0.125028250 69.991758420 0.605030544 closepath))
    (("op47-tie-0125" . 135/2) 0.070000001 (moveto 69.991758420 1.859999911 curveto 70.433950791 1.540000773 71.760513550 1.540000773 72.202698743 1.859999911 curveto 71.760513550 1.379997616 70.433950791 1.379997616 69.991758420 1.859999911 closepath))
    (("op47-tie-0126" . 135/2) 0.070000001 (moveto 69.991758420 -5.894967629 curveto 70.433950791 -6.214966766 71.760513550 -6.214966766 72.202698743 -5.894967629 curveto 71.760513550 -6.374969924 70.433950791 -6.374969924 69.991758420 -5.894967629 closepath))
    (("op47-tie-0127" . 135/2) 0.070000001 (moveto 69.991758420 -1.605034143 curveto 70.433950791 -1.125031848 71.760513550 -1.125031848 72.202698743 -1.605034143 curveto 71.760513550 -1.285027828 70.433950791 -1.285027828 69.991758420 -1.605034143 closepath))
    (("op47-tie-0128" . 135/2) 0.070000001 (moveto 93.883374186 3.894967623 curveto 94.368802507 4.374969918 95.825123355 4.374969918 96.310566030 3.894967623 curveto 95.825123355 4.214966760 94.368802507 4.214966760 93.883374186 3.894967623 closepath))
    (("op47-tie-0129" . 135/2) 0.070000001 (moveto 93.883374186 4.894971208 curveto 94.368802507 5.374966325 95.825123355 5.374966325 96.310566030 4.894971208 curveto 95.825123355 5.214970345 94.368802507 5.214970345 93.883374186 4.894971208 closepath))
    (("op47-tie-0130" . 135/2) 0.070000001 (moveto 93.883374186 0.605030544 curveto 94.368802507 0.285031407 95.825123355 0.285031407 96.310566030 0.605030544 curveto 95.825123355 0.125028250 94.368802507 0.125028250 93.883374186 0.605030544 closepath))
    (("op47-tie-0131" . 135/2) 0.070000001 (moveto 93.883374186 -1.605034143 curveto 94.439900667 -1.102064544 96.109494462 -1.102064544 96.666028120 -1.605034143 curveto 96.109494462 -1.262067702 94.439900667 -1.262067702 93.883374186 -1.605034143 closepath))
    (("op47-tie-0132" . 135/2) 0.070000001 (moveto 93.883374186 -5.894967629 curveto 94.368802507 -6.214966766 95.825123355 -6.214966766 96.310566030 -5.894967629 curveto 95.825123355 -6.374969924 94.368802507 -6.374969924 93.883374186 -5.894967629 closepath))
    (("op47-tie-0133" . 135/2) 0.070000001 (moveto 111.692243086 -3.605034135 curveto 113.251507696 -2.339987865 117.929315880 -2.339987865 119.488580490 -3.605034135 curveto 117.929315880 -2.499991022 113.251507696 -2.499991022 111.692243086 -3.605034135 closepath))
    (("op47-tie-0134" . 285/4) 0.070000001 (moveto 94.118595264 -0.105032362 curveto 96.566249539 1.274965264 103.909190833 1.274965264 106.356837931 -0.105032362 curveto 103.909190833 1.114969284 96.566249539 1.114969284 94.118595264 -0.105032362 closepath))
    (("op47-tie-0135" . 285/4) 0.070000001 (moveto 126.138174768 -2.394965856 curveto 126.615435341 -2.714972171 128.047217060 -2.714972171 128.524477633 -2.394965856 curveto 128.047217060 -2.874968151 126.615435341 -2.874968151 126.138174768 -2.394965856 closepath))
    (("op47-tie-0135" . 75) 0.070000001 (moveto 9.377812115 -2.394965835 curveto 10.022283631 -2.804759954 11.955696386 -2.804759954 12.600169696 -2.394965835 curveto 11.955696386 -2.964770288 10.022283631 -2.964770288 9.377812115 -2.394965835 closepath))
    (("op47-tie-0136" . 75) 0.070000001 (moveto 26.214652683 0.894971243 curveto 28.384111902 2.274961692 34.892485971 2.274961692 37.061945191 0.894971243 curveto 34.892485971 2.114965712 28.384111902 2.114965712 26.214652683 0.894971243 closepath))
    (("op47-tie-0137" . 75) 0.070000001 (moveto 61.257752130 -1.394969428 curveto 62.159993951 -2.000674647 64.866719413 -2.000674647 65.768961234 -1.394969428 curveto 64.866719413 -2.160670628 62.159993951 -2.160670628 61.257752130 -1.394969428 closepath))
    (("op47-tie-0138" . 315/4) 0.069999986 (moveto 20.157319895 -1.140000268 curveto 20.611308034 -1.459999337 21.973272450 -1.459999337 22.427260588 -1.140000268 curveto 21.973272450 -1.619998872 20.611308034 -1.619998872 20.157319895 -1.140000268 closepath))
    (("op47-tie-0139" . 315/4) 0.069999986 (moveto 67.051240322 -2.394967574 curveto 67.801280532 -2.885000017 70.051401164 -2.885000017 70.801448552 -2.394967574 curveto 70.051401164 -3.044999552 67.801280532 -3.044999552 67.051240322 -2.394967574 closepath))
    (("op47-tie-0140" . 315/4) 0.069999986 (moveto 80.438067842 -2.394967574 curveto 81.259959811 -2.939611948 83.725671607 -2.939611948 84.547563577 -2.394967574 curveto 83.725671607 -3.099611483 81.259959811 -3.099611483 80.438067842 -2.394967574 closepath))
    (("op47-tie-0141" . 315/4) 0.069999986 (moveto 80.438067842 0.971517201 curveto 81.259959811 1.676161110 83.725671607 1.676161110 84.547563577 0.971517201 curveto 83.725671607 1.516161575 81.259959811 1.516161575 80.438067842 0.971517201 closepath))
    (("op47-tie-0142" . 315/4) 0.070000032 (moveto 67.051284476 0.987523639 curveto 67.801325181 0.497490872 70.051447294 0.497490872 70.801495176 0.987523639 curveto 70.051447294 0.337491232 67.801325181 0.337491232 67.051284476 0.987523639 closepath))
    (("op47-tie-0143" . 315/4) 0.070000032 (moveto 67.051284476 2.605030824 curveto 67.872423372 2.060967451 70.335832883 2.060967451 71.156971780 2.605030824 curveto 70.335832883 1.900967811 67.872423372 1.900967811 67.051284476 2.605030824 closepath))
    (("op47-tie-0144" . 315/4) 0.070000032 (moveto 80.438120812 1.028482613 curveto 81.260013323 0.483837881 83.725726742 0.483837881 84.547619254 1.028482613 curveto 83.725726742 0.323838241 81.260013323 0.323838241 80.438120812 1.028482613 closepath))
    (("op47-tie-0145" . 315/4) 0.069999986 (moveto 114.229086804 -1.140000268 curveto 114.683078531 -1.459999337 116.045039358 -1.459999337 116.499031086 -1.140000268 curveto 116.045039358 -1.619998872 114.683078531 -1.619998872 114.229086804 -1.140000268 closepath))
    (("op47-tie-0146" . 165/2) 0.070000001 (moveto 42.339555279 -2.394969442 curveto 43.089599237 -2.885001989 45.339723934 -2.885001989 46.089767892 -2.394969442 curveto 45.339723934 -3.045001558 43.089599237 -3.045001558 42.339555279 -2.394969442 closepath))
    (("op47-tie-0147" . 165/2) 0.070000001 (moveto 55.598816615 -2.394969442 curveto 56.407961905 -2.929917423 58.835390598 -2.929917423 59.644528711 -2.394969442 curveto 58.835390598 -3.089916992 56.407961905 -3.089916992 55.598816615 -2.394969442 closepath))
    (("op47-tie-0148" . 165/2) 0.070000001 (moveto 55.598816615 0.978787529 curveto 56.407961905 1.673738667 58.835390598 1.673738667 59.644528711 0.978787529 curveto 58.835390598 1.513735510 56.407961905 1.513735510 55.598816615 0.978787529 closepath))
    (("op47-tie-0149" . 165/2) 0.069999938 (moveto 42.339517440 0.987526802 curveto 43.089560728 0.497494693 45.339683414 0.497494693 46.089726701 0.987526802 curveto 45.339683414 0.337495267 43.089560728 0.337495267 42.339517440 0.987526802 closepath))
    (("op47-tie-0150" . 165/2) 0.069999938 (moveto 42.339517440 2.605030025 curveto 43.160655236 2.060967382 45.624061444 2.060967382 46.445195651 2.605030025 curveto 45.624061444 1.900967956 43.160655236 1.900967956 42.339517440 2.605030025 closepath))
    (("op47-tie-0151" . 165/2) 0.069999938 (moveto 55.598766926 1.021213347 curveto 56.407911493 0.486265845 58.835338017 0.486265845 59.644475407 1.021213347 curveto 58.835338017 0.326262830 56.407911493 0.326262830 55.598766926 1.021213347 closepath))
    (("op47-tie-0152" . 165/2) 0.070000001 (moveto 69.065171257 -2.394969442 curveto 69.815218804 -2.885001989 72.065347089 -2.885001989 72.815387459 -2.394969442 curveto 72.065347089 -3.045001558 69.815218804 -3.045001558 69.065171257 -2.394969442 closepath))
    (("op47-tie-0153" . 165/2) 0.070000001 (moveto 82.236030005 -2.394969442 curveto 83.036325706 -2.923199487 85.437241518 -2.923199487 86.237537219 -2.394969442 curveto 85.437241518 -3.083199055 83.036325706 -3.083199055 82.236030005 -2.394969442 closepath))
    (("op47-tie-0154" . 165/2) 0.070000001 (moveto 82.236030005 0.983825981 curveto 83.036325706 1.672059183 85.437241518 1.672059183 86.237537219 0.983825981 curveto 85.437241518 1.512056026 83.036325706 1.512056026 82.236030005 0.983825981 closepath))
    (("op47-tie-0155" . 165/2) 0.069999938 (moveto 69.065109534 0.987526802 curveto 69.815156410 0.497494693 72.065282684 0.497494693 72.815322383 0.987526802 curveto 72.065282684 0.337495267 69.815156410 0.337495267 69.065109534 0.987526802 closepath))
    (("op47-tie-0156" . 165/2) 0.069999938 (moveto 69.065109534 2.605030025 curveto 69.886247329 2.060967382 72.349660715 2.060967382 73.170798510 2.605030025 curveto 72.349660715 1.900967956 69.886247329 1.900967956 69.065109534 2.605030025 closepath))
    (("op47-tie-0157" . 165/2) 0.069999938 (moveto 82.235956510 1.016174900 curveto 83.036251496 0.487945327 85.437165162 0.487945327 86.237460148 1.016174900 curveto 85.437165162 0.327942313 83.036251496 0.327942313 82.235956510 1.016174900 closepath))
    (("op47-tie-0158" . 165/2) 0.070000001 (moveto 104.790467812 -2.394969442 curveto 105.412781263 -2.787922067 107.279700084 -2.787922067 107.902013536 -2.394969442 curveto 107.279700084 -2.947921636 105.412781263 -2.947921636 104.790467812 -2.394969442 closepath))
    (("op47-tie-0159" . 165/2) 0.070000001 (moveto 104.790467812 1.085284046 curveto 105.412781263 1.638239828 107.279700084 1.638239828 107.902013536 1.085284046 curveto 107.279700084 1.478240259 105.412781263 1.478240259 104.790467812 1.085284046 closepath))
    (("op47-tie-0160" . 345/4) 0.070000001 (moveto 15.882798507 4.749997287 curveto 17.921205932 6.130002090 24.036433590 6.130002090 26.074842809 4.749997287 curveto 24.036433590 5.969998933 17.921205932 5.969998933 15.882798507 4.749997287 closepath))
    (("op47-tie-0161" . 345/4) 0.070000001 (moveto 51.646631685 -0.140000067 curveto 52.104571014 -0.459999205 53.478381823 -0.459999205 53.936321152 -0.140000067 curveto 53.478381823 -0.620002362 52.104571014 -0.620002362 51.646631685 -0.140000067 closepath))
    (("op47-tie-0162" . 345/4) 0.070000001 (moveto 72.033178509 4.749997287 curveto 74.378054100 6.130002090 81.412680873 6.130002090 83.757556463 4.749997287 curveto 81.412680873 5.969998933 74.378054100 5.969998933 72.033178509 4.749997287 closepath))
    (("op47-tie-0163" . 357/4) 0.070000001 (moveto 14.001767354 3.250002671 curveto 15.999624927 4.630000297 21.993201237 4.630000297 23.991055222 3.250002671 curveto 21.993201237 4.469997140 15.999624927 4.469997140 14.001767354 3.250002671 closepath))
    (("op47-tie-0164" . 357/4) 0.070000001 (moveto 48.873929054 -0.605037737 curveto 49.505626802 -0.044936970 51.400720046 -0.044936970 52.032424971 -0.605037737 curveto 51.400720046 -0.204947305 49.505626802 -0.204947305 48.873929054 -0.605037737 closepath))
    (("op47-tie-0165" . 357/4) 0.070000001 (moveto 70.196031056 6.749997275 curveto 72.419129695 8.130002078 79.088425614 8.130002078 81.311524254 6.749997275 curveto 79.088425614 7.969998921 72.419129695 7.969998921 70.196031056 6.749997275 closepath))
    (("op47-tie-0166" . 369/4) 0.070000001 (moveto 79.739419486 1.105035931 curveto 82.717496465 -0.114972893 91.651727403 -0.114972893 94.629804383 1.105035931 curveto 91.651727403 -0.274968873 82.717496465 -0.274968873 79.739419486 1.105035931 closepath))
    (("op47-tie-0167" . 369/4) 0.070000001 (moveto 80.925982173 1.605034134 curveto 83.918499845 0.385025311 92.896038505 0.385025311 95.888548999 1.605034134 curveto 92.896038505 0.225029331 83.918499845 0.225029331 80.925982173 1.605034134 closepath))
    (("op47-tie-0168" . 369/4) 0.070000001 (moveto 80.925982173 2.605030542 curveto 83.918499845 1.385036073 92.896038505 1.385036073 95.888548999 2.605030542 curveto 92.896038505 1.225025738 83.918499845 1.225025738 80.925982173 2.605030542 closepath))
    (("op47-tie-0169" . 207/2) 0.070000001 (moveto 51.092915111 -1.074754991 curveto 51.733699299 -1.481749969 53.656041095 -1.481749969 54.296828871 -1.074754991 curveto 53.656041095 -1.641745949 51.733699299 -1.641745949 51.092915111 -1.074754991 closepath))
    (("op47-tie-0170" . 207/2) 0.070000001 (moveto 51.092915111 2.605030538 curveto 51.733699299 2.198035560 53.656041095 2.198035560 54.296828871 2.605030538 curveto 53.656041095 2.038039580 51.733699299 2.038039580 51.092915111 2.605030538 closepath))
    (("op47-tie-0171" . 207/2) 0.070000001 (moveto 105.291743572 1.394969428 curveto 106.957260671 2.740760126 111.953826322 2.740760126 113.619343421 1.394969428 curveto 111.953826322 2.580764146 106.957260671 2.580764146 105.291743572 1.394969428 closepath))
    (("op47-tie-0172" . 207/2) 0.070000001 (moveto 105.291743572 2.394965835 curveto 106.957260671 3.740763711 111.953826322 3.740763711 113.619343421 2.394965835 curveto 111.953826322 3.580760554 106.957260671 3.580760554 105.291743572 2.394965835 closepath))
    (("op47-tie-0173" . 207/2) 0.070000001 (moveto 105.291743572 -1.894967651 curveto 106.957260671 -3.080762369 111.953826322 -3.080762369 113.619343421 -1.894967651 curveto 111.953826322 -3.240765526 106.957260671 -3.240765526 105.291743572 -1.894967651 closepath))
    (("op47-tie-0174" . 213/2) 0.070000001 (moveto 39.274227666 0.894971227 curveto 40.302775303 1.756661402 43.388411037 1.756661402 44.416955085 0.894971227 curveto 43.388411037 1.596665422 40.302775303 1.596665422 39.274227666 0.894971227 closepath))
    (("op47-tie-0175" . 441/4) 0.069999986 (moveto 43.266219411 -3.394967358 curveto 43.849061274 -3.757927837 45.597586863 -3.757927837 46.180428726 -3.394967358 curveto 45.597586863 -3.917927372 43.849061274 -3.917927372 43.266219411 -3.394967358 closepath))
    (("op47-tie-0176" . 441/4) 0.069999986 (moveto 56.080321446 -3.394967358 curveto 56.928546859 -3.959620197 59.473230277 -3.959620197 60.321455691 -3.394967358 curveto 59.473230277 -4.119621526 56.928546859 -4.119621526 56.080321446 -3.394967358 closepath))
    (("op47-tie-0177" . 441/4) 0.069999986 (moveto 56.080321446 -0.043489381 curveto 56.928546859 0.681163890 59.473230277 0.681163890 60.321455691 -0.043489381 curveto 59.473230277 0.521163458 56.928546859 0.521163458 56.080321446 -0.043489381 closepath))
    (("op47-tie-0178" . 441/4) 0.070000032 (moveto 43.266247903 -0.107780392 curveto 43.849090150 -0.470741110 45.597616890 -0.470741110 46.180459137 -0.107780392 curveto 45.597616890 -0.630740750 43.849090150 -0.630740750 43.266247903 -0.107780392 closepath))
    (("op47-tie-0179" . 441/4) 0.070000032 (moveto 43.266247903 1.605030381 curveto 43.920184753 1.188039056 45.881995302 1.188039056 46.535935740 1.605030381 curveto 45.881995302 1.028039416 43.920184753 1.028039416 43.266247903 1.605030381 closepath))
    (("op47-tie-0180" . 441/4) 0.070000032 (moveto 56.080358376 0.043488080 curveto 56.928584348 -0.521165130 59.473269441 -0.521165130 60.321495414 0.043488080 curveto 59.473269441 -0.681164771 56.928584348 -0.681164771 56.080358376 0.043488080 closepath))
    (("op47-tie-0181" . 441/4) 0.069999986 (moveto 91.238598069 -2.107779444 curveto 91.821443520 -2.470739923 93.569972698 -2.470739923 94.152810972 -2.107779444 curveto 93.569972698 -2.630739458 91.821443520 -2.630739458 91.238598069 -2.107779444 closepath))
    (("op47-tie-0182" . 114) 0.070000001 (moveto 19.341355070 -3.394969439 curveto 19.924198851 -3.757928200 21.672724810 -3.757928200 22.255566796 -3.394969439 curveto 21.672724810 -3.917927769 19.924198851 -3.917927769 19.341355070 -3.394969439 closepath))
    (("op47-tie-0183" . 114) 0.070000001 (moveto 30.882287068 -3.394969439 curveto 31.564677962 -3.833587523 33.611854232 -3.833587523 34.294245126 -3.394969439 curveto 33.611854232 -3.993587092 31.564677962 -3.993587092 30.882287068 -3.394969439 closepath))
    (("op47-tie-0184" . 114) 0.070000001 (moveto 30.882287068 0.051037647 curveto 31.564677962 0.649655300 33.611854232 0.649655300 34.294245126 0.051037647 curveto 33.611854232 0.489655731 31.564677962 0.489655731 30.882287068 0.051037647 closepath))
    (("op47-tie-0185" . 114) 0.070000001 (moveto 19.341355070 -0.107781246 curveto 19.924198851 -0.470743596 21.672724810 -0.470743596 22.255566796 -0.107781246 curveto 21.672724810 -0.630739576 19.924198851 -0.630739576 19.341355070 -0.107781246 closepath))
    (("op47-tie-0186" . 114) 0.070000001 (moveto 19.341355070 1.605034144 curveto 19.995291628 1.188041212 21.957103095 1.188041212 22.611036064 1.605034144 curveto 21.957103095 1.028038055 19.995291628 1.028038055 19.341355070 1.605034144 closepath))
    (("op47-tie-0187" . 114) 0.070000001 (moveto 30.882287068 -0.051037651 curveto 31.564677962 -0.489655735 33.611854232 -0.489655735 34.294245126 -0.051037651 curveto 33.611854232 -0.649651715 31.564677962 -0.649651715 30.882287068 -0.051037651 closepath))
    (("op47-tie-0188" . 114) 0.070000001 (moveto 42.535775004 -3.394969439 curveto 43.118616990 -3.757928200 44.867142949 -3.757928200 45.449988524 -3.394969439 curveto 44.867142949 -3.917927769 43.118616990 -3.917927769 42.535775004 -3.394969439 closepath))
    (("op47-tie-0189" . 114) 0.070000001 (moveto 54.076715973 -3.394969439 curveto 54.759103278 -3.833587523 56.806272371 -3.833587523 57.488666853 -3.394969439 curveto 56.806272371 -3.993587092 54.759103278 -3.993587092 54.076715973 -3.394969439 closepath))
    (("op47-tie-0190" . 114) 0.070000001 (moveto 54.076715973 0.051037647 curveto 54.759103278 0.649655300 56.806272371 0.649655300 57.488666853 0.051037647 curveto 56.806272371 0.489655731 54.759103278 0.489655731 54.076715973 0.051037647 closepath))
    (("op47-tie-0191" . 114) 0.070000001 (moveto 42.535775004 -0.107781246 curveto 43.118616990 -0.470743596 44.867142949 -0.470743596 45.449988524 -0.107781246 curveto 44.867142949 -0.630739576 43.118616990 -0.630739576 42.535775004 -0.107781246 closepath))
    (("op47-tie-0192" . 114) 0.070000001 (moveto 42.535775004 1.605034144 curveto 43.189711561 1.188041212 45.151521234 1.188041212 45.805457791 1.605034144 curveto 45.151521234 1.028038055 43.189711561 1.028038055 42.535775004 1.605034144 closepath))
    (("op47-tie-0193" . 114) 0.070000001 (moveto 107.354896473 -1.872276672 curveto 108.350909488 -2.549241540 111.338934181 -2.549241540 112.334940020 -1.872276672 curveto 111.338934181 -2.709241108 108.350909488 -2.709241108 107.354896473 -1.872276672 closepath))
    (("op47-tie-0194" . 114) 0.070000001 (moveto 123.845248348 -0.249999111 curveto 124.781094205 -0.881244690 127.588631776 -0.881244690 128.524477633 -0.249999111 curveto 127.588631776 -1.041244258 124.781094205 -1.041244258 123.845248348 -0.249999111 closepath))
    (("op47-tie-0195" . 114) 0.070000001 (moveto 107.973678701 -4.894971227 curveto 108.722175954 -5.383826700 110.967667715 -5.383826700 111.716157792 -4.894971227 curveto 110.967667715 -5.543826269 108.722175954 -5.543826269 107.973678701 -4.894971227 closepath))
    (("op47-tie-0196" . 114) 0.070000001 (moveto 107.973678701 -3.394973027 curveto 108.722175954 -3.883824911 110.967667715 -3.883824911 111.716157792 -3.394973027 curveto 110.967667715 -4.043828069 108.722175954 -4.043828069 107.973678701 -3.394973027 closepath))
    (("op47-tie-0197" . 114) 0.070000001 (moveto 124.464030576 -3.394973027 curveto 125.276125729 -3.932160320 127.712382480 -3.932160320 128.524477633 -3.394973027 curveto 127.712382480 -4.092159889 125.276125729 -4.092159889 124.464030576 -3.394973027 closepath))
    (("op47-tie-0198" . 114) 0.070000001 (moveto 124.464030576 -2.394969442 curveto 125.276125729 -2.932160324 127.712382480 -2.932160324 128.524477633 -2.394969442 curveto 127.712382480 -3.092159892 125.276125729 -3.092159892 124.464030576 -2.394969442 closepath))
    (("op47-tie-0194" . 471/4) 0.070000001 (moveto 9.461249817 -0.249999109 curveto 9.929409596 -0.569998247 11.333887139 -0.569998247 11.802046917 -0.249999109 curveto 11.333887139 -0.730001404 9.929409596 -0.730001404 9.461249817 -0.249999109 closepath))
    (("op47-tie-0197" . 471/4) 0.070000001 (moveto 9.461249817 -3.394969437 curveto 9.805651715 -3.714968575 10.838860997 -3.714968575 11.183262895 -3.394969437 curveto 10.838860997 -3.874964555 9.805651715 -3.874964555 9.461249817 -3.394969437 closepath))
    (("op47-tie-0198" . 471/4) 0.070000001 (moveto 9.461249817 -2.394965852 curveto 9.805651715 -2.714964990 10.838860997 -2.714964990 11.183262895 -2.394965852 curveto 10.838860997 -2.874968147 9.805651715 -2.874968147 9.461249817 -2.394965852 closepath))
    (("op47-tie-0199" . 471/4) 0.070000001 (moveto 64.954992810 -1.750000898 curveto 66.197624427 -0.001765619 70.224237776 -0.001765619 71.666010272 -1.750000898 curveto 70.224237776 -0.161761599 66.197624427 -0.161761599 64.954992810 -1.750000898 closepath))
    (("op47-tie-0200" . 471/4) 0.070000001 (moveto 86.272935576 -1.750000898 curveto 88.091335968 -0.281686811 93.247818649 -0.281686811 94.867078163 -1.750000898 curveto 93.247818649 -0.441689969 88.091335968 -0.441689969 86.272935576 -1.750000898 closepath))
    (("op47-tie-0201" . 471/4) 0.070000001 (moveto 65.573775038 -2.394965852 curveto 66.668468510 -3.146929733 69.952534572 -3.146929733 71.047220866 -2.394965852 curveto 69.952534572 -3.306932891 66.668468510 -3.306932891 65.573775038 -2.394965852 closepath))
    (("op47-tie-0202" . 471/4) 0.070000001 (moveto 86.891724981 -2.394965852 curveto 88.363039172 -3.433166934 92.776981744 -3.433166934 94.248295935 -2.394965852 curveto 92.776981744 -3.593162914 88.363039172 -3.593162914 86.891724981 -2.394965852 closepath))
    (("op47-tie-0203" . 120) 0.070000001 (moveto 32.745685433 -1.750000902 curveto 33.913508236 0.031192458 37.416980233 0.031192458 38.584806624 -1.750000902 curveto 37.416980233 -0.128803522 33.913508236 -0.128803522 32.745685433 -1.750000902 closepath))
    (("op47-tie-0204" . 120) 0.070000001 (moveto 33.364467661 -4.894971230 curveto 34.284778290 -5.514406591 37.045710178 -5.514406591 37.966020807 -4.894971230 curveto 37.045710178 -5.674409748 34.284778290 -5.674409748 33.364467661 -4.894971230 closepath))
    (("op47-tie-0205" . 120) 0.070000001 (moveto 33.364467661 -3.394976619 curveto 34.284778290 -4.014411980 37.045710178 -4.014411980 37.966020807 -3.394976619 curveto 37.045710178 -4.174407960 34.284778290 -4.174407960 33.364467661 -3.394976619 closepath))
    (("op47-tie-0206" . 120) 0.070000001 (moveto 33.364467661 -2.394973034 curveto 34.284778290 -3.014408395 37.045710178 -3.014408395 37.966020807 -2.394973034 curveto 37.045710178 -3.174411552 34.284778290 -3.174411552 33.364467661 -2.394973034 closepath))
    (("op47-tie-0207" . 120) 0.070000001 (moveto 47.541750072 -0.249999114 curveto 48.318952867 -0.760677114 50.650564840 -0.760677114 51.427764046 -0.249999114 curveto 50.650564840 -0.920673094 48.318952867 -0.920673094 47.541750072 -0.249999114 closepath))
    (("op47-tie-0208" . 120) 0.070000001 (moveto 48.160535889 -3.394976619 curveto 48.690222922 -3.717538046 50.279291197 -3.717538046 50.808981818 -3.394976619 curveto 50.279291197 -3.877541204 48.690222922 -3.877541204 48.160535889 -3.394976619 closepath))
    (("op47-tie-0209" . 120) 0.070000001 (moveto 48.160535889 -2.394973034 curveto 48.690222922 -2.717534461 50.279291197 -2.717534461 50.808981818 -2.394973034 curveto 50.279291197 -2.877537619 48.690222922 -2.877537619 48.160535889 -2.394973034 closepath))
    (("op47-tie-0210" . 120) 0.070000001 (moveto 112.439627861 0.249999090 curveto 113.039375936 2.235924432 115.734703874 2.235924432 116.931845876 0.249999090 curveto 115.734703874 2.075921274 113.039375936 2.075921274 112.439627861 0.249999090 closepath))
    (("op47-tie-0211" . 120) 0.070000001 (moveto 113.058410089 -2.894971238 curveto 113.709346543 -3.309681794 115.662141549 -3.309681794 116.313063648 -2.894971238 curveto 115.662141549 -3.469677774 113.709346543 -3.469677774 113.058410089 -2.894971238 closepath))
    (("op47-tie-0212" . 120) 0.070000001 (moveto 113.058410089 -1.394976626 curveto 113.472036876 -1.714975764 114.712888528 -1.714975764 115.126500960 -1.394976626 curveto 114.712888528 -1.874971744 113.472036876 -1.874971744 113.058410089 -1.394976626 closepath))
    (("op47-tie-0213" . 123) 0.070000001 (moveto 20.585913788 0.605037743 curveto 21.193072408 0.223593891 23.014553648 0.223593891 23.621712267 0.605037743 curveto 23.014553648 0.063583556 21.193072408 0.063583556 20.585913788 0.605037743 closepath))
    (("op47-tie-0214" . 123) 0.070000001 (moveto 21.772474681 1.500001799 curveto 22.379636889 2.041441632 24.201116336 2.041441632 24.808274955 1.500001799 curveto 24.201116336 1.881445652 22.379636889 1.881445652 21.772474681 1.500001799 closepath))
    (("op47-tie-0215" . 123) 0.070000001 (moveto 21.772474681 3.894974822 curveto 22.379636889 4.436414654 24.201116336 4.436414654 24.808274955 3.894974822 curveto 24.201116336 4.276404319 22.379636889 4.276404319 21.772474681 3.894974822 closepath))
    (("op47-tie-0216" . 123) 0.070000001 (moveto 35.777484371 0.500005392 curveto 36.732647884 -0.145921319 39.598124068 -0.145921319 40.553287581 0.500005392 curveto 39.598124068 -0.305917299 36.732647884 -0.305917299 35.777484371 0.500005392 closepath))
    (("op47-tie-0217" . 123) 0.070000001 (moveto 35.777484371 1.500001799 curveto 36.732647884 2.305924490 39.598124068 2.305924490 40.553287581 1.500001799 curveto 39.598124068 2.145928510 36.732647884 2.145928510 35.777484371 1.500001799 closepath))
    (("op47-tie-0218" . 123) 0.070000001 (moveto 35.777484371 3.394962263 curveto 36.732647884 4.200884954 39.598124068 4.200884954 40.553287581 3.394962263 curveto 39.598124068 4.040888974 36.732647884 4.040888974 35.777484371 3.394962263 closepath))
    (("op47-tie-0219" . 123) 0.070000001 (moveto 80.229089580 0.605037743 curveto 80.836244611 0.223593891 82.657731234 0.223593891 83.264886265 0.605037743 curveto 82.657731234 0.063583556 80.836244611 0.063583556 80.229089580 0.605037743 closepath))
    (("op47-tie-0220" . 123) 0.070000001 (moveto 81.415652268 1.500001799 curveto 82.022807298 2.041441632 83.844286744 2.041441632 84.451448952 1.500001799 curveto 83.844286744 1.881445652 82.022807298 1.881445652 81.415652268 1.500001799 closepath))
    (("op47-tie-0221" . 123) 0.070000001 (moveto 81.415652268 3.894974822 curveto 82.022807298 4.436414654 83.844286744 4.436414654 84.451448952 3.894974822 curveto 83.844286744 4.276404319 82.022807298 4.276404319 81.415652268 3.894974822 closepath))
    (("op47-tie-0222" . 123) 0.070000001 (moveto 95.420661957 0.500005392 curveto 96.375821881 -0.145921319 99.241308831 -0.145921319 100.196461578 0.500005392 curveto 99.241308831 -0.305917299 96.375821881 -0.305917299 95.420661957 0.500005392 closepath))
    (("op47-tie-0223" . 123) 0.070000001 (moveto 95.420661957 1.500001799 curveto 96.375821881 2.305924490 99.241308831 2.305924490 100.196461578 1.500001799 curveto 99.241308831 2.145928510 96.375821881 2.145928510 95.420661957 1.500001799 closepath))
    (("op47-tie-0224" . 123) 0.070000001 (moveto 95.420661957 3.394962263 curveto 96.375821881 4.200884954 99.241308831 4.200884954 100.196461578 3.394962263 curveto 99.241308831 4.040888974 96.375821881 4.040888974 95.420661957 3.394962263 closepath))
    (("op47-tie-0225" . 126) 0.070000032 (moveto 22.227746816 -1.394970949 curveto 22.842431091 -1.782131679 24.686491092 -1.782131679 25.301178955 -1.394970949 curveto 24.686491092 -1.942133114 22.842431091 -1.942133114 22.227746816 -1.394970949 closepath))
    (("op47-tie-0226" . 126) 0.070000032 (moveto 22.227746816 0.394968730 curveto 22.842431091 0.942129101 24.686491092 0.942129101 25.301178955 0.394968730 curveto 24.686491092 0.782129461 22.842431091 0.782129461 22.227746816 0.394968730 closepath))
    (("op47-tie-0227" . 126) 0.070000032 (moveto 22.227746816 1.499999777 curveto 22.842431091 2.047161942 24.686491092 2.047161942 25.301178955 1.499999777 curveto 24.686491092 1.887160508 22.842431091 1.887160508 22.227746816 1.499999777 closepath))
    (("op47-tie-0228" . 126) 0.070000032 (moveto 36.345654290 -0.500001109 curveto 37.232339747 -1.093882021 39.892399708 -1.093882021 40.779085165 -0.500001109 curveto 39.892399708 -1.253883456 37.232339747 -1.253883456 36.345654290 -0.500001109 closepath))
    (("op47-tie-0229" . 126) 0.070000032 (moveto 36.345654290 0.499999334 curveto 37.232339747 1.253881680 39.892399708 1.253881680 40.779085165 0.499999334 curveto 39.892399708 1.093880246 37.232339747 1.093880246 36.345654290 0.499999334 closepath))
    (("op47-tie-0230" . 126) 0.070000032 (moveto 36.345654290 2.394969616 curveto 37.232339747 3.148850168 39.892399708 3.148850168 40.779085165 2.394969616 curveto 39.892399708 2.988850528 37.232339747 2.988850528 36.345654290 2.394969616 closepath))
    (("op47-tie-0231" . 126) 0.070000032 (moveto 51.823560500 0.499999334 curveto 52.438251952 0.112838603 54.282311953 0.112838603 54.896996228 0.499999334 curveto 54.282311953 -0.047162832 52.438251952 -0.047162832 51.823560500 0.499999334 closepath))
    (("op47-tie-0232" . 126) 0.070000032 (moveto 51.823560500 1.499999777 curveto 52.438251952 2.047161942 54.282311953 2.047161942 54.896996228 1.499999777 curveto 54.282311953 1.887160508 52.438251952 1.887160508 51.823560500 1.499999777 closepath))
    (("op47-tie-0233" . 126) 0.070000032 (moveto 51.823560500 3.394970059 curveto 52.438251952 3.942130430 54.282311953 3.942130430 54.896996228 3.394970059 curveto 54.282311953 3.782130790 52.438251952 3.782130790 51.823560500 3.394970059 closepath))
    (("op47-tie-0234" . 273/2) 0.070000001 (moveto 125.065400717 3.394962260 curveto 125.757233326 4.000753606 127.832673734 4.000753606 128.524477633 3.394962260 curveto 127.832673734 3.840743272 125.757233326 3.840743272 125.065400717 3.394962260 closepath))
    (("op47-tie-0235" . 273/2) 0.070000001 (moveto 110.744526004 0.918082090 curveto 111.372739181 0.520632898 113.257393068 0.520632898 113.885620600 0.918082090 curveto 113.257393068 0.360636918 111.372739181 0.360636918 110.744526004 0.918082090 closepath))
    (("op47-tie-0234" . 279/2) 0.069999986 (moveto 9.461247815 3.394968270 curveto 9.976745251 3.874968669 11.523233970 3.874968669 12.038731407 3.394968270 curveto 11.523233970 3.714968237 9.976745251 3.714968237 9.461247815 3.394968270 closepath))
    (("op47-tie-0236" . 279/2) 0.069999986 (moveto 22.069903771 3.894968162 curveto 22.708304966 4.460153914 24.623512138 4.460153914 25.261913333 3.894968162 curveto 24.623512138 4.300154379 22.708304966 4.300154379 22.069903771 3.894968162 closepath))
    (("op47-tie-0237" . 279/2) 0.069999986 (moveto 35.293082109 3.394968270 curveto 36.382108886 4.302628747 39.649189217 4.302628747 40.738215994 3.394968270 curveto 39.649189217 4.142629212 36.382108886 4.142629212 35.293082109 3.394968270 closepath))
    (("op47-tie-0238" . 279/2) 0.069999986 (moveto 50.769384770 2.894968377 curveto 51.407789554 3.460154129 53.323003903 3.460154129 53.961401509 2.894968377 curveto 53.323003903 3.300154594 51.407789554 3.300154594 50.769384770 2.894968377 closepath))
    (("op47-tie-0239" . 279/2) 0.069999986 (moveto 55.238469458 2.894968377 curveto 57.973688152 4.274968403 66.179358590 4.274968403 68.914577285 2.894968377 curveto 66.179358590 4.114967971 57.973688152 4.114967971 55.238469458 2.894968377 closepath))
    (("op47-tie-0240" . 279/2) 0.069999986 (moveto 42.015280354 1.105031672 curveto 44.333412900 -0.114967922 51.287796183 -0.114967922 53.605932317 1.105031672 curveto 51.287796183 -0.274969251 44.333412900 -0.274969251 42.015280354 1.105031672 closepath))
    (("op47-tie-0241" . 279/2) 0.069999986 (moveto 114.266250765 -4.394967143 curveto 117.117884956 -5.614966736 125.672816238 -5.614966736 128.524450429 -4.394967143 curveto 125.672816238 -5.774968066 117.117884956 -5.774968066 114.266250765 -4.394967143 closepath))
    (("op47-tie-0242" . 279/2) 0.069999986 (moveto 114.266250765 -2.394967574 curveto 117.117884956 -3.614967167 125.672816238 -3.614967167 128.524450429 -2.394967574 curveto 125.672816238 -3.774966702 117.117884956 -3.774966702 114.266250765 -2.394967574 closepath))
    (("op47-tie-0243" . 279/2) 0.069999986 (moveto 114.266250765 0.894968808 curveto 117.117884956 2.274968834 125.672816238 2.274968834 128.524450429 0.894968808 curveto 125.672816238 2.114968402 117.117884956 2.114968402 114.266250765 0.894968808 closepath))
    (("op47-tie-0241" . 285/2) 0.070000001 (moveto 9.461249817 -4.394969421 curveto 9.805651715 -4.714968559 10.838860997 -4.714968559 11.183262895 -4.394969421 curveto 10.838860997 -4.874968127 9.805651715 -4.874968127 9.461249817 -4.394969421 closepath))
    (("op47-tie-0242" . 285/2) 0.070000001 (moveto 9.461249817 -2.394969429 curveto 9.805651715 -2.714968566 10.838860997 -2.714968566 11.183262895 -2.394969429 curveto 10.838860997 -2.874968135 9.805651715 -2.874968135 9.461249817 -2.394969429 closepath))
    (("op47-tie-0243" . 285/2) 0.070000001 (moveto 9.461249817 0.500001797 curveto 9.805651715 0.980000503 10.838860997 0.980000503 11.183262895 0.500001797 curveto 10.838860997 0.820000935 9.805651715 0.820000935 9.461249817 0.500001797 closepath))
    (("op47-tie-0244" . 285/2) 0.070000001 (moveto 23.152350294 -3.894967629 curveto 23.794530463 -4.303024845 25.721063792 -4.303024845 26.363240372 -3.894967629 curveto 25.721063792 -4.463024413 23.794530463 -4.463024413 23.152350294 -3.894967629 closepath))
    (("op47-tie-0245" . 285/2) 0.070000001 (moveto 23.152350294 -2.394969429 curveto 23.794530463 -2.803023056 25.721063792 -2.803023056 26.363240372 -2.394969429 curveto 25.721063792 -2.963022625 23.794530463 -2.963022625 23.152350294 -2.394969429 closepath))
    (("op47-tie-0246" . 285/2) 0.070000001 (moveto 23.152350294 0.394969446 curveto 23.794530463 0.963022642 25.721063792 0.963022642 26.363240372 0.394969446 curveto 25.721063792 0.803023073 23.794530463 0.803023073 23.152350294 0.394969446 closepath))
    (("op47-tie-0247" . 285/2) 0.070000001 (moveto 72.924137642 -3.750000878 curveto 74.369455716 -4.768446490 78.705431469 -4.768446490 80.150756720 -3.750000878 curveto 78.705431469 -4.928446059 74.369455716 -4.928446059 72.924137642 -3.750000878 closepath))
    (("op47-tie-0248" . 579/4) 0.070000001 (moveto 38.076059313 3.894967624 curveto 39.113621617 4.763512104 42.226304940 4.763512104 43.263863655 3.894967624 curveto 42.226304940 4.603516124 39.113621617 4.603516124 38.076059313 3.894967624 closepath))
    (("op47-tie-0249" . 579/4) 0.070000001 (moveto 24.589697995 1.605034130 curveto 25.170167890 1.243873278 26.911566807 1.243873278 27.492033113 1.605034130 curveto 26.911566807 1.083877298 25.170167890 1.083877298 24.589697995 1.605034130 closepath))
    (("op47-tie-0250" . 579/4) 0.070000001 (moveto 53.543687916 3.394969420 curveto 54.127574197 3.918724429 55.879225862 3.918724429 56.463104966 3.394969420 curveto 55.879225862 3.758721272 54.127574197 3.758721272 53.543687916 3.394969420 closepath))
    (("op47-tie-0251" . 579/4) 0.070000001 (moveto 53.543687916 4.394965828 curveto 54.127574197 4.918720837 55.879225862 4.918720837 56.463104966 4.394965828 curveto 55.879225862 4.758717679 54.127574197 4.758717679 53.543687916 4.394965828 closepath))
    (("op47-tie-0252" . 579/4) 0.070000001 (moveto 67.098394905 2.894971217 curveto 68.068282613 3.712083290 70.977938559 3.712083290 71.947826267 2.894971217 curveto 70.977938559 3.552080133 68.068282613 3.552080133 67.098394905 2.894971217 closepath))
    (("op47-tie-0253" . 579/4) 0.070000001 (moveto 67.098394905 3.894967624 curveto 68.068282613 4.712079698 70.977938559 4.712079698 71.947826267 3.894967624 curveto 70.977938559 4.552083718 68.068282613 4.552083718 67.098394905 3.894967624 closepath))
    (("op47-tie-0254" . 579/4) 0.070000001 (moveto 82.583116206 3.394969420 curveto 83.238093470 3.972755011 85.203032437 3.972755011 85.858002524 3.394969420 curveto 85.203032437 3.812751854 83.238093470 3.812751854 82.583116206 3.394969420 closepath))
    (("op47-tie-0255" . 579/4) 0.070000001 (moveto 87.135070742 3.394969420 curveto 89.936600928 4.774967047 98.341191486 4.774967047 101.142721672 3.394969420 curveto 98.341191486 4.614971067 89.936600928 4.614971067 87.135070742 3.394969420 closepath))
    (("op47-tie-0256" . 591/4) 0.070000001 (moveto 35.710107632 -3.894967624 curveto 39.623255322 -5.114969270 51.362698392 -5.114969270 55.275846082 -3.894967624 curveto 51.362698392 -5.274972427 39.623255322 -5.274972427 35.710107632 -3.894967624 closepath))
    (("op47-tie-0257" . 591/4) 0.070000001 (moveto 35.710107632 -1.894967631 curveto 39.623255322 -3.114969278 51.362698392 -3.114969278 55.275846082 -1.894967631 curveto 51.362698392 -3.274965258 39.623255322 -3.274965258 35.710107632 -1.894967631 closepath))
    (("op47-tie-0258" . 591/4) 0.070000001 (moveto 35.710107632 1.394969447 curveto 39.623255322 2.774967073 51.362698392 2.774967073 55.275846082 1.394969447 curveto 51.362698392 2.614971093 39.623255322 2.614971093 35.710107632 1.394969447 closepath))
    (("op47-tie-0259" . 591/4) 0.070000001 (moveto 67.249692019 -3.394969420 curveto 67.957314649 -3.852765203 70.080189717 -3.852765203 70.787812347 -3.394969420 curveto 70.080189717 -4.012761183 67.957314649 -4.012761183 67.249692019 -3.394969420 closepath))
    (("op47-tie-0260" . 591/4) 0.070000001 (moveto 67.249692019 -1.500001779 curveto 67.957314649 -1.957790385 70.080189717 -1.957790385 70.787812347 -1.500001779 curveto 70.080189717 -2.117793542 67.957314649 -2.117793542 67.249692019 -1.500001779 closepath))
    (("op47-tie-0261" . 591/4) 0.070000001 (moveto 67.249692019 0.499998214 curveto 67.957314649 1.117797154 70.080189717 1.117797154 70.787812347 0.499998214 curveto 70.080189717 0.957793997 67.957314649 0.957793997 67.249692019 0.499998214 closepath))
    (("op47-tie-0262" . 591/4) 0.070000001 (moveto 122.495804413 -3.250002669 curveto 123.701544799 -4.086357037 127.318737247 -4.086357037 128.524477633 -3.250002669 curveto 127.318737247 -4.246360195 123.701544799 -4.246360195 122.495804413 -3.250002669 closepath))
    (("op47-tie-0262" . 150) 0.070000001 (moveto 9.377812115 -3.249995501 curveto 9.945971175 -3.601797177 11.650450152 -3.601797177 12.218609213 -3.249995501 curveto 11.650450152 -3.761807511 9.945971175 -3.761807511 9.377812115 -3.249995501 closepath))
    (("op47-tie-0263" . 150) 0.070000001 (moveto 45.692300756 -3.394962251 curveto 47.333389975 -4.562189340 52.256650452 -4.562189340 53.897743258 -3.394962251 curveto 52.256650452 -4.722199674 47.333389975 -4.722199674 45.692300756 -3.394962251 closepath))
    (("op47-tie-0264" . 150) 0.070000001 (moveto 66.305857847 -3.894974810 curveto 67.146769789 -4.454056402 69.669476907 -4.454056402 70.510381672 -3.894974810 curveto 69.669476907 -4.614052383 67.146769789 -4.614052383 66.305857847 -3.894974810 closepath))
    (("op47-tie-0265" . 150) 0.070000001 (moveto 66.305857847 -2.499998195 curveto 67.146769789 -1.780906267 69.669476907 -1.780906267 70.510381672 -2.499998195 curveto 69.669476907 -1.940916602 67.146769789 -1.940916602 66.305857847 -2.499998195 closepath))
    (("op47-tie-0266" . 150) 0.070000001 (moveto 105.871574688 -2.605030546 curveto 106.743435073 -1.862411487 109.359037757 -1.862411487 110.230898141 -2.605030546 curveto 109.359037757 -2.022407467 106.743435073 -2.022407467 105.871574688 -2.605030546 closepath))
    (("op47-tie-0267" . 609/4) 0.069999986 (moveto 38.990548090 -2.105030545 curveto 40.037067421 -1.229676804 43.176621825 -1.229676804 44.223137567 -2.105030545 curveto 43.176621825 -1.389676339 40.037067421 -1.389676339 38.990548090 -2.105030545 closepath))
    (("op47-tie-0268" . 609/4) 0.069999986 (moveto 38.990548090 -0.605030868 curveto 40.037067421 0.270322873 43.176621825 0.270322873 44.223137567 -0.605030868 curveto 43.176621825 0.110323338 40.037067421 0.110323338 38.990548090 -0.605030868 closepath))
    (("op47-tie-0269" . 609/4) 0.069999986 (moveto 38.990548090 1.394968701 curveto 40.037067421 2.270322442 43.176621825 2.270322442 44.223137567 1.394968701 curveto 43.176621825 2.110322010 40.037067421 2.110322010 38.990548090 1.394968701 closepath))
    (("op47-tie-0270" . 609/4) 0.070000032 (moveto 38.990573766 0.894968951 curveto 40.108188389 1.824353875 43.461028669 1.824353875 44.578639704 0.894968951 curveto 43.461028669 1.664354235 40.108188389 1.664354235 38.990573766 0.894968951 closepath))
    (("op47-tie-0271" . 609/4) 0.069999986 (moveto 54.882325601 -2.499998109 curveto 55.454405131 -1.985216606 57.170658076 -1.985216606 57.742737607 -2.499998109 curveto 57.170658076 -2.145217935 55.454405131 -2.145217935 54.882325601 -2.499998109 closepath))
    (("op47-tie-0272" . 609/4) 0.069999986 (moveto 54.882325601 -0.605030868 curveto 55.454405131 -0.090249366 57.170658076 -0.090249366 57.742737607 -0.605030868 curveto 57.170658076 -0.250248901 55.454405131 -0.250248901 54.882325601 -0.605030868 closepath))
    (("op47-tie-0273" . 609/4) 0.069999986 (moveto 54.882325601 0.500001245 curveto 55.454405131 1.014782747 57.170658076 1.014782747 57.742737607 0.500001245 curveto 57.170658076 0.854782315 55.454405131 0.854782315 54.882325601 0.500001245 closepath))
    (("op47-tie-0274" . 609/4) 0.069999986 (moveto 68.200983307 -2.105030545 curveto 69.159064182 -1.296888451 72.033306808 -1.296888451 72.991387683 -2.105030545 curveto 72.033306808 -1.456887986 69.159064182 -1.456887986 68.200983307 -2.105030545 closepath))
    (("op47-tie-0275" . 609/4) 0.069999986 (moveto 68.200983307 -0.605030868 curveto 69.159064182 0.203111226 72.033306808 0.203111226 72.991387683 -0.605030868 curveto 72.033306808 0.043111691 69.159064182 0.043111691 68.200983307 -0.605030868 closepath))
    (("op47-tie-0276" . 609/4) 0.069999986 (moveto 68.200983307 0.394968916 curveto 69.159064182 1.203111010 72.033306808 1.203111010 72.991387683 0.394968916 curveto 72.033306808 1.043111475 69.159064182 1.043111475 68.200983307 0.394968916 closepath))
    (("op47-tie-0277" . 609/4) 0.069999986 (moveto 60.991835260 -2.394967574 curveto 63.715060719 -3.614967167 71.884729916 -3.614967167 74.607955374 -2.394967574 curveto 71.884729916 -3.774966702 63.715060719 -3.774966702 60.991835260 -2.394967574 closepath))
    (("op47-tie-0278" . 609/4) 0.069999986 (moveto 83.318497284 -3.371695025 curveto 84.194800220 -4.837224016 85.830660442 -4.421033233 86.410017735 -3.590743844 curveto 85.819356224 -4.580632634 84.183488825 -4.996823417 83.318497284 -3.371695025 closepath))
    (("op47-tie-0279" . 609/4) 0.069999986 (moveto 76.240492514 -2.394967574 curveto 78.668681486 -1.534018636 84.638966250 -1.534018636 86.190974298 -2.394967574 curveto 84.638966250 -1.694018170 78.668681486 -1.694018170 76.240492514 -2.394967574 closepath))
    (("op47-tie-0280" . 609/4) 0.069999986 (moveto 111.304674984 -2.499998109 curveto 111.858603171 -1.999013134 113.520387732 -1.999013134 114.074315918 -2.499998109 curveto 113.520387732 -2.159014464 111.858603171 -2.159014464 111.304674984 -2.499998109 closepath))
    (("op47-tie-0281" . 609/4) 0.069999986 (moveto 120.109031133 -1.605030653 curveto 121.265204962 -0.646339709 124.733726448 -0.646339709 125.889900277 -1.605030653 curveto 124.733726448 -0.806339244 121.265204962 -0.806339244 120.109031133 -1.605030653 closepath))
    (("op47-tie-0282" . 621/4) 0.070000001 (moveto 59.757247932 -2.894967646 curveto 61.624539972 -4.114969292 67.226401738 -4.114969292 69.093686600 -2.894967646 curveto 67.226401738 -4.274968861 61.624539972 -4.274968861 59.757247932 -2.894967646 closepath))
    (("op47-tie-0283" . 621/4) 0.070000001 (moveto 59.757247932 0.105032342 curveto 61.624539972 -1.114969304 67.226401738 -1.114969304 69.093686600 0.105032342 curveto 67.226401738 -1.274968872 61.624539972 -1.274968872 59.757247932 0.105032342 closepath))
    (("op47-tie-0284" . 621/4) 0.070000001 (moveto 60.943810619 1.394969429 curveto 62.811095482 2.774967055 68.412957248 2.774967055 70.280249288 1.394969429 curveto 68.412957248 2.614967486 62.811095482 2.614967486 60.943810619 1.394969429 closepath))
    (("op47-tie-0285" . 159) 0.070000001 (moveto 94.015271106 2.894971218 curveto 97.580916312 1.099968767 107.219518571 1.099968767 110.079608205 2.894971218 curveto 107.219518571 0.939965609 97.580916312 0.939965609 94.015271106 2.894971218 closepath))
    (("op47-tie-0286" . 327/2) 0.069999986 (moveto 14.282986405 2.894968377 curveto 16.848620306 1.805528907 24.016357236 1.805528907 26.229213425 2.894968377 curveto 24.016357236 1.645528475 16.848620306 1.645528475 14.282986405 2.894968377 closepath))
    (("op47-tie-0287" . 327/2) 0.069999986 (moveto 72.881259485 2.894968377 curveto 75.446886209 1.805528907 82.614628521 1.805528907 84.827484710 2.894968377 curveto 82.614628521 1.645528475 75.446886209 1.645528475 72.881259485 2.894968377 closepath))
    (("op47-tie-0288" . 687/4) 0.070000001 (moveto 51.362479485 4.749997297 curveto 54.890670043 6.130002100 65.475216596 6.130002100 69.003403565 4.749997297 curveto 65.475216596 5.969998943 54.890670043 5.969998943 51.362479485 4.749997297 closepath))
    (("op47-tie-0289" . 687/4) 0.070000001 (moveto 108.700392902 0.105025184 curveto 109.831712046 -0.674786553 113.225712543 -0.674786553 114.357038865 0.105025184 curveto 113.225712543 -0.834782533 109.831712046 -0.834782533 108.700392902 0.105025184 closepath))
    (("op47-tie-0290" . 174) 0.070000001 (moveto 16.574954093 4.750004465 curveto 19.255615254 6.129994914 27.297600532 6.129994914 29.978258104 4.750004465 curveto 27.297600532 5.969998934 19.255615254 5.969998934 16.574954093 4.750004465 closepath))
    (("op47-tie-0291" . 174) 0.070000001 (moveto 59.404462968 -0.071191459 curveto 60.051502157 -0.482937798 61.992612547 -0.482937798 62.639644559 -0.071191459 curveto 61.992612547 -0.642933778 60.051502157 -0.642933778 59.404462968 -0.071191459 closepath))
   ))
% Generic native Tie/Slur source-contour callbacks; stable own-staff reference.
#(define (op47-source-curve-stencil grob)
  (let* ((attrs (ly:grob-property grob 'output-attributes '()))
         (sid (assoc-ref attrs 'data-sid))
         (system (ly:grob-system grob)))
    (if (and sid (ly:grob? system))
      (let* ((ca (ly:grob-object system 'columns))
             (columns (if (ly:grob-array? ca) (ly:grob-array->list ca) '()))
             (moment (and (pair? columns) (ly:grob-property (car columns) 'when)))
             (start (and (ly:moment? moment) (ly:moment-main moment)))
             (entry (and start (assoc (cons sid start) op47-source-curve-contours))))
        (if entry
          (let ((staff (ly:grob-object grob 'staff-symbol)))
            (if (ly:grob? staff)
              (begin
                (concerto-place-columns system)
                (let* ((space (ly:staff-symbol-staff-space staff))
                       (left (ly:spanner-bound staff LEFT))
                       (origin-x (ly:grob-relative-coordinate left system X))
                       (now-x (ly:grob-relative-coordinate grob system X))
                       (common-y (ly:grob-common-refpoint staff grob Y))
                       (origin-y (- (ly:grob-relative-coordinate staff common-y Y)
                                    (ly:grob-relative-coordinate grob common-y Y)))
                       (stencil (make-path-stencil (caddr entry) (cadr entry) 1 1 #t)))
                  (ly:stencil-translate (ly:stencil-scale stencil space space)
                    (cons (- origin-x now-x) origin-y))))
              (begin (ly:warning "Source curve has no staff-symbol: ~a" sid) #f)))
          #f))
      #f)))
#(define (opFortySevenSourceCurveAfterLineBreaking grob)
  (let ((replacement (op47-source-curve-stencil grob)))
    (if (ly:stencil? replacement)
      (begin
        (ly:grob-set-property! grob 'stencil replacement)
        (concerto-audit-wrap-pdf-stencil! grob)))))
#(define (op47-prepare-source-curve! grob)
  (let* ((attrs (ly:grob-property grob 'output-attributes '()))
         (sid (assoc-ref attrs 'data-sid)))
    (if (and sid (find (lambda (entry) (equal? sid (caar entry))) op47-source-curve-contours))
      (begin
        (ly:grob-set-property! grob 'X-extent '(+inf.0 . -inf.0))
        (ly:grob-set-property! grob 'Y-extent '(+inf.0 . -inf.0))
        (ly:grob-set-property! grob 'after-line-breaking opFortySevenSourceCurveAfterLineBreaking)))))
#(define opFortySevenSourceCurvesEngraver
  (lambda (context)
    (let ((pending '()))
      (make-engraver
        (acknowledgers
          ((slur-interface engraver grob source) (set! pending (cons grob pending)))
          ((tie-interface engraver grob source) (set! pending (cons grob pending))))
        ((stop-translation-timestep engraver)
          (for-each op47-prepare-source-curve! pending)
          (set! pending '()))))))

% Optional semantic labels in a diagnostic PDF. No glyph/path/extents change.
% Add this definition BEFORE concerto-audit-engraver, then call
%   (concerto-audit-wrap-pdf-stencil! grob)
% AFTER its existing output-attributes assignment in the acknowledger.
% Default compilation adds no links. Register and enable the diagnostic option:
% lilypond -e '(ly:add-option (quote audit-links) #t "Enable score audit links.")' FILE.ly
#(define (concerto-audit-wrap-pdf-stencil! grob)
   (if (ly:get-option 'audit-links)
       (let ((original-stencil (ly:grob-property-data grob 'stencil)))
         (if (or (procedure? original-stencil) (ly:stencil? original-stencil))
             (ly:grob-set-property!
               grob 'stencil
               (lambda (g)
                 (let ((stencil (if (procedure? original-stencil)
                                    (original-stencil g)
                                    original-stencil)))
                   (if (and (ly:stencil? stencil)
                            (not (ly:stencil-empty? stencil)))
                       (let* ((attrs (ly:grob-property g 'output-attributes '()))
                              (id (assoc-get 'id attrs "unknown"))
                              (kind (assoc-get 'data-grob attrs "Unknown"))
                              (bar (assoc-get 'data-bar attrs "0"))
                              (sid (assoc-get 'data-sid attrs ""))
                              (did (assoc-get 'data-did attrs ""))
                              (role (assoc-get 'data-role attrs ""))
                              (nid (assoc-get 'data-nid attrs ""))
                              (voice (assoc-get 'data-voice attrs ""))
                              (stem (ly:grob-object g 'stem #f))
                              (beam (ly:grob-object g 'beam #f))
                              (stem-id (if (ly:grob? stem)
                                           (assoc-get 'id (ly:grob-property stem 'output-attributes '()) "") ""))
                              (beam-id (if (ly:grob? beam)
                                           (assoc-get 'id (ly:grob-property beam 'output-attributes '()) "") ""))
                              (cause (ly:grob-property g 'cause))
                              (origin (and (ly:stream-event? cause)
                                           (ly:event-property cause 'origin #f)))
                              (location (and (ly:input-location? origin)
                                             (ly:input-file-line-char-column origin)))
                              (line (if (and (list? location) (> (length location) 1))
                                        (list-ref location 1) 0))
                              (col (if (and (list? location) (> (length location) 3))
                                       (list-ref location 3) 0))
                              (url (format #f
                                     "ink-audit://~a/~a/~a/~a/~a?sid=~a&did=~a&role=~a&stem=~a&beam=~a&nid=~a&voice=~a"
                                     id kind bar line col sid did role stem-id beam-id nid voice))
                              (xx (ly:stencil-extent stencil X))
                              (yy (ly:stencil-extent stencil Y))
                              (link (ly:make-stencil `(url-link ,url ,xx ,yy) xx yy)))
                         (ly:stencil-add link stencil))
                       stencil))))))))

% Op.47 native Tie guides for source cross-voice / noncontiguous ties.
% All original note/rest music remains in the five source voices.
% Guide heads have no source NID and produce no visible ink.

opFortySevenCrossTieOneA = \absolute {
  \autoBeamOff
  \hideNotes
  \override NoteColumn.ignore-collision = ##t
  \override NoteColumn.force-hshift = #0
  \override NoteHead.no-ledgers = ##t
  \override Stem.stencil = ##f
  \override Flag.stencil = ##f
  \override Beam.stencil = ##f
  \override Dots.stencil = ##f
  \override Accidental.stencil = ##f
  s1*247/8
  % op47-tie-0030: n1-327 -> n2-60
  ees'1*1/4 \tweak output-attributes #'((data-sid . "op47-tie-0030")) ~
  ees'1*0
  s1*1/2
  % op47-tie-0033: n1-331 -> n2-67
  ges'1*1/4 \tweak output-attributes #'((data-sid . "op47-tie-0033")) ~
  ges'1*0
  s1*1/2
  % op47-tie-0035: n1-335 -> n2-74
  aes'1*1/4 \tweak output-attributes #'((data-sid . "op47-tie-0035")) ~
  aes'1*0
  s1*969/8
  % op47-tie-0279: n2-197 -> n1-1813
  ees'1*3/8 \tweak output-attributes #'((data-sid . "op47-tie-0279")) ~
  ees'1*0
  s1*51/8
  % op47-tie-0285: n1-1936 -> n2-216
  g'''1*3/8 \tweak output-attributes #'((data-sid . "op47-tie-0285")) ~
  g'''1*0
  s1*21/8
  % op47-tie-0286: n1-1973 -> n2-243
  g''1*3/8 \tweak output-attributes #'((data-sid . "op47-tie-0286")) ~
  g''1*0
  s1*9/8
  % op47-tie-0287: n1-1986 -> n2-262
  g''1*3/8 \tweak output-attributes #'((data-sid . "op47-tie-0287")) ~
  g''1*0
  s1*123/8
}

opFortySevenCrossTieTwoA = \absolute {
  \autoBeamOff
  \hideNotes
  \override NoteColumn.ignore-collision = ##t
  \override NoteColumn.force-hshift = #0
  \override NoteHead.no-ledgers = ##t
  \override Stem.stencil = ##f
  \override Flag.stencil = ##f
  \override Beam.stencil = ##f
  \override Dots.stencil = ##f
  \override Accidental.stencil = ##f
  s1*169/4
  % op47-tie-0055: n5-376 -> n6-15
  g1*1/8 \tweak output-attributes #'((data-sid . "op47-tie-0055")) ~
  g1*0
  s1*1/4
  % op47-tie-0057: n6-17 -> n5-379
  g1*1/8 \tweak output-attributes #'((data-sid . "op47-tie-0057")) ~
  g1*0
  s1*5/2
  % op47-tie-0062: n5-402 -> n6-19
  g1*1/8 \tweak output-attributes #'((data-sid . "op47-tie-0062")) ~
  g1*0
  s1*1/4
  % op47-tie-0065: n6-21 -> n5-405
  g1*1/8 \tweak output-attributes #'((data-sid . "op47-tie-0065")) ~
  g1*0
  s1*1/4
  % op47-tie-0069: n5-407 -> n6-23
  g1*1/8 \tweak output-attributes #'((data-sid . "op47-tie-0069")) ~
  g1*0
  s1*1/4
  % op47-tie-0072: n6-25 -> n5-410
  g1*1/8 \tweak output-attributes #'((data-sid . "op47-tie-0072")) ~
  g1*0
  s1*87/4
  % op47-tie-0121: n5-653 -> n5-655
  g,,1*1/4 \tweak output-attributes #'((data-sid . "op47-tie-0121")) ~
  g,,1*0
  s1*2
  % op47-tie-0133: n5-673 -> n6-39
  c,1*3/8 \tweak output-attributes #'((data-sid . "op47-tie-0133")) ~
  c,1*0
  s1*77/8
  % op47-tie-0142: n5-753 -> n6-48
  g1*1/8 \tweak output-attributes #'((data-sid . "op47-tie-0142")) ~
  g1*0
  s1*1/4
  % op47-tie-0144: n6-50 -> n5-756
  g1*1/8 \tweak output-attributes #'((data-sid . "op47-tie-0144")) ~
  g1*0
  s1*5/2
  % op47-tie-0149: n5-776 -> n6-52
  g1*1/8 \tweak output-attributes #'((data-sid . "op47-tie-0149")) ~
  g1*0
  s1*1/4
  % op47-tie-0151: n6-54 -> n5-779
  g1*1/8 \tweak output-attributes #'((data-sid . "op47-tie-0151")) ~
  g1*0
  s1*1/4
  % op47-tie-0155: n5-781 -> n6-56
  g1*1/8 \tweak output-attributes #'((data-sid . "op47-tie-0155")) ~
  g1*0
  s1*1/4
  % op47-tie-0157: n6-58 -> n5-784
  g1*1/8 \tweak output-attributes #'((data-sid . "op47-tie-0157")) ~
  g1*0
  s1*5/2
  % op47-tie-0161: n5-805 -> n6-60
  ees1*1/8 \tweak output-attributes #'((data-sid . "op47-tie-0161")) ~
  ees1*0
  s1*23/8
  % op47-tie-0164: n5-829 -> n6-61
  bes,1*1/8 \tweak output-attributes #'((data-sid . "op47-tie-0164")) ~
  bes,1*0
  s1*167/8
  % op47-tie-0178: n5-1042 -> n6-79
  ees1*1/8 \tweak output-attributes #'((data-sid . "op47-tie-0178")) ~
  ees1*0
  s1*1/4
  % op47-tie-0180: n6-81 -> n5-1045
  ees1*1/8 \tweak output-attributes #'((data-sid . "op47-tie-0180")) ~
  ees1*0
  s1*5/2
  % op47-tie-0185: n5-1065 -> n6-83
  ees1*1/8 \tweak output-attributes #'((data-sid . "op47-tie-0185")) ~
  ees1*0
  s1*1/4
  % op47-tie-0187: n6-85 -> n5-1068
  ees1*1/8 \tweak output-attributes #'((data-sid . "op47-tie-0187")) ~
  ees1*0
  s1*1/4
  % op47-tie-0191: n5-1070 -> n6-87
  ees1*1/8 \tweak output-attributes #'((data-sid . "op47-tie-0191")) ~
  ees1*0
  s1*525/8
}

opFortySevenCrossTieTwoB = \absolute {
  \autoBeamOff
  \hideNotes
  \override NoteColumn.ignore-collision = ##t
  \override NoteColumn.force-hshift = #0
  \override NoteHead.no-ledgers = ##t
  \override Stem.stencil = ##f
  \override Flag.stencil = ##f
  \override Beam.stencil = ##f
  \override Dots.stencil = ##f
  \override Accidental.stencil = ##f
  s1*363/8
  % op47-tie-0064: n6-19 -> n6-21
  g1*1/4 \tweak output-attributes #'((data-sid . "op47-tie-0064")) ~
  g1*0
  s1*1/2
  % op47-tie-0071: n6-23 -> n6-25
  g1*1/4 \tweak output-attributes #'((data-sid . "op47-tie-0071")) ~
  g1*0
  s1*175/8
  % op47-tie-0122: n5-654 -> n5-656
  g,1*1/4 \tweak output-attributes #'((data-sid . "op47-tie-0122")) ~
  g,1*0
  s1*449/4
}


\layout {
  \context {
    \Score
    autoBeaming = ##f
    \override TrillSpanner.cross-staff = #ly:side-position-interface::calc-cross-staff
    \override TrillSpanner.stencil = ##f
    \override TrillSpanner.Y-extent = #'(+inf.0 . -inf.0)
    \omit BarNumber
    \consists #concerto-audit-engraver
    \override System.after-line-breaking = #opFortySevenSystemWithSourceBarKeys
  }
  \context {
    \Staff
    \consists #opFortySevenSourceClefPositionsEngraver
    printKeyCancellation = ##f
    \remove Piano_pedal_engraver
    \remove Piano_pedal_align_engraver
    \override StaffSymbol.thickness = #(op47-source-rule-thickness 0.08)
    \override StaffSymbol.ledger-line-thickness = #'(0 . 0.16)
    \override BarLine.hair-thickness = #1.6
    \override BarLine.thick-thickness = #5.0
    \override SpanBar.hair-thickness = #1.6
    \override SpanBar.thick-thickness = #5.0
    \override RestCollision.positioning-done = #concerto-visible-rest-positioning
    \override TimeSignature.break-visibility = #end-of-line-invisible
    pedalSustainStyle = #'text
    \override SustainPedal.stencil = ##f
    \override PianoPedalBracket.stencil = ##f
    \override OttavaBracket.stencil = ##f
    \override OttavaBracket.Y-extent = #'(+inf.0 . -inf.0)
  }
  \context {
    \PianoStaff
    \override StaffGrouper.staff-staff-spacing = #'((basic-distance . 13) (minimum-distance . 10) (padding . 1) (stretchability . 0))
  }
  \context {
    \Voice
    \consists #opFortySevenSourceCurvesEngraver
    \omit TupletNumber
    \omit TupletBracket
    \override Beam.beam-thickness = #0.5
    % Stem.thickness is relative to the actual staff-line thickness (0.08ss).
    \override Stem.thickness = #1.625
    \override Dots.after-line-breaking = #op47-position-source-dots
    \override Script.stencil = #concerto-script-with-source-trills
    \override Slur.details.accidental-collision = #1000
    \override Slur.details.extra-object-collision-penalty = #1000
    \override Slur.details.stem-encompass-penalty = #1000
    \override Slur.details.head-encompass-penalty = #10000
    \override Slur.details.free-head-distance = #0.5
    \override Slur.details.region-size = #6
  }
}

lockedLayout = {
  \autoLineBreaksOff \autoPageBreaksOff \time 6/8
  % Source p1, system 1, mm. 1-6
  \refSystem #14.666669641 #12.500000026
  s1*3/4 % source m1
  s1*3/4 % source m2
  s1*3/4 % source m3
  s1*3/4 % source m4
  s1*3/4 % source m5
  s1*3/4 \break % source m6
  % Source p1, system 2, mm. 7-11
  \refSystem #43.392996752 #12.499998216
  s1*3/4 % source m7
  s1*3/4 % source m8
  s1*3/4 % source m9
  s1*3/4 % source m10
  s1*3/4 \break % source m11
  % Source p1, system 3, mm. 12-16
  \refSystem #74.834861073 #12.499998239
  s1*3/4 % source m12
  s1*3/4 % source m13
  s1*3/4 % source m14
  s1*3/4 % source m15
  s1*3/4 \break % source m16
  % Source p1, system 4, mm. 17-21
  \refSystem #106.276414097 #12.499998239
  s1*3/4 % source m17
  s1*3/4 % source m18
  s1*3/4 % source m19
  s1*3/4 % source m20
  s1*3/4 \break % source m21
  % Source p1, system 5, mm. 22-26
  \refSystem #136.918737918 #12.499998239
  s1*3/4 % source m22
  s1*3/4 % source m23
  s1*3/4 % source m24
  s1*3/4 % source m25
  s1*3/4 \pageBreak % source m26
  % Source p2, system 1, mm. 27-31
  \refSystem #0.951443559 #12.499998127
  s1*3/4 % source m27
  s1*3/4 % source m28
  s1*3/4 % source m29
  s1*3/4 % source m30
  s1*3/4 \break % source m31
  % Source p2, system 2, mm. 32-35
  \refSystem #33.951466073 #13.759446224
  s1*3/4 % source m32
  s1*3/4 % source m33
  s1*3/4 % source m34
  s1*3/4 \break % source m35
  % Source p2, system 3, mm. 36-41
  \refSystem #68.925996762 #12.499998239
  s1*3/4 % source m36
  s1*3/4 % source m37
  s1*3/4 % source m38
  s1*3/4 % source m39
  s1*3/4 % source m40
  s1*3/4 \break % source m41
  % Source p2, system 4, mm. 42-47
  \refSystem #98.710889390 #13.076319670
  s1*3/4 % source m42
  s1*3/4 % source m43
  s1*3/4 % source m44
  s1*3/4 % source m45
  s1*3/4 % source m46
  s1*3/4 \break % source m47
  % Source p2, system 5, mm. 48-55
  \refSystem #129.133068776 #12.499983893
  s1*3/4 % source m48
  s1*3/4 % source m49
  s1*3/4 % source m50
  s1*3/4 % source m51
  s1*3/4 % source m52
  s1*3/4 % source m53
  s1*3/4 % source m54
  s1*3/4 \pageBreak % source m55
  % Source p3, system 1, mm. 56-60
  \refSystem #4.100102959 #12.499998127
  s1*3/4 % source m56
  s1*3/4 % source m57
  s1*3/4 % source m58
  s1*3/4 % source m59
  s1*3/4 \break % source m60
  % Source p3, system 2, mm. 61-65
  \refSystem #35.499973373 #13.209393638
  s1*3/4 % source m61
  s1*3/4 % source m62
  s1*3/4 % source m63
  s1*3/4 % source m64
  s1*3/4 % source m65
  % Source p3, system 3, mm. 66-70
  \grace { \break \refSystem #67.809340776 #12.500005412 s1*1/8 }
  s1*3/4 % source m66
  s1*3/4 % source m67
  s1*3/4 % source m68
  s1*3/4 % source m69
  s1*3/4 \break % source m70
  % Source p3, system 4, mm. 71-75
  \refSystem #99.809356631 #12.500005389
  s1*3/4 % source m71
  s1*3/4 % source m72
  s1*3/4 % source m73
  s1*3/4 % source m74
  s1*3/4 \break % source m75
  % Source p3, system 5, mm. 76-80
  \refSystem #130.684599082 #12.499998239
  s1*3/4 % source m76
  s1*3/4 % source m77
  s1*3/4 % source m78
  s1*3/4 % source m79
  s1*3/4 \pageBreak % source m80
  % Source p4, system 1, mm. 81-85
  \refSystem #0.600078259 #12.499998127
  s1*3/4 % source m81
  s1*3/4 % source m82
  s1*3/4 % source m83
  s1*3/4 % source m84
  s1*3/4 \break % source m85
  % Source p4, system 2, mm. 86-90
  \refSystem #32.100083273 #15.446484406
  s1*3/4 % source m86
  s1*3/4 % source m87
  s1*3/4 % source m88
  s1*3/4 % source m89
  s1*3/4 \break % source m90
  % Source p4, system 3, mm. 91-95
  \refSystem #67.196594919 #12.499998216
  s1*3/4 % source m91
  s1*3/4 % source m92
  s1*3/4 % source m93
  s1*3/4 % source m94
  s1*3/4 \break % source m95
  % Source p4, system 4, mm. 96-100
  \refSystem #100.397810601 #12.736324597
  s1*3/4 % source m96
  s1*3/4 % source m97
  s1*3/4 % source m98
  s1*3/4 % source m99
  s1*3/4 % source m100
  % Source p4, system 5, mm. 101-105
  \grace { \break \refSystem #133.634157861 #12.564995689 s1*1/8 }
  s1*3/4 % source m101
  s1*3/4 % source m102
  s1*3/4 % source m103
  s1*3/4 % source m104
  s1*3/4 \pageBreak % source m105
  % Source p5, system 1, mm. 106-110
  \refSystem #4.100102959 #12.499998127
  s1*3/4 % source m106
  s1*3/4 % source m107
  s1*3/4 % source m108
  s1*3/4 % source m109
  s1*3/4 \break % source m110
  % Source p5, system 2, mm. 111-115
  \refSystem #36.249973473 #12.500005412
  s1*3/4 % source m111
  s1*3/4 % source m112
  s1*3/4 % source m113
  s1*3/4 % source m114
  s1*3/4 % source m115
  % Source p5, system 3, mm. 116-119
  \grace { \break \refSystem #64.971951527 #12.499998239 s1*3/8 }
  s1*3/4 % source m116
  s1*3/4 % source m117
  s1*3/4 % source m118
  s1*3/4 % source m119
  % Source p5, system 4, mm. 120-123
  \grace { \break \refSystem #95.680327982 #12.500005412 s1*1/4 }
  s1*3/4 % source m120
  s1*3/4 % source m121
  s1*3/4 % source m122
  s1*3/4 \break % source m123
  % Source p5, system 5, mm. 124-127
  \refSystem #130.451343133 #14.009423812
  s1*3/4 % source m124
  s1*3/4 % source m125
  s1*3/4 % source m126
  s1*3/4 \pageBreak % source m127
  % Source p6, system 1, mm. 128-130
  \refSystem #4.451476859 #12.826971723
  s1*3/4 % source m128
  s1*3/4 % source m129
  s1*3/4 \break % source m130
  % Source p6, system 2, mm. 131-134
  \refSystem #33.978901930 #12.500001814
  s1*3/4 % source m131
  s1*3/4 % source m132
  s1*3/4 % source m133
  s1*3/4 \break % source m134
  % Source p6, system 3, mm. 135-138
  \refSystem #66.577007083 #12.499998216
  s1*3/4 % source m135
  s1*3/4 % source m136
  s1*3/4 % source m137
  s1*3/4 \break % source m138
  % Source p6, system 4, mm. 139-142
  \refSystem #98.663756138 #12.499998216
  s1*3/4 % source m139
  s1*3/4 % source m140
  s1*3/4 % source m141
  s1*3/4 % source m142
  % Source p6, system 5, mm. 143-147
  \grace { \break \refSystem #131.201883117 #12.499998239 s1*1/8 }
  s1*3/4 % source m143
  s1*3/4 % source m144
  s1*3/4 % source m145
  s1*3/4 % source m146
  s1*3/4 \pageBreak % source m147
  % Source p7, system 1, mm. 148-152
  \refSystem #4.874907759 #12.499998127
  s1*3/4 % source m148
  s1*3/4 % source m149
  s1*3/4 % source m150
  s1*3/4 % source m151
  s1*3/4 \break % source m152
  % Source p7, system 2, mm. 153-157
  \refSystem #36.506096273 #14.664569724
  s1*3/4 % source m153
  s1*3/4 % source m154
  s1*3/4 % source m155
  s1*3/4 % source m156
  s1*3/4 \break % source m157
  % Source p7, system 3, mm. 158-160
  \refSystem #70.170617937 #12.499998216
  s1*3/4 % source m158
  s1*3/4 % source m159
  s1*3/4 \break % source m160
  % Source p7, system 4, mm. 161-164
  \refSystem #101.539582792 #12.500005412
  s1*3/4 % source m161
  s1*3/4 % source m162
  s1*3/4 % source m163
  s1*3/4 \break % source m164
  % Source p7, system 5, mm. 165-168
  \refSystem #130.615987097 #12.500012585
  s1*3/4 % source m165
  s1*3/4 % source m166
  s1*3/4 % source m167
  s1*3/4 \pageBreak % source m168
  % Source p8, system 1, mm. 169-172
  \refSystem #2.451507059 #12.499998127
  s1*3/4 % source m169
  s1*3/4 % source m170
  s1*3/4 % source m171
  s1*3/4 \break % source m172
  % Source p8, system 2, mm. 173-176
  \refSystem #33.951466073 #12.500005412
  s1*3/4 % source m173
  s1*3/4 % source m174
  s1*3/4 % source m175
  s1*3/4 \break % source m176
  % Source p8, system 3, mm. 177-179
  \refSystem #65.451497427 #12.499998239
  s1*3/4 % source m177
  s1*3/4 % source m178
  s1*3/4 \break % source m179
  % Source p8, system 4, mm. 180-182
  \refSystem #97.451508982 #12.500005412
  s1*3/4 % source m180
  s1*3/4 % source m181
  s1*3/4 \break % source m182
  % Source p8, system 5, mm. 183-186
  \refSystem #128.000005533 #13.635358189
  s1*3/4 % source m183
  s1*3/4 % source m184
  s1*3/4 % source m185
  s1*3/4 \pageBreak % source m186
  % Source p9, system 1, mm. 187-190
  \refSystem #2.499910659 #13.499997910
  s1*3/4 % source m187
  s1*3/4 % source m188
  s1*3/4 % source m189
  s1*3/4 \break % source m190
  % Source p9, system 2, mm. 191-193
  \refSystem #37.506134378 #12.499998239
  s1*3/4 % source m191
  s1*3/4 % source m192
  s1*3/4 \break % source m193
  % Source p9, system 3, mm. 194-197
  \refSystem #65.499889434 #12.499998216
  s1*3/4 % source m194
  s1*3/4 % source m195
  s1*3/4 % source m196
  s1*3/4 \break % source m197
  % Source p9, system 4, mm. 198-200
  \refSystem #100.375039913 #12.500005412
  s1*3/4 % source m198
  s1*3/4 % source m199
  s1*3/4 \break % source m200
  % Source p9, system 5, mm. 201-203
  \refSystem #132.224111741 #12.499998239
  s1*3/4 % source m201
  s1*3/4 % source m202
  s1*3/4 \pageBreak % source m203
  % Source p10, system 1, mm. 204-207
  \refSystem #4.499926359 #12.499998127
  s1*3/4 % source m204
  s1*3/4 % source m205
  s1*3/4 % source m206
  s1*3/4 \break % source m207
  % Source p10, system 2, mm. 208-209
  \refSystem #35.836708473 #12.500005412
  s1*3/4 % source m208
  s1*3/4 \break % source m209
  % Source p10, system 3, mm. 210-212
  \refSystem #65.951507127 #12.499998239
  s1*3/4 % source m210
  s1*3/4 % source m211
  s1*3/4 \break % source m212
  % Source p10, system 4, mm. 213-215
  \refSystem #95.999945282 #12.632498025
  s1*3/4 % source m213
  s1*3/4 % source m214
  s1*3/4 \break % source m215
  % Source p10, system 5, mm. 216-218
  \refSystem #127.632491470 #12.515874368
  s1*3/4 % source m216
  s1*3/4 % source m217
  s1*3/4 \pageBreak % source m218
  % Source p11, system 1, mm. 219-222
  \refSystem #1.499902759 #12.818611973
  s1*3/4 % source m219
  s1*3/4 % source m220
  s1*3/4 % source m221
  s1*3/4 \break % source m222
  % Source p11, system 2, mm. 223-225
  \refSystem #33.818664089 #12.500001814
  s1*3/4 % source m223
  s1*3/4 % source m224
  s1*3/4 \break % source m225
  % Source p11, system 3, mm. 226-229
  \refSystem #67.229973444 #13.037146049
  s1*3/4 % source m226
  s1*3/4 % source m227
  s1*3/4 % source m228
  s1*3/4 \break % source m229
  % Source p11, system 4, mm. 230-232
  \refSystem #98.535723586 #12.500005412
  s1*3/4 % source m230
  s1*3/4 % source m231
  s1*3/4 % source m232
  % Source p11, system 5, mm. 233-236
  \grace { \break \refSystem #126.767158114 #12.499998239 s1*1/2 }
  s1*3/4 % source m233
  s1*3/4 % source m234
  s1*3/4 % source m235
  s1*3/4 \pageBreak % source m236
  % Source p12, system 1, mm. 237-241
  \refSystem #2.951459359 #12.499998127
  s1*3/4 % source m237
  s1*3/4 % source m238
  s1*3/4 % source m239
  s1*3/4 % source m240
  s1*3/4 % source m241
}


%% additional definitions required by the score:
hideNote =
  \tweak NoteColumn.ignore-collision ##t
  \tweak Dots.transparent ##t
  \tweak NoteHead.transparent ##t
  \tweak NoteHead.no-ledgers ##t
  \tweak Stem.transparent ##t
  \tweak Flag.transparent ##t
  \tweak Accidental.transparent ##t
  \tweak Rest.transparent ##t
  \tweak TabNoteHead.transparent ##t \etc

D = \tweak Stem.direction #DOWN \etc
U = \tweak Stem.direction #UP \etc




PartPOneVoiceOne = {
  \clef "treble" \time 6/8 \key as \major \oneVoice \U es'4 \U f'8 \U <es' g'>8
  [ \U <es' as'>8 \U <es' bes'>8 ] | % 1
  \U <es' c''>4 \D <f' as' f''>8 \U <es' as' es'' \tweak output-attributes
    #'((data-sid . "op47-tie-0001")) ~>4. | % 2
  \voiceOne \U es''2. \tweak output-attributes #'((data-sid . "op47-tie-0002"))
  ~ | % 3
  \U es''2. | % 4
  \U es'2. \tweak output-attributes #'((data-sid . "op47-tie-0003")) ~ | % 5
  \oneVoice \U <as es'>4 \U <as b d'>8 \U <as \tweak output-attributes
    #'((data-sid . "op47-tie-0004")) ~ c' \tweak output-attributes #'((data-sid
    . "op47-tie-0005")) ~ es' \tweak output-attributes #'((data-sid .
    "op47-tie-0006")) ~>4. | % 6
  \U <as c' es'>8 [ \U as'8 \U bes'8 ] \U c''4 \U bes'8 | % 7
  \U c''4 \U as'8 \U as'4 \tweak output-attributes #'((data-sid .
  "op47-rest-0003")) r8 | % 8
  \D <as'' as'''>4. \tweak output-attributes #'((data-sid . "op47-rest-0006")) r8
  \tweak output-attributes #'((data-sid . "op47-rest-0007")) r4 | % 9

  \barNumberCheck #10
  \D <as' as''>4. \tweak output-attributes #'((data-sid . "op47-rest-0010")) r8
  \tweak output-attributes #'((data-sid . "op47-rest-0011")) r16 \U <c' c''>16 [
  \U <f' f''>8 ] | % 10
  \tweak output-attributes #'((data-sid . "op47-rest-0014")) r8 \tweak
  output-attributes #'((data-sid . "op47-rest-0015")) r16 \U <es' es''>16 [ \U
  <es' es''>8 ] \tweak output-attributes #'((data-sid . "op47-rest-0016")) r8
  \tweak output-attributes #'((data-sid . "op47-rest-0017")) r16 \U <es' es''>16
  [ \U <es' es''>8 ] | % 11
  \tweak output-attributes #'((data-sid . "op47-rest-0020")) r8 \tweak
  output-attributes #'((data-sid . "op47-rest-0021")) r16 \U <es' es''>16 [ \U
  <es' es''>8 ] \tweak output-attributes #'((data-sid . "op47-rest-0022")) r8
  \tweak output-attributes #'((data-sid . "op47-rest-0023")) r16 \U <es' es''>16
  [ \U <es' es''>8 ] | % 12
  \D <as'' as'''>4. \tweak output-attributes #'((data-sid . "op47-rest-0026")) r4
  \tweak output-attributes #'((data-sid . "op47-rest-0027")) r8 | % 13
  \D <as' as''>4. \tuplet 8/6 {
    \tweak output-attributes #'((data-sid . "op47-rest-0030")) r16 \U <c' c''>16
    [ \U <des' des''>16 \U <d' d''!>16 \U <es' es''>16 \U <e' e''!>16 \U <g'
      g''>16 \tweak output-attributes #'((data-sid . "op47-rest-0031")) r32 \U
    <f' f''>32 ] }
  | % 14
  \D <f' f''>8. [ \D <es' es''>16 \D <es' es''>8 ] \tweak output-attributes
  #'((data-sid . "op47-rest-0034")) r8 \tweak output-attributes #'((data-sid .
  "op47-rest-0035")) r16 \D <es' es''>16 [ \D <es' \tweak output-attributes
    #'((data-sid . "op47-tie-0009")) ~ es'' \tweak output-attributes
    #'((data-sid . "op47-tie-0010")) ~>8 ] | % 15
  \D <es' es''>8. [ \D <es' es''>16 \D <es' es''>8 ] \tweak output-attributes
  #'((data-sid . "op47-rest-0038")) r8 \tweak output-attributes #'((data-sid .
  "op47-rest-0039")) r16 \D <es' es''>16 [ \D <es' \tweak output-attributes
    #'((data-sid . "op47-tie-0011")) ~ es'' \tweak output-attributes
    #'((data-sid . "op47-tie-0012")) ~>8 ] | % 16
  \D <es' es''>8. [ \D as'16 \D <f' \tweak output-attributes #'((data-sid .
    "op47-tie-0013")) ~ f'' \tweak output-attributes #'((data-sid .
    "op47-tie-0014")) ~>8 ] \D <f' f''>8. [ \D <es' es''>16 \D <d' d''!>8 ] | % 17
  \tweak output-attributes #'((data-sid . "op47-rest-0043")) r8 \tweak
  output-attributes #'((data-sid . "op47-rest-0044")) r16 \U des''!16 [ \U
  <des'! g' des''>8 ] \tweak output-attributes #'((data-sid . "op47-rest-0045"))
  r8 \tweak output-attributes #'((data-sid . "op47-rest-0046")) r16 \U <c' as'
    c''>16 [ \U <des' as' des''>8 ] | % 18
  \U <c' as' c''>8. [ \U bes'16 \voiceOne \U bes'8 ] \U bes'4. \tweak
  output-attributes #'((data-sid . "op47-tie-0015")) ~ | % 19

  \barNumberCheck #20
  \U bes'4. \oneVoice \tweak output-attributes #'((data-sid . "op47-rest-0053"))
  r8 \tweak output-attributes #'((data-sid . "op47-rest-0054")) r16 \U <g des'
    es'>16 [ \U <g des' es'>8 ] | % 20
  \U <as c' as'>8 \tweak output-attributes #'((data-sid . "op47-rest-0061")) r16
  \D <es'' as'' es'''>16 [ \D <es'' \tweak output-attributes #'((data-sid .
    "op47-tie-0016")) ~ as'' \tweak output-attributes #'((data-sid .
    "op47-tie-0017")) ~ es''' \tweak output-attributes #'((data-sid .
    "op47-tie-0018")) ~>8 ] \D <es'' as'' es'''>8. [ \D <d'' d'''!>16 \D <as''
    as'''>8 ] | % 21
  \tweak output-attributes #'((data-sid . "op47-rest-0064")) r8 \tweak
  output-attributes #'((data-sid . "op47-rest-0065")) r16 \D <des''! as''
    des'''!>16 [ \D <des'' \tweak output-attributes #'((data-sid .
    "op47-tie-0019")) ~ as'' \tweak output-attributes #'((data-sid .
    "op47-tie-0020")) ~ des''' \tweak output-attributes #'((data-sid .
    "op47-tie-0021")) ~>8 ] \D <des'' as'' des'''>8. [ \D <c'' as'' c'''>16
  \slashedGrace { \U <es'' as'' \tweak output-attributes #'((data-sid .
      "op47-tie-0022")) ~ es'''>8 } \D <des'' as'' des'''>8 ] | % 22
  \D <c'' as'' c'''>8. [ \D <bes' d'' as'' bes''>16 \D <bes' d'' as'' bes''>8 ]
  \voiceOne \U bes''4. \tweak output-attributes #'((data-sid . "op47-tie-0023"))
  ~ | % 23
  \U bes''4. \oneVoice \tweak output-attributes #'((data-sid .
  "op47-rest-0073")) r8 \tweak output-attributes #'((data-sid .
  "op47-rest-0074")) r16 \D <g' des'' es''>16 [ \D <g' des'' es''>8 ] | % 24
  \D <as' c'' as''>8 \tweak output-attributes #'((data-sid . "op47-rest-0081"))
  r16 \D <ges'' ges'''!>16 [ \D <ges'' ges'''>8 ] \D <ges'' ges'''>4. | % 25
  \slashedGrace { \U f'8 [ \U ges'8 \U as'8 ] } \U ges'4. ^\trill \D f'16 [ \D
  a'16 \D c''16 \D f''16 \D f'''8 ] | % 26
  \D <bes'' bes'''>8 \tweak output-attributes #'((data-sid . "op47-rest-0083"))
  r16 \D <as' as''>16 [ \D <as' as''>8 ] \D <as' as''>4. | % 27
  \slashedGrace { \U g'8 [ \U as'8 \U bes'!8 ] } \U as'4. ^\trill \D g'16 [ \D
  b'16 \D d''16 \D g''16 \D g'''8 ] | % 28
  \D <c''' c''''>8 \tweak output-attributes #'((data-sid . "op47-rest-0086")) r8
  \U as'8 ^\trill \D g'16 [ \D b'16 \D d''16 \D g''16 \D g'''8 ] | % 29

  \barNumberCheck #30
  \D <c''' c''''>8 \tweak output-attributes #'((data-sid . "op47-rest-0088")) r8
  \U as'8 ^\trill \D g'16 [ \D b'16 \D d''16 \D g''16 \D g'''8 ] | % 30
  \ottava #1 \D <e''' c'''' e''''>8 \ottava #0 \tweak output-attributes
  #'((data-sid . "op47-rest-0090")) r8 \U a'32 ^\trill [ \U b'32 \U a'32 \U b'32
  ] \D g'16 [ \D b'!16 \D d''16 \D g''16 \D g'''8 ] | % 31
  \ottava #1 \D <e''' c'''' e''''>8 \ottava #0 \tweak output-attributes
  #'((data-sid . "op47-rest-0092")) r8 \U a'32 ^\trill [ \U b'32 \U a'32 \U b'32
  ] \D g'16 [ \D b'!16 \D d''16 \D g''16 \D g'''8 ] | % 32
  \ottava #1 \D <e''' c'''' e''''>8 \ottava #0 \U e'!16 [ \U <g' d''>16 \U c''16
  \U g'16 ] \D <c'' f''>16 [ \D e''!16 \D c''16 \D <e'' a''>16 \D g''16 \D e''16
  ] | % 33
  \D <g'' d'''>16 [ \D c'''16 \D g''16 \D <c''' f'''>16 \D e'''16 \D c'''16 ]
  \ottava #1 \D <e''' a'''>16 [ \D g'''16 \D e'''16 \D <g''' d''''!>16 \D c''''16
  \D g'''16 ] | % 34
  \D <c'''' f''''>16 [ \D e''''16 \D c''''16 \D g'''16 \ottava #0 \D e'''!16 \D
  c'''16 ] \D g''16 [ \D e''!16 \D c''16 \D g'16 \D c'16 \voiceOne \change
  Staff="2" \U g16 ] \change Staff="1" | % 35
  \oneVoice \tweak output-attributes #'((data-sid . "op47-rest-0098")) R2. | % 36
  \U es'4 \U f'8 \U <es' g'>8 [ \U <es' as'>8 \U <es' bes'>8 ] | % 37
  \U <es' c''>4 \D <f' as' f''>8 \U <es' as' es'' \tweak output-attributes
    #'((data-sid . "op47-tie-0027")) ~>4. | % 38
  \voiceOne \U es''2. \tweak output-attributes #'((data-sid . "op47-tie-0028"))
  ~ | % 39

  \barNumberCheck #40
  \U es''2. | % 40
  \U es'2. \tweak output-attributes #'((data-sid . "op47-tie-0029")) ~ | % 41
  \U es'8 \U <es' f' \tweak output-attributes #'((data-sid . "op47-tie-0031"))
    ~>4 \U f'4. \tweak output-attributes #'((data-sid . "op47-tie-0032")) ~ | % 42
  \U f'8 \U <ges' bes'>4 \U as'4. \tweak output-attributes #'((data-sid .
  "op47-tie-0034")) ~ | % 43
  \U as'8 \U <as' c''>4 \U bes'4. | % 44
  \oneVoice \D <es' g' es''>4 \D <f' bes' f''>8 \D <g' es'' g''>8 [ \D <as' es''
    as''>8 \D <bes' es'' bes''>8 ] | % 45
  \D <c'' es'' c'''>4 \D <f'' as'' f'''>8 \D <es'' as'' es'''>4 \ottava #1 \D
  <f''' as''' f''''>8 | % 46
  \D <es''' as''' es''''>4 \ottava #0 \tweak output-attributes #'((data-sid .
  "op47-rest-0102")) r8 \tweak output-attributes #'((data-sid .
  "op47-rest-0103")) r4 \tweak output-attributes #'((data-sid .
  "op47-rest-0104")) r8 | % 47
  \clef "bass" \tweak output-attributes #'((data-sid . "op47-rest-0106")) r8 \U
  as,8 [ \U bes,8 ] \U c4 \U bes,8 | % 48
  \U c4 \U as,8 \tweak output-attributes #'((data-sid . "op47-rest-0107")) r4
  \tweak output-attributes #'((data-sid . "op47-rest-0108")) r8 | % 49

  \barNumberCheck #50
  \clef "treble" \D <as'' \tweak output-attributes #'((data-sid .
    "op47-tie-0039")) ~ as''' \tweak output-attributes #'((data-sid .
    "op47-tie-0040")) ~>2. | % 50
  \D <as'' \tweak output-attributes #'((data-sid . "op47-tie-0045")) ~ as'''
    \tweak output-attributes #'((data-sid . "op47-tie-0046")) ~>2. | % 51
  \D <as'' as'''>8 \tweak output-attributes #'((data-sid . "op47-rest-0109")) r8
  \D c'''8 [ \D c''8 ] \tweak output-attributes #'((data-sid .
  "op47-rest-0110")) r8 \D c'''8 [ | % 52
  \D c''8 ] \tweak output-attributes #'((data-sid . "op47-rest-0113")) r8 \D
  c'''8 [ \D c''8 ] \tweak output-attributes #'((data-sid . "op47-rest-0114")) r8
  \D c'''8 [ | % 53
  \D c''8 ] \tweak output-attributes #'((data-sid . "op47-rest-0116")) r8 \D
  <bes' a''>8 [ \D c''8 ] \tweak output-attributes #'((data-sid .
  "op47-rest-0117")) r8 \D <bes' g''>8 [ | % 54
  \D c''8 ] \tweak output-attributes #'((data-sid . "op47-rest-0120")) r8 \D <a'
    \tweak output-attributes #'((data-sid . "op47-tie-0051")) ~ f''>8
  \slashedGrace { \U g''8 } \D <a' f''>8 [ \D <g' e''>8 \D <f' d''>8 ] | % 55
  \U g'8 \tweak output-attributes #'((data-sid . "op47-rest-0123")) r8 \D <f'
    e''>8 [ \D g'8 ] \tweak output-attributes #'((data-sid . "op47-rest-0124"))
  r8 \U <f' d''>8 [ | % 56
  \U g'8 ] \tweak output-attributes #'((data-sid . "op47-rest-0127")) r8 \U <e'
    \tweak output-attributes #'((data-sid . "op47-tie-0052")) ~ c''>8
  \slashedGrace { \U d''8 } \U <e' c''>8 [ \U <f' b'>8 \U <e' \tweak
    output-attributes #'((data-sid . "op47-tie-0053")) ~ c'' \tweak
    output-attributes #'((data-sid . "op47-tie-0054")) ~>8 ] | % 57
  \U <e' c''>8 \tweak output-attributes #'((data-sid . "op47-rest-0131")) r8 \D
  <bes' a''>8 [ \D c''8 ] \tweak output-attributes #'((data-sid .
  "op47-rest-0132")) r8 \D <bes' g''>8 [ | % 58
  \D c''8 ] \tweak output-attributes #'((data-sid . "op47-rest-0137")) r8 \D <a'
    \tweak output-attributes #'((data-sid . "op47-tie-0058")) ~ f''>8
  \slashedGrace { \U g''8 } \D <a' f''>8 [ \D <g' e''>8 \D <f' d''>8 ] | % 59

  \barNumberCheck #60
  \U g'8 \tweak output-attributes #'((data-sid . "op47-rest-0140")) r8 \D <f'
    e''>8 [ \D g'8 ] \tweak output-attributes #'((data-sid . "op47-rest-0141"))
  r8 \U <f' d''>8 | % 60
  \U g'8 \tweak output-attributes #'((data-sid . "op47-rest-0144")) r8 \U <e'
    \tweak output-attributes #'((data-sid . "op47-tie-0059")) ~ c''>8
  \slashedGrace { \U d''8 } \U <e' c''>8 [ \U <f' b'>8 \U <e' \tweak
    output-attributes #'((data-sid . "op47-tie-0060")) ~ c'' \tweak
    output-attributes #'((data-sid . "op47-tie-0061")) ~>8 ] | % 61
  \U <e' c''>8 \tweak output-attributes #'((data-sid . "op47-rest-0148")) r8 \U
  <e' \tweak output-attributes #'((data-sid . "op47-tie-0066")) ~ c''>8
  \slashedGrace { \U d''8 } \U <e' c''>8 [ \U <f' b'>8 \U <e' \tweak
    output-attributes #'((data-sid . "op47-tie-0067")) ~ c'' \tweak
    output-attributes #'((data-sid . "op47-tie-0068")) ~>8 ] | % 62
  \U <e' c''>8 \tweak output-attributes #'((data-sid . "op47-rest-0152")) r8
  \voiceOne \U c''4 \oneVoice \tweak output-attributes #'((data-sid .
  "op47-rest-0153")) r8 \voiceOne \U c''8 \tweak output-attributes #'((data-sid
  . "op47-tie-0073")) ~ [ | % 63
  \U c''8 ] \tweak output-attributes #'((data-sid . "op47-rest-0158")) r8 \U c''4.
  \U c''8 \tweak output-attributes #'((data-sid . "op47-tie-0074")) ~ | % 64
  \U <as' c''>4 \U c''8 \tweak output-attributes #'((data-sid .
  "op47-tie-0076")) ~ \U c''8 \tweak output-attributes #'((data-sid .
  "op47-rest-0163")) r8 \U f''8 | % 65
  \slashedGrace { \U g''8 } \U f''8 [ \U es''8 \U des''8 ] \U c''8 [ \U as'8 \U
  bes'8 ] | % 66
  \U c''8 \oneVoice \tweak output-attributes #'((data-sid . "op47-rest-0169")) r8
  \U <f' as' c''>8 \tweak output-attributes #'((data-sid . "op47-rest-0170")) r4
  \U <es' as' c'' \tweak output-attributes #'((data-sid . "op47-tie-0078")) ~>8
  | % 67
  \U c''8. [ \U c''16 \U <es' as' des''>8 ] \U es''8 [ \tweak output-attributes
  #'((data-sid . "op47-rest-0175")) r16 \U <es' as'>16 \U <des' g' bes'>8 ] | % 68
  \U <c' as' c''>8 \tweak output-attributes #'((data-sid . "op47-rest-0178")) r8
  \U <e' bes' c''>8 \tweak output-attributes #'((data-sid . "op47-rest-0179")) r4
  \U <f' as' c'' \tweak output-attributes #'((data-sid . "op47-tie-0080")) ~>8 | % 69

  \barNumberCheck #70
  \D c''4 \D <as' f''>8 \slashedGrace { \U g''8 } \D f''8 [ \D es''8 \D <bes'
    des''>8 ] | % 70
  \U <as' c''>8 [ \U <g' c''>8 \U <f' as' d''>8 ] \U <es' g'>8 \tweak
  output-attributes #'((data-sid . "op47-rest-0184")) r8 \U <c' es' g'>8 | % 71
  \U <c' es' g'>4 \U <c' es' g'>8 \set Staff.pedalSustainStyle = #'bracket \U
  <c' d' g'>4 \sustainOn <> \sustainOff \U <b d' g'>8 | % 72
  \U <c' e' g'>8 \tweak output-attributes #'((data-sid . "op47-rest-0188")) r8
  \D <bes' c'' g''>8 \tweak output-attributes #'((data-sid . "op47-rest-0189"))
  r4 \D <as' c'' f''>8 | % 73
  \tweak output-attributes #'((data-sid . "op47-rest-0192")) r4 \D <g' \tweak
    output-attributes #'((data-sid . "op47-tie-0081")) ~ bes' \tweak
    output-attributes #'((data-sid . "op47-tie-0082")) ~ es''!>8 \slashedGrace {
    \U f''8 } \D <g' bes' es''>8 [ \D as'8 \D <f' des''>8 ] | % 74
  \U <e' c''>8 \tweak output-attributes #'((data-sid . "op47-rest-0195")) r8 \D
  <bes' c'' g''>4. \D <as' \tweak output-attributes #'((data-sid .
    "op47-tie-0083")) ~ c'' \tweak output-attributes #'((data-sid .
    "op47-tie-0084")) ~ f'' \tweak output-attributes #'((data-sid .
    "op47-tie-0085")) ~>8 | % 75
  \D <as' c'' f''>4 \D <g' \tweak output-attributes #'((data-sid .
    "op47-tie-0086")) ~ bes' \tweak output-attributes #'((data-sid .
    "op47-tie-0087")) ~ es''!>8 \slashedGrace { \U f''8 } \D <g' bes' es''>8 [
  \D as'8 \D <f' des''>8 ] | % 76
  \U <e' c''>8 \tweak output-attributes #'((data-sid . "op47-rest-0200")) r8 \D
  <c'' c'''>4. \D <c'' \tweak output-attributes #'((data-sid . "op47-tie-0088"))
    ~ d'' \tweak output-attributes #'((data-sid . "op47-tie-0089")) ~ c'''
    \tweak output-attributes #'((data-sid . "op47-tie-0090")) ~>8 | % 77
  \D <c'' d'' c'''>4 \D <c'' f'' c'''>4. \D <c'' \tweak output-attributes
    #'((data-sid . "op47-tie-0091")) ~ e'' \tweak output-attributes #'((data-sid
    . "op47-tie-0092")) ~ c''' \tweak output-attributes #'((data-sid .
    "op47-tie-0093")) ~>8 | % 78
  \D <c'' e'' c'''>4 \D <c'' d'' c'''>4. \D <c'' \tweak output-attributes
    #'((data-sid . "op47-tie-0094")) ~ e'' \tweak output-attributes #'((data-sid
    . "op47-tie-0095")) ~ c''' \tweak output-attributes #'((data-sid .
    "op47-tie-0096")) ~>8 | % 79

  \barNumberCheck #80
  \D <c'' e'' c'''>4 \D <c'' as'' c'''>4. \D <c'' g'' c'''>8 | % 80
  \D <c'' g'' c'''>4 \D <c'' f'' c'''>4 \tweak output-attributes #'((data-sid .
  "op47-rest-0209")) r8 \D <f'' f'''>8 | % 81
  \slashedGrace { \U <g'' g'''>8 } \D <f'' f'''>8 [ \D <es''! es'''!>8 \D <des''
    bes'' des'''>8 ] \D <c'' as'' c'''>8 [ \D <as' f'' as''>8 \D <bes' g''
    bes''>8 ] | % 82
  \D <c'' as'' c'''>8 \tweak output-attributes #'((data-sid . "op47-rest-0214"))
  r8 \D <c'' as'' c'''>8 \tweak output-attributes #'((data-sid .
  "op47-rest-0215")) r4 \D <c'' as'' c'''>8 | % 83
  \D <c'' as'' c'''>8 [ \tweak output-attributes #'((data-sid .
  "op47-rest-0218")) r16 \D <c'' as'' c'''>16 \D <des'' as'' des'''>8 ] \D <es''
    as'' es'''>8 [ \tweak output-attributes #'((data-sid . "op47-rest-0219")) r16
  \D <as' es'' as''>16 \D <bes' es'' bes''>8 ] | % 84
  \D <c'' es'' c'''>8 \tweak output-attributes #'((data-sid . "op47-rest-0222"))
  r8 \D <c'' e'' bes'' c'''>8 \tweak output-attributes #'((data-sid .
  "op47-rest-0223")) r4 \D <c'' \tweak output-attributes #'((data-sid .
    "op47-tie-0097")) ~ f'' \tweak output-attributes #'((data-sid .
    "op47-tie-0098")) ~ as'' \tweak output-attributes #'((data-sid .
    "op47-tie-0099")) ~ c''' \tweak output-attributes #'((data-sid .
    "op47-tie-0100")) ~>8 | % 85
  \D <c'' f'' as'' c'''>8 \tweak output-attributes #'((data-sid .
  "op47-rest-0226")) r8 \slashedGrace { \U <g'' g'''>8 } \D <f'' as'' f'''>8 \D
  <f'' as'' f'''>8 [ \D <fes'' as'' fes'''!>8 \D <es'' as'' es'''>8 ] | % 86
  \D <d'' as'' d'''>8 \tweak output-attributes #'((data-sid . "op47-rest-0228"))
  r16 \D <des'' as'' des'''!>16 [ \D <c'' as'' c'''>8 ] \D <c'' as'' c'''>8 [ \D
  <g' c'' g''>8 \D <bes' c'' bes''>8 ] | % 87
  \D <as' c'' as''>8 \tweak output-attributes #'((data-sid . "op47-rest-0230"))
  r8 \voiceOne \U as'8 \tweak output-attributes #'((data-sid . "op47-tie-0101"))
  ~ \sustainOn \U as'8 [ <> \sustainOff \U g'8 \U ges'8 ] | % 88
  \U <f f'>4 \tweak output-attributes #'((data-sid . "op47-rest-0233")) r8
  \tweak output-attributes #'((data-sid . "op47-rest-0234")) r8 \oneVoice \U <g!
    g'!>8 [ \U <bes bes'>8 ] | % 89

  \barNumberCheck #90
  \U <as as'>8 \tweak output-attributes #'((data-sid . "op47-rest-0239")) r8
  \voiceOne \U as'8 \tweak output-attributes #'((data-sid . "op47-tie-0106")) ~
  \sustainOn \U as'8 [ <> \sustainOff \U g'!8 \U ges'8 ] | % 90
  \U f'4 \clef "bass" \U f'8 \tweak output-attributes #'((data-sid .
  "op47-tie-0111")) ~ \sustainOn \U f'8 [ <> \sustainOff \U e'8 \U g'8 ] | % 91
  \U f'8 \oneVoice \tweak output-attributes #'((data-sid . "op47-rest-0242")) r8
  \voiceOne \U <des' \tweak output-attributes #'((data-sid . "op47-tie-0118")) ~
    f' \tweak output-attributes #'((data-sid . "op47-tie-0119")) ~>8 \U <des'
    f'>8 [ \U <c' es'!>8 \U <bes des'>8 ] | % 92
  \U c'8 \oneVoice \tweak output-attributes #'((data-sid . "op47-rest-0245")) r8
  \voiceOne \U f'8 \tweak output-attributes #'((data-sid . "op47-tie-0123")) ~
  \sustainOn \U f'8 [ <> \sustainOff \U es'8 \U des'8 ] | % 93
  \U c'8 \oneVoice \tweak output-attributes #'((data-sid . "op47-rest-0248")) r8
  \voiceOne \U <des' \tweak output-attributes #'((data-sid . "op47-tie-0128")) ~
    f' \tweak output-attributes #'((data-sid . "op47-tie-0129")) ~>8 \U <des'
    f'>8 [ \U <c' es'!>8 \U <bes! des'>8 ] | % 94
  \oneVoice \D <e c'>4 \D <f c' d'>8 \D <as c' f'>4 \D <g c' e'>8 | % 95
  \D <c' d'>4 \D <c' e'>8 \D <e' as'>4 \D <e' g'>8 | % 96
  \clef "treble" \U <e' c''>4 \U <f' c'' d''>8 \D <as' c'' f''>4 \D <g' c'' e''>8
  | % 97
  \U <f' c'' d''>4 \D <g' c'' e''>8 \slashedGrace { \U <g' c'' e''>8 } \D <c''
    e'' as''>4 \D <bes' c'' g''>8 | % 98
  \D <as' c'' f''>8 \tweak output-attributes #'((data-sid . "op47-rest-0253")) r8
  \tweak output-attributes #'((data-sid . "op47-rest-0254")) r8 \U <as as'
    \tweak output-attributes #'((data-sid . "op47-tie-0134")) ~>4. | % 99

  \barNumberCheck #100
  \voiceOne \U as'8 [ \U g'8 \U f'8 ] \U es'8 [ \U c''8 \U bes'8 ] | % 100
  \U as'8 \oneVoice \tweak output-attributes #'((data-sid . "op47-rest-0261")) r8
  \tweak output-attributes #'((data-sid . "op47-rest-0262")) r8 \voiceOne \U c''4.
  \tweak output-attributes #'((data-sid . "op47-tie-0136")) ~ | % 101
  \U c''8 [ \U b'8 \U a'8 ] \U g'8 [ \U e''8 \U d''8 ] | % 102
  \U c''8 \oneVoice \tweak output-attributes #'((data-sid . "op47-rest-0266")) r8
  \D c'''8 [ \D c''8 ] \tweak output-attributes #'((data-sid .
  "op47-rest-0267")) r8 \D c'''8 [ | % 103
  \D c''8 ] \tweak output-attributes #'((data-sid . "op47-rest-0276")) r8 \D
  c'''8 [ \D c''8 ] \tweak output-attributes #'((data-sid . "op47-rest-0277")) r8
  \D c'''8 [ | % 104
  \D c''8 ] \tweak output-attributes #'((data-sid . "op47-rest-0279")) r8 \D
  <bes' a''>8 [ \D c''8 ] \tweak output-attributes #'((data-sid .
  "op47-rest-0280")) r8 \D <bes' g''>8 | % 105
  \D c''8 \tweak output-attributes #'((data-sid . "op47-rest-0283")) r8 \D <a'
    \tweak output-attributes #'((data-sid . "op47-tie-0138")) ~ f''>8
  \slashedGrace { \U g''8 } \D <a' f''>8 [ \D <g' e''>8 \D <f' d''>8 ] | % 106
  \U g'8 \tweak output-attributes #'((data-sid . "op47-rest-0286")) r8 \D <f'
    e''>8 [ \D g'8 ] \tweak output-attributes #'((data-sid . "op47-rest-0287"))
  r8 \U <f' d''>8 [ | % 107
  \U g'8 ] \tweak output-attributes #'((data-sid . "op47-rest-0290")) r8 \U <e'
    \tweak output-attributes #'((data-sid . "op47-tie-0139")) ~ c''>8
  \slashedGrace { \U d''8 } \U <e' c''>8 [ \U <f' b'>8 \U <e' \tweak
    output-attributes #'((data-sid . "op47-tie-0140")) ~ c'' \tweak
    output-attributes #'((data-sid . "op47-tie-0141")) ~>8 ] | % 108
  \U <e' c''>8 \tweak output-attributes #'((data-sid . "op47-rest-0294")) r8 \D
  <bes' a''>8 [ \D c''8 ] \tweak output-attributes #'((data-sid .
  "op47-rest-0295")) r8 \D <bes' g''>8 [ | % 109

  \barNumberCheck #110
  \D c''8 ] \tweak output-attributes #'((data-sid . "op47-rest-0300")) r8 \D <a'
    \tweak output-attributes #'((data-sid . "op47-tie-0145")) ~ f''>8
  \slashedGrace { \U g''8 } \D <a' f''>8 [ \D <g' e''>8 \D <f' d''>8 ] | % 110
  \U g'8 \tweak output-attributes #'((data-sid . "op47-rest-0303")) r8 \D <f'
    e''>8 [ \D g'8 ] \tweak output-attributes #'((data-sid . "op47-rest-0304"))
  r8 \U <f' d''>8 [ | % 111
  \U g'8 ] \tweak output-attributes #'((data-sid . "op47-rest-0307")) r8 \U <e'
    \tweak output-attributes #'((data-sid . "op47-tie-0146")) ~ c''>8
  \slashedGrace { \U d''8 } \U <e' c''>8 [ \U <f' b'>8 \U <e' \tweak
    output-attributes #'((data-sid . "op47-tie-0147")) ~ c'' \tweak
    output-attributes #'((data-sid . "op47-tie-0148")) ~>8 ] | % 112
  \U <e' c''>8 \tweak output-attributes #'((data-sid . "op47-rest-0311")) r8 \U
  <e' \tweak output-attributes #'((data-sid . "op47-tie-0152")) ~ c''>8
  \slashedGrace { \U d''8 } \U <e' c''>8 [ \U <f' b'>8 \U <e' \tweak
    output-attributes #'((data-sid . "op47-tie-0153")) ~ c'' \tweak
    output-attributes #'((data-sid . "op47-tie-0154")) ~>8 ] | % 113
  \U <e' c''>8 \tweak output-attributes #'((data-sid . "op47-rest-0315")) r8 \U
  <e' c''>4 \tweak output-attributes #'((data-sid . "op47-rest-0316")) r8 \U <e'
    \tweak output-attributes #'((data-sid . "op47-tie-0158")) ~ c'' \tweak
    output-attributes #'((data-sid . "op47-tie-0159")) ~>8 | % 114
  \U <e' c''>8 \tweak output-attributes #'((data-sid . "op47-rest-0318")) r8 \U
  <e' c''>4 \tweak output-attributes #'((data-sid . "op47-rest-0319")) r8 \U <e'
    c''>8 | % 115
  \slashedGrace { \U es'!8 [ \U c''8 \U c''8 ] } \D c'''4. \tweak
  output-attributes #'((data-sid . "op47-tie-0160")) ~ \D c'''16 [ \D bes''16 \D
  as''16 \D g''16 \D as''16 \D fes''16 ] | % 116
  \D d''16 [ \D f''!16 \D es''16 \D c''16 \D as'16 \D f'16 ] \U es'4 \U <des'
    g'>8 | % 117
  \ottava #1 \slashedGrace { \U c''8 [ \U es''8 \U as''8 \U c'''8 \U es'''8 \U
    as'''8 \U c''''8 ] } \D c''''4. \tweak output-attributes #'((data-sid .
  "op47-tie-0162")) ~ \D c''''16 [ \D bes'''16 \D as'''16 \D g'''16 \D as'''16
  \D fes'''16 ] \ottava #0 | % 118
  \D d'''16 [ \sustainOn \D f'''!16 \D es'''16 \D c'''16 \D as''16 \D f''16 ] \U
  es''16 [ \U c''16 \U as'16 \U f'16 <> \sustainOff \U c'16 \U d'!16 ] | % 119

  \barNumberCheck #120
  \slashedGrace { \U es'8 [ \U g'8 ] } \D g''4. \tweak output-attributes
  #'((data-sid . "op47-tie-0163")) ~ \D g''16 [ \D f''16 \D es''16 \D d''16 \D
  es''16 \D ces''16 ] | % 120
  \U a'16 [ \U c''!16 \U bes'16 \U g'16 \U es'16 \U c'16 ] \U bes4 \U <as d'>8 | % 121
  \slashedGrace { \U g8 [ \U bes8 \U es'8 \U g'8 \U bes'8 \U es''8 \U g''8 ] }
  \D g'''4. \tweak output-attributes #'((data-sid . "op47-tie-0165")) ~ \D g'''16
  [ \D f'''16 \D es'''16 \D d'''16 \D es'''16 \D ces'''16 ] | % 122
  \D a''16 [ \D c'''!16 \D bes''16 \D g''16 \D d''16 \D es''16 ] \D e''16 [ \D
  g''16 \D f''16 \D des''16 \D bes'16 \D f'16 ] | % 123
  \D es'16 [ \sustainOn \D as'16 \D c''16 \D es''16 \D g''16 <> \sustainOff \D
  f''16 ] \D es''16 [ \D c''16 \D des''16 \D a'16 \D bes'16 \D f'16 ] | % 124
  \D es'16 [ \sustainOn \D as'16 \D c''16 \D es''16 \D g''16 <> \sustainOff \D
  f''16 ] \D es''16 [ \D c''16 \D des''16 \D a'16 \D bes'16 \D des''16 ] | % 125
  \U c'16 [ \sustainOn \U des'16 \U es'16 \U f'16 \U g'16 \U as'16 ] \D bes'16 [
  \D c''16 \D des''16 \D es''16 <> \sustainOff \D f''16 \D ges''16 ] | % 126
  \D c'''16 [ \D bes''16 \D as''16 \D bes''16 \D as''16 \D ges''16 ] \D as''16 [
  \D ges''16 \D f''16 \D ges''16 \D f''16 \D e''16 ] | % 127
  \D f''16 [ \sustainOn \D ges''16 \D g''16 \D as''16 \D c'''16 <> \sustainOff
  \D bes''16 ] \D as''16 [ \sustainOn \D f''16 \D ges''16 \D d''16 \D es''16 <>
  \sustainOff \D bes'16 ] | % 128
  \D as'16 [ \sustainOn \D des''16 \D f''16 \D as''16 \D c'''16 <> \sustainOff
  \D bes''16 ] \D as''16 [ \sustainOn \D f''16 \D ges''16 \D d''16 \D es''16 <>
  \sustainOff \D ges'!16 ] | % 129

  \barNumberCheck #130
  \U f'16 [ \sustainOn \U g'!16 \U as'16 \U bes'16 \U c''16 \U des''16 ] \D es''16
  [ \D e''16 \D f''16 \D g''!16 <> \sustainOff \D a''16 \D bes''16 ] | % 130
  \D c'''16 [ \D des'''16 \D es'''16 \D e'''16 \D f'''16 \D g'''16 ] \ottava #1
  \D a'''16 [ \D bes'''16 \D c''''16 \D des''''16 \D es''''16 \D e''''16 ] | % 131
  \D f''''16 [ \D e''''16 \D es''''16 \D des''''16 \D c''''16 \D bes'''16 ] \D
  as'''16 [ \D g'''16 \D f'''16 \D e'''16 \D es'''16 \D des'''16 ] \ottava #0 | % 132
  \D c'''16 [ \D bes''16 \D as''16 \D g''16 \D f''16 \D e''16 ] \D es''16 [ \D
  des''16 \D c''16 \D es''16 \D des''16 \D f'16 ] | % 133
  \D bes'4 ^\trill \U a'16 [ \U bes'16 ] \D c''4 ^\trill \D bes'16 [ \D c''16 ]
  | % 134
  \D des''4 ^\trill \D c''16 [ \D des''16 ] \D e''8 ^\trill [ \D dis''16 \D e''16
  \D g''16 \D f''16 ] | % 135
  \slashedGrace { \U es''!8 } \U <es' es''>4. \voiceOne \U <as' as''>8 [ \U <g'
    g''>8 \U <f' f''>8 ] | % 136
  \oneVoice \U <es' des'' es''>4. \voiceOne \U <as' as''>8 [ \U <g' g''>8 \U <f'
    f''>8 ] | % 137
  \oneVoice \U <es' des'' es''>4 \voiceOne \U <des'' f''>4. \U <c'' es''>8 | % 138
  \U des''8 [ \U c''8 \U bes'8 ] \U c''4 \U des''8 | % 139

  \barNumberCheck #140
  \oneVoice \U <des' as' des''>8 \tweak output-attributes #'((data-sid .
  "op47-rest-0343")) r8 \ottava #1 \D <as'' \tweak output-attributes
    #'((data-sid . "op47-tie-0169")) ~ as''' \tweak output-attributes
    #'((data-sid . "op47-tie-0170")) ~>8 \voiceOne \D <as'' as'''>8 [ \D <g''
    g'''>8 \D <f'' f'''>8 ] | % 140
  \oneVoice \U <es'' des''' es'''>8 \ottava #0 \D <c'' c'''>8 [ \D <bes' bes''>8
  ] \voiceOne \D <as' as''>8 [ \D <g' g''>8 \D <f' f''>8 ] | % 141
  \oneVoice \U <es' des'' es''>8 \voiceOne \U <des'' \tweak output-attributes
    #'((data-sid . "op47-tie-0171")) ~ f'' \tweak output-attributes #'((data-sid
    . "op47-tie-0172")) ~>4 \U <des'' f''>4 \U <c'' es''>8 | % 142
  \slashedGrace { \U es''8 } \U des''8 [ \U c''8 \U bes'8 ] \oneVoice \U <des'
    g' c''>4 \U <des' es'>8 | % 143
  \U <c' as'>8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0350")) r8 \D as''8 [ \D as'8 ] \tweak output-attributes
  #'((data-sid . "op47-rest-0351")) r8 \D as''8 [ | % 144
  \D as'8 ] \tweak output-attributes #'((data-sid . "op47-rest-0358")) r8 \D
  as''8 [ \D as'8 ] \tweak output-attributes #'((data-sid . "op47-rest-0359")) r8
  <> \sustainOff \D as''8 [ | % 145
  \D as'8 ] \tweak output-attributes #'((data-sid . "op47-rest-0361")) r8 \D
  <ges' f''>8 [ \D as'8 ] \tweak output-attributes #'((data-sid .
  "op47-rest-0362")) r8 \D <ges' es''>8 [ | % 146
  \D as'8 ] \tweak output-attributes #'((data-sid . "op47-rest-0365")) r8 \U <f'
    des''>8 \slashedGrace { \U es''8 } \U <f' des''>8 [ \U <es' c''>8 \U <des'
    bes'>8 ] | % 147
  \key as \major \U <des' es'>8 \tweak output-attributes #'((data-sid .
  "op47-rest-0368")) r8 \U <des' c''>8 [ \U es'8 ] \tweak output-attributes
  #'((data-sid . "op47-rest-0369")) r8 \U <des' bes'>8 [ | % 148
  \U es'8 ] \tweak output-attributes #'((data-sid . "op47-rest-0372")) r8 \U <c'
    \tweak output-attributes #'((data-sid . "op47-tie-0175")) ~ as'>8
  \slashedGrace { \U bes'8 } \U <c' as'>8 [ \U <des' g'>8 \U <c' \tweak
    output-attributes #'((data-sid . "op47-tie-0176")) ~ as' \tweak
    output-attributes #'((data-sid . "op47-tie-0177")) ~>8 ] | % 149

  \barNumberCheck #150
  \U <c' as'>8 \tweak output-attributes #'((data-sid . "op47-rest-0376")) r8 \D
  <ges' f''>8 [ \D as'8 ] \tweak output-attributes #'((data-sid .
  "op47-rest-0377")) r8 \D <ges' es''>8 [ | % 150
  \D as'8 ] \tweak output-attributes #'((data-sid . "op47-rest-0382")) r8 \U <f'
    \tweak output-attributes #'((data-sid . "op47-tie-0181")) ~ des''>8
  \slashedGrace { \U es''8 } \U <f' des''>8 [ \U <es' c''>8 \U <des' bes'>8 ] | % 151
  \U <des' es'>8 \tweak output-attributes #'((data-sid . "op47-rest-0385")) r8
  \U <des' c''>8 [ \U es'8 ] \tweak output-attributes #'((data-sid .
  "op47-rest-0386")) r8 \U <des' bes'>8 | % 152
  \U es'8 \tweak output-attributes #'((data-sid . "op47-rest-0389")) r8 \U <c'
    \tweak output-attributes #'((data-sid . "op47-tie-0182")) ~ as'>8
  \slashedGrace { \U bes'8 } \U <c' as'>8 [ \U <des' g'>8 \U <c' \tweak
    output-attributes #'((data-sid . "op47-tie-0183")) ~ as' \tweak
    output-attributes #'((data-sid . "op47-tie-0184")) ~>8 ] | % 153
  \U <c' as'>8 \tweak output-attributes #'((data-sid . "op47-rest-0393")) r8 \U
  <c' \tweak output-attributes #'((data-sid . "op47-tie-0188")) ~ as'>8
  \slashedGrace { \U bes'8 } \U <c' as'>8 [ \U <des' g'>8 \U <c' \tweak
    output-attributes #'((data-sid . "op47-tie-0189")) ~ as' \tweak
    output-attributes #'((data-sid . "op47-tie-0190")) ~>8 ] | % 154
  \U <c' as'>8 \tweak output-attributes #'((data-sid . "op47-rest-0397")) r8
  \voiceOne \U as'4 \oneVoice \tweak output-attributes #'((data-sid .
  "op47-rest-0398")) r8 \voiceOne \U as'8 [ | % 155
  \U as'8 ] \oneVoice \tweak output-attributes #'((data-sid . "op47-rest-0401"))
  r8 \voiceOne \U as'4 \oneVoice \tweak output-attributes #'((data-sid .
  "op47-rest-0402")) r8 \voiceOne \U as'8 \bar "||" % 156
  \key e \major \U gis'8 \oneVoice \tweak output-attributes #'((data-sid .
  "op47-rest-0405")) r8 \voiceOne \U gis'8 \tweak output-attributes #'((data-sid
  . "op47-tie-0193")) ~ \U gis'4 \U cis''8 \tweak output-attributes #'((data-sid
  . "op47-tie-0194")) ~ | % 157
  \U cis''8 [ \U b'8 \U a'8 ] \U gis'8 [ \U e'8 \U fis'8 ] | % 158
  \U gis'8 \oneVoice \tweak output-attributes #'((data-sid . "op47-rest-0410"))
  r8 \voiceOne \U gis'8 \tweak output-attributes #'((data-sid .
  "op47-tie-0199")) ~ \U gis'4 \U gis'8 \tweak output-attributes #'((data-sid .
  "op47-tie-0200")) ~ | % 159

  \barNumberCheck #160
  \U gis'8 [ \U gis'8 \U a'!8 ] \U b'8 [ \U e'8 \U fis'8 ] | % 160
  \U gis'8 \oneVoice \tweak output-attributes #'((data-sid . "op47-rest-0412"))
  r8 \voiceOne \U gis'8 \oneVoice \tweak output-attributes #'((data-sid .
  "op47-rest-0413")) r8 \tweak output-attributes #'((data-sid .
  "op47-rest-0414")) r8 \voiceOne \U gis'8 \tweak output-attributes #'((data-sid
  . "op47-tie-0203")) ~ | % 161
  \U gis'4 \U cis''8 \tweak output-attributes #'((data-sid . "op47-tie-0207")) ~
  \U cis''8 [ \U b'!8 \U a'8 ] | % 162
  \U gis'8 [ \oneVoice \U gis'8 \voiceOne \U a'8 ] \U b'8 \oneVoice \tweak
  output-attributes #'((data-sid . "op47-rest-0418")) r8 \voiceOne \U e''8 [ | % 163
  \U dis''8 ] \oneVoice \tweak output-attributes #'((data-sid .
  "op47-rest-0421")) r8 \voiceOne \U dis''8 \tweak output-attributes
  #'((data-sid . "op47-tie-0210")) ~ \U dis''8 \oneVoice \tweak
  output-attributes #'((data-sid . "op47-rest-0422")) r8 \voiceOne \U dis''8 | % 164
  \oneVoice \D gis''16 [ \sustainOn \D gis'16 \D gis''16 \D gis''16 \D gis'''16
  \D gis''16 ] \D gis''16 [ \D gis'16 \D gis''16 \D gis''16 <> \sustainOff \D
  gis'''16 \D gis''16 ] | % 165
  \D gis''16 [ \D gis'16 \D gis''16 \D gis''16 \D gis'''16 \D gis''16 ] \D gis''16
  [ \D gis'16 \D gis''16 \D gis''16 \D gis'''16 \D gis''16 ] | % 166
  \D gis''16 [ \sustainOn \D gis'16 \D gis''16 \D gis''16 \D gis'''16 \D gis''16
  ] \D gis''16 [ \D gis'16 \D gis''16 \D gis''16 <> \sustainOff \D gis'''16 \D
  gis''16 ] | % 167
  \D gis''16 [ \D gis'16 \D gis''16 \D gis''16 \D gis'''16 \D gis''16 ] \D gis''16
  [ \D gis'16 \D gis''16 \D gis''16 \D gis'''16 \D gis''16 ] | % 168
  \D gis''16 [ \sustainOn \D gis'16 \D gis''16 \D gis''16 \D gis'''16 \D gis''16
  ] \D gis''16 [ \D gis'16 \D gis''16 \D gis''16 <> \sustainOff \D gis'''16 \D
  gis''16 ] | % 169

  \barNumberCheck #170
  \D gis''16 [ \D gis'16 \D gis''16 \D gis''16 \D gis'''16 \D gis''16 ] \D gis''16
  [ \D gis'16 \D gis''16 \D gis''16 \D gis'''16 \D gis''16 ] | % 170
  \D gis''16 [ \D gis'16 \D gis''16 \D gis''16 \D gis'''16 \D gis''16 ] \D gis''16
  [ \D gis'16 \D gis''16 \D gis''16 \D gis'''16 \D gis''16 ] | % 171
  \D gis''16 [ \D gis'16 \D gis''16 \D gis''16 \D gis'''16 \sustainOn \D gis''16
  ] \D gis''16 [ \D gis'16 \D gis''16 \D gis''16 <> \sustainOff \D gis'''16 \D
  gis''16 ] | % 172
  \D <cis'' e'' gis''>16 [ \D gis'16 \D <cis'' e'' gis''>16 \D gis''16 \D
  <cis''' e''' gis'''>16 \D gis''16 ] \D <cis'' e'' gis''>16 [ \D gis'16 \D
  <cis'' e'' gis''>16 \ottava #1 \D cis'''16 \D <e''' cis''''>16 \D cis'''16 ] | % 173
  \D <a''' cis''''>16 [ \D cis'''16 \D <gis''' b'''>16 \D b''16 \D <fis''' a'''>16
  \D a''16 ] \D <e''' gis'''>16 [ \D gis''16 \ottava #0 \D <cis''' e'''>16 \D
  e''16 \D <dis''' fis'''>16 \D fis''16 ] | % 174
  \D <cis''' e''' gis'''>16 [ \D gis''16 \D <cis'' e'' gis''>16 \D gis'16 \D
  <e'' gis''>16 \D gis''16 ] \D <e''' gis'''>16 [ \D gis''16 \D <e'' gis''>16 \D
  gis'16 \D <e'' gis''>16 \D gis''16 ] | % 175
  \D <e''' gis'''>16 [ \D gis''16 \D <e'' gis''>16 \D gis'16 \D <fis'' a''>16 \D
  a'16 ] \D <gis'' b''>16 [ \D b'16 \D <gis' e''>16 \D e'16 \D <a' fis''>16 \D
  fis'16 ] | % 176
  \D <b' e'' gis''>16 [ \D gis'16 \D <b' e'' gis''>16 \D gis''16 \D <b'' e'''
    gis'''>16 \D gis''16 ] \D <bis' e'' gis''>16 [ \D gis'16 \D <bis' e'' gis''>16
  \D gis''16 \D <bis''! e''' gis'''>16 \D gis''16 ] | % 177
  \D <cis'' e'' gis''>16 [ \D gis'16 \D <cis'' e'' gis''>16 \ottava #1 \D cis'''16
  \D <e''' cis''''>16 \D cis'''16 ] \D <a''' cis''''>16 [ \D cis'''16 \D <gis'''
    b'''!>16 \D b''16 \D <fis''' a'''>16 \D a''16 ] | % 178
  \D <e''' gis'''>16 [ \D gis''16 \D <e''' gis'''>16 \D gis''16 \D <e''' ais'''>16
  \D ais''!16 ] \D <e''' b'''>16 [ \D b''16 \D <dis''' fis'''>16 \D fis''16 \D
  <d''' gis'''>16 \D gis''16 ] | % 179

  \barNumberCheck #180
  \D <d''' a'''!>16 [ \D a''16 \D <cis''' e'''>16 \D e''16 \D <cis''' fis'''>16
  \D fis''16 ] \D <cis''' gis'''>16 [ \D gis''16 \D <bis'' dis'''!>16 \D dis''16
  \D <b'' eis'''>16 \D eis''!16 ] \ottava #0 | % 180
  \D <b'' fis'''>16 [ \D fis''16 \D <ais'' cis'''>16 \D cis''16 \D <a'' dis'''>16
  \D dis''16 ] \D <a'' e'''>16 [ \D e''16 \D <gis'' b''>16 \D b'16 \D <gis''
    cis'''>16 \D cis''16 ] | % 181
  \D <gis'' dis'''>16 [ \D dis''16 \D <fisis'' ais''>16 \D ais'!16 \D <fis''
    bis''>16 \D bis'!16 ] \D <fis'' cis'''>16 [ \D cis''16 \D <eis'' gis''>16 \D
  gis'16 \D <e'' ais''!>16 \D ais'16 ] | % 182
  \D <b'! dis'' b''!>8 \tweak output-attributes #'((data-sid .
  "op47-rest-0436")) r8 \U b4 \tweak output-attributes #'((data-sid .
  "op47-rest-0437")) r8 \U b8 [ | % 183
  \U b8 ] \tweak output-attributes #'((data-sid . "op47-rest-0440")) r8 \U b4
  \tweak output-attributes #'((data-sid . "op47-rest-0441")) r8 \U b8 [ | % 184
  \U b8 ] \tweak output-attributes #'((data-sid . "op47-rest-0442")) r8 \U <a!
    dis' gis'>8 [ \U b8 ] \tweak output-attributes #'((data-sid .
  "op47-rest-0443")) r8 \U <a dis' fis'>8 [ | % 185
  \U b8 ] \tweak output-attributes #'((data-sid . "op47-rest-0444")) r8 \clef
  "bass" \voiceOne \U e'8 \U e'8 [ \U dis'8 \U cis'8 \tweak output-attributes
  #'((data-sid . "op47-tie-0234")) ~ ] | % 186
  \U cis'4 \U dis'8 \tweak output-attributes #'((data-sid . "op47-tie-0236")) ~
  \U dis'4 \U cis'8 \tweak output-attributes #'((data-sid . "op47-tie-0237")) ~
  | % 187
  \U cis'4 \U b8 \tweak output-attributes #'((data-sid . "op47-tie-0238")) ~ \U
  b4. \tweak output-attributes #'((data-sid . "op47-tie-0239")) ~ | % 188
  \U b4 \clef "treble" \oneVoice \U cis'8 \U <a dis'>8 [ \U e'8 \U fis'8 ] | % 189

  \barNumberCheck #190
  \voiceOne \U <e' gis'!>4 \oneVoice \D cis''8 \slashedGrace { \U ais8 } \U <ais
    \tweak output-attributes #'((data-sid . "op47-tie-0241")) ~ e' \tweak
    output-attributes #'((data-sid . "op47-tie-0242")) ~ cis'' \tweak
    output-attributes #'((data-sid . "op47-tie-0243")) ~>4. \arpeggio | % 190
  \U <ais e' cis''>4 \U <b \tweak output-attributes #'((data-sid .
    "op47-tie-0244")) ~ e' \tweak output-attributes #'((data-sid .
    "op47-tie-0245")) ~ b' \tweak output-attributes #'((data-sid .
    "op47-tie-0246")) ~>8 \U <b e' b'>4 \U <cis' e' ais'>8 | % 191
  \voiceOne \U <cis' cis''>4 \U <b b'>8 \oneVoice \tweak output-attributes
  #'((data-sid . "op47-rest-0450")) r8 \tweak output-attributes #'((data-sid .
  "op47-rest-0451")) r8 \U c'8 \tweak output-attributes #'((data-sid .
  "op47-tie-0247")) ~ [ | % 192
  \U c'8 ] \tweak output-attributes #'((data-sid . "op47-rest-0454")) r8 \U <bes
    a'!>8 [ \U c'!8 ] \tweak output-attributes #'((data-sid . "op47-rest-0455"))
  r8 \U <bes g'>8 \bar "||" % 193
  \key as \major \U c'8 \tweak output-attributes #'((data-sid .
  "op47-rest-0456")) r8 \clef "bass" \voiceOne \U f'8 \U f'8 [ \U e'8 \U d'8
  \tweak output-attributes #'((data-sid . "op47-tie-0248")) ~ ] | % 194
  \U d'4 \U <c' \tweak output-attributes #'((data-sid . "op47-tie-0250")) ~ e'
    \tweak output-attributes #'((data-sid . "op47-tie-0251")) ~>8 \U <c' e'>4 \U
  <b \tweak output-attributes #'((data-sid . "op47-tie-0252")) ~ d'! \tweak
    output-attributes #'((data-sid . "op47-tie-0253")) ~>8 | % 195
  \U <b d'>4 \U c'8 \tweak output-attributes #'((data-sid . "op47-tie-0254")) ~
  \U c'4. \tweak output-attributes #'((data-sid . "op47-tie-0255")) ~ | % 196
  \U c'4 \clef "treble" \oneVoice \U d'8 \voiceOne \U e'8 [ \U f'8 \U g'8 ] | % 197
  \U a'4 \U d''8 \oneVoice \slashedGrace { \U b8 } \U <b \tweak
    output-attributes #'((data-sid . "op47-tie-0256")) ~ f'! \tweak
    output-attributes #'((data-sid . "op47-tie-0257")) ~ d'' \tweak
    output-attributes #'((data-sid . "op47-tie-0258")) ~>4. \arpeggio | % 198
  \U <b f' d''>4 \U <c' \tweak output-attributes #'((data-sid .
    "op47-tie-0259")) ~ f' \tweak output-attributes #'((data-sid .
    "op47-tie-0260")) ~ c'' \tweak output-attributes #'((data-sid .
    "op47-tie-0261")) ~>8 \U <c' f' c''>4 \U <des' f' b'>8 | % 199

  \barNumberCheck #200
  \voiceOne \U <f' b'>4 \U <e' c''>8 \oneVoice \tweak output-attributes
  #'((data-sid . "op47-rest-0461")) r4 \U d'8 \tweak output-attributes
  #'((data-sid . "op47-tie-0262")) ~ | % 200
  \U d'8 \tweak output-attributes #'((data-sid . "op47-rest-0463")) r8 \voiceOne
  \U <fis' bes'!>8 [ \U d'!8 ] \oneVoice \tweak output-attributes #'((data-sid .
  "op47-rest-0464")) r8 \voiceOne \U <fis' a'>8 [ | % 201
  \U d'8 ] \oneVoice \tweak output-attributes #'((data-sid . "op47-rest-0467"))
  r8 \slashedGrace { \U a'8 } \U <bes \tweak output-attributes #'((data-sid .
    "op47-tie-0264")) ~ d' \tweak output-attributes #'((data-sid .
    "op47-tie-0265")) ~ g'>8 \U <bes d' g'>8 [ \U <a! c' f'!>8 \U <g bes es'!>8
  ] | % 202
  \U <fis c'! d'>4 \U <g c' \tweak output-attributes #'((data-sid .
    "op47-tie-0266")) ~ e'>8 \U <a c' fis'>8 [ \U <bes d' g'>8 \U <c' fis' a'!>8
  ] | % 203
  \U <bes g' bes'>4 \U <es'! c''! es''!>8 \U <d' bes' d''!>4 \U <des' \tweak
    output-attributes #'((data-sid . "op47-tie-0267")) ~ g' \tweak
    output-attributes #'((data-sid . "op47-tie-0268")) ~ des''! \tweak
    output-attributes #'((data-sid . "op47-tie-0269")) ~>8 | % 204
  \voiceOne \U <des' g' des''>4 \U <des' \tweak output-attributes #'((data-sid .
    "op47-tie-0271")) ~ g' \tweak output-attributes #'((data-sid .
    "op47-tie-0272")) ~ c'' \tweak output-attributes #'((data-sid .
    "op47-tie-0273")) ~>8 \U <des' g' c''>4 \U <des' \tweak output-attributes
    #'((data-sid . "op47-tie-0274")) ~ g' \tweak output-attributes #'((data-sid
    . "op47-tie-0275")) ~ bes' \tweak output-attributes #'((data-sid .
    "op47-tie-0276")) ~>8 | % 205
  \U <des' g' bes'>4 \U <c' \tweak output-attributes #'((data-sid .
    "op47-tie-0278")) ~ as'>8 \oneVoice \slashedGrace { \U bes'8 } \U <c' es'
    as'>8 [ \U <bes des' g'>8. \U <as des' f'>16 ] | % 206
  \U <g des' es'>4 \U <as des' \tweak output-attributes #'((data-sid .
    "op47-tie-0280")) ~ f'>8 \U <bes des' es' g'>8 [ \U <c' es' \tweak
    output-attributes #'((data-sid . "op47-tie-0281")) ~ as'>8. \U <des' es' g'
    bes'>16 ] | % 207
  \U <c' as' c''>4 \D <f' des'' f''>8 \U <es' c'' es''>4 \U <d' \tweak
    output-attributes #'((data-sid . "op47-tie-0282")) ~ ces'' \tweak
    output-attributes #'((data-sid . "op47-tie-0283")) ~ d''! \tweak
    output-attributes #'((data-sid . "op47-tie-0284")) ~>8 | % 208
  \U <d' ces'' d''>4 \U <es' c''! es''>8 \D <fes' des'' fes''!>8 [ \D <f' d''
    f''!>8 \D <ges' es'' ges''!>8 ] | % 209

  \barNumberCheck #210
  \D <g'! e'' g''!>4 \D <as' f'' as''>8 \D <beses' ges'' beses''!>8 [ \D <bes'
    g'' bes''!>8. \D <ces'' as'' ces'''!>16 ] | % 210
  \D <ces'' as'' ces'''>8 \D <f'! d'' f''!>8 [ \D <ges' es'' ges''!>8 ] \D <g'
    e'' g''!>8 [ \D <as' f'' as''>8 \D <beses' ges'' beses''!>8 ] | % 211
  \D <bes'! g''! bes''!>8 [ \D <ces'' as'' ces'''!>8 \D <c'' as'' c'''!>8 ] \D
  <cis'' as'' cis'''!>8 [ \D <d'' as'' d'''!>8 \D <f'' as'' f'''>8 ] | % 212
  \ottava #1 \voiceOne \U <es'' es'''>4 \oneVoice \D <f'' f'''>8 \D <g'' des'''
    es''' g'''>8 [ \D <as'' as'''>8 \D <bes'' bes'''>8 ] | % 213
  \voiceOne \U <c''' c''''>4 \oneVoice \D <f''' f''''>8 \voiceOne \U <es'''
    es''''>4 \oneVoice \D <d''' d''''!>8 | % 214
  \voiceOne \U g'''4. \tweak output-attributes #'((data-sid . "op47-rest-0478"))
  \hideNote r8 \tweak output-attributes #'((data-sid . "op47-rest-0479"))
  \hideNote r4 | % 215
  \oneVoice \D <c''' as''' c''''>8 [ \D <as'' as'''>8 \D <f''! f'''!>8 ] \ottava
  #0 \D <es'' es'''>8 [ \D <c'' c'''>8 \tweak output-attributes #'((data-sid .
  "op47-rest-0480")) r16 \D <f' f''>16 ] | % 216
  \voiceOne \U <es' es''>4 \U f''8 \oneVoice \D <g' des'' es'' g''>8 [ \D <as'
    des'' es'' as''>8 \D <bes' des'' es'' bes''>8 ] | % 217
  \voiceOne \U <c'' c'''>4 \oneVoice \D <f'' f'''>8 \voiceOne \U <es'' es'''>4
  \oneVoice \D <d'' d'''!>8 | % 218
  \voiceOne \U g''4. \tweak output-attributes #'((data-sid . "op47-rest-0487"))
  \hideNote r8 \tweak output-attributes #'((data-sid . "op47-rest-0488"))
  \hideNote r4 | % 219

  \barNumberCheck #220
  \oneVoice \D <b' g'' b''>8 [ \D <c'' as''! c'''>8 \D <f'' f'''>8 ] \voiceOne
  \U <es'' es'''>4 \U <d'' d'''!>8 | % 220
  \U g''4. \tweak output-attributes #'((data-sid . "op47-rest-0492")) \hideNote
  r8 \tweak output-attributes #'((data-sid . "op47-rest-0493")) \hideNote r4 | % 221
  \oneVoice \D <bes' g'' bes''>8 [ \D <ces'' as''! ces'''!>8 \tweak
  output-attributes #'((data-sid . "op47-rest-0494")) r16 \ottava #1 \D <as''
    ces''' as'''>16 ] \D <as'' ces''' as'''>8 [ \D <as'' ces''' as'''>8 \D <as''
    ces''' as'''>8 ] | % 222
  \D <as'' ces''' as'''>8 [ \D <g'' bes'' g'''>8 \ottava #0 \tweak
  output-attributes #'((data-sid . "op47-rest-0495")) r16 \D <bes' g'' bes''>16
  ] \D <a' fis'' a''!>8 [ \D <bes' g'' bes''>8 \tweak output-attributes
  #'((data-sid . "op47-rest-0496")) r16 \D <g'' bes'' g'''>16 ] | % 223
  \D <g'' bes'' g'''>8 [ \D <fis'' a'' fis'''!>8 \tweak output-attributes
  #'((data-sid . "op47-rest-0498")) r16 \D <a'! fis'' a''>16 ] \D <gis' eis''
    gis''!>8 [ \D <a' fis'' a''>8 \tweak output-attributes #'((data-sid .
  "op47-rest-0499")) r16 \D <fis'' a'' fis'''>16 ] | % 224
  \D <fis'' a'' fis'''>8 \tweak output-attributes #'((data-sid .
  "op47-rest-0501")) r16 \D <a' b' dis'' a''>16 [ \D <a' b' dis'' a''>8 ] \D <a'
    b' dis'' a''>8 [ \D <a' b' dis'' b''!>8 \D <a' b' dis'' fis''>8 ] | % 225
  \D <a' b' dis'' fis''>8 [ \D <gis' e'' gis''!>8 \D <gis' dis'' gis''>8 ] \D
  <gis' d'' gis''>8 -> [ \D <ais' d'' ais''!>8 -> \D <b' d'' b''!>8 -> ] | % 226
  \D <c'' es''! as''! c'''>8 \U <es' as' c'' es''>8 [ \U <es' as' c'' es''>8 ]
  \U <es' as' c'' es''>8 [ \U <e' as' c'' e''!>8 \U <e' as' c'' e''>8 ] | % 227
  \D <e' as' c'' e''>8 [ \D <f' a' c'' f''>8 \D <f' a' c'' f''>8 ] \D <f' a' c''
    f''>8 [ \D <fis' a' c'' fis''!>8 \D <fis' a' c'' fis''>8 ] | % 228
  \D <fis' c'' es'' fis''>8 [ \D <g' des''! es'' g''>8 \D <g' des'' es'' g''>8 ]
  \D <g' des'' es'' g''>8 [ \D <as'! des'' as''!>8 \D <as' des'' as''>8 ] | % 229

  \barNumberCheck #230
  \D <as' des'' as''>8 [ \D <des'' f'' c'''>8 \D <des'' f'' c'''>8 ] \D <des''
    f'' c'''>8 [ \D <des'' es'' bes''>8 \D <des'' es'' bes''>8 ] | % 230
  \slashedGrace { \U c'8 [ \U es'8 \U as'8 \U c''8 ] } \D c'''4. \tweak
  output-attributes #'((data-sid . "op47-tie-0288")) ~ -> \D c'''16 [ \D bes''16
  \D as''16 \D g''16 \D as''16 \D fes''16 ] | % 231
  \D d''16 [ \D f''!16 \D es''16 \D c''16 \D as'16 \D f'16 ] \U es'4 -> \U <des'
    g'>8 | % 232
  \slashedGrace { \U c'8 [ \U es'8 \U as'8 \U c''8 ] } \D c'''4. \tweak
  output-attributes #'((data-sid . "op47-tie-0290")) ~ -> \D c'''16 [ \D bes''16
  \D as''16 \D g''16 \D as''16 \D fes''16 ] | % 233
  \D d''16 [ \D f''!16 \D es''16 \D c''16 \D as'16 \D f'16 ] \U es'4 -> \U <des'
    g'>8 | % 234
  \D c'16 [ \D es'16 \D as'16 \D c''16 \D c'''8 -> ] \slashedGrace { \U d''8 [
    \U es''8 \U f''8 ] } \D es''4 ^\trill \D d''16 [ \D es''16 ] | % 235
  \D c''16 [ \D es''16 \D as''16 \D c'''16 \D c''''8 -> ] \slashedGrace { \U
    d'''8 [ \U es'''8 \U f'''8 ] } \D es'''4 ^\trill \D d'''16 [ \D es'''16 ] | % 236
  \D c'''8 [ \ottava #1 \D f''''16 \D es''''16 \D c''''16 \D as'''16 ] \ottava
  #0 \D f'''16 [ \D es'''16 \D c'''16 \D as''16 \D f''16 \D es''16 ] | % 237
  \U c''16 [ \U as'16 \U f'16 \U es'16 \U c'16 \U as16 ] \tweak
  output-attributes #'((data-sid . "op47-rest-0516")) r8 \tweak
  output-attributes #'((data-sid . "op47-rest-0517")) r4 | % 238
  \tweak output-attributes #'((data-sid . "op47-rest-0520")) r4 \tweak
  output-attributes #'((data-sid . "op47-rest-0521")) r8 \U <c' e' bes' c''>4.
  -> | % 239

  \barNumberCheck #240
  \U <c' f' as' c''>4. -> \U <des' es'! g' des'' es''!>4. -> | % 240
  \D <as' c'' as''>2. -> \bar "|."
}

PartPOneVoiceTwo = {
  \clef "treble" \time 6/8 \key as \major s1. | % 2
  \D <es' g'>4. \D <es' g' des''>4. | % 3
  \D <es' as' c''>2. | % 4
  \D <g des'>4 \D as8 \D bes8 [ \D c'8 \D g8 ] s2. s4*15 s4*15 s1. | % 18
  \tweak output-attributes #'((data-sid . "op47-rest-0048")) \hideNote r4 \D
  <bes d' as'>8 \tweak output-attributes #'((data-sid . "op47-rest-0049")) r8
  \tweak output-attributes #'((data-sid . "op47-rest-0050")) r16 \D <bes d' as'>16
  [ \D <bes d' as'>8 ] | % 19

  \barNumberCheck #20
  \tweak output-attributes #'((data-sid . "op47-rest-0055")) r8 \tweak
  output-attributes #'((data-sid . "op47-rest-0056")) r16 \D <bes des'! g'>16 [
  \D <bes des' g'>8 ] \tweak output-attributes #'((data-sid . "op47-rest-0057"))
  \hideNote r8 \tweak output-attributes #'((data-sid . "op47-rest-0058"))
  \hideNote r4 s2. s2. | % 22
  \tweak output-attributes #'((data-sid . "op47-rest-0068")) \hideNote r4.
  \tweak output-attributes #'((data-sid . "op47-rest-0069")) r8 \tweak
  output-attributes #'((data-sid . "op47-rest-0070")) r16 \D <bes' d'' as''>16 [
  \D <bes' d'' as''>8 ] | % 23
  \tweak output-attributes #'((data-sid . "op47-rest-0075")) r8 \tweak
  output-attributes #'((data-sid . "op47-rest-0076")) r16 \D <bes' des''! g''>16
  [ \D <bes' des'' g''>8 ] \tweak output-attributes #'((data-sid .
  "op47-rest-0077")) \hideNote r8 \tweak output-attributes #'((data-sid .
  "op47-rest-0078")) \hideNote r4 s1. s4*15 s1*3 s4*9 | % 38
  \D <es' g'>4. \D <es' g' des''>4. | % 39

  \barNumberCheck #40
  \D <es' as' c''>2. | % 40
  \D <g des'>4 \D as8 \D bes8 [ \D c'8 \D g8 ] | % 41
  \D as8 \D a8 [ \D bes8 ] \D <c' es'>8 [ \D des'8 \D a8 ] | % 42
  \D bes8 [ \D c'8 \D des'8 ] \D <es' ges'>8 [ \D f'8 \D c'8 ] | % 43
  \D des'8 [ \D d'8 \D es'8 ] \D <f' as'>8 [ \D g'!8 \D d'8 ] s4*9 s1*6 s4*15
  s1. | % 62
  \tweak output-attributes #'((data-sid . "op47-rest-0154")) \hideNote r4 \D e'8
  [ \D f'8 ] \tweak output-attributes #'((data-sid . "op47-rest-0155"))
  \hideNote r8 \D d'8 [ | % 63
  \D as'8 ] \tweak output-attributes #'((data-sid . "op47-rest-0159")) r8 \D f'8
  [ \D g'8 ] \tweak output-attributes #'((data-sid . "op47-rest-0160")) r8 \D e'8
  \tweak output-attributes #'((data-sid . "op47-tie-0075")) ~ | % 64
  \D e'4 \D f'8 \tweak output-attributes #'((data-sid . "op47-rest-0164")) r4 \D
  as'8 \tweak output-attributes #'((data-sid . "op47-tie-0077")) ~ | % 65
  \D as'4 \D bes'8 \D as'8 \D f'4 | % 66
  \D <f' as'>8 \tweak output-attributes #'((data-sid . "op47-rest-0171"))
  \hideNote r8 \tweak output-attributes #'((data-sid . "op47-rest-0172"))
  \hideNote r2 s4*9 s4*15 s4*15 s4*15 s1. | % 87
  \tweak output-attributes #'((data-sid . "op47-rest-0231")) \hideNote r4 \D
  <ges \tweak output-attributes #'((data-sid . "op47-tie-0102")) ~ c' \tweak
    output-attributes #'((data-sid . "op47-tie-0103")) ~>8 \D <ges c'>4. | % 88
  \D des'8 [ \D c'8 \D bes8 ] \D as8 \tweak output-attributes #'((data-sid .
  "op47-rest-0235")) \hideNote r4 | % 89

  \barNumberCheck #90
  \tweak output-attributes #'((data-sid . "op47-rest-0240")) \hideNote r4 \D
  <ges \tweak output-attributes #'((data-sid . "op47-tie-0107")) ~ c' \tweak
    output-attributes #'((data-sid . "op47-tie-0108")) ~>8 \D <ges c'>4. | % 90
  \D <f des'>4 \D <f \tweak output-attributes #'((data-sid . "op47-tie-0112")) ~
    des' \tweak output-attributes #'((data-sid . "op47-tie-0113")) ~>8 \D <f
    \tweak output-attributes #'((data-sid . "op47-tie-0114")) ~ des' \tweak
    output-attributes #'((data-sid . "op47-tie-0115")) ~>4. | % 91
  \D <f des'>8 \tweak output-attributes #'((data-sid . "op47-rest-0243"))
  \hideNote r8 \D f8 \tweak output-attributes #'((data-sid . "op47-tie-0120")) ~
  \D f4. | % 92
  \D e8 \tweak output-attributes #'((data-sid . "op47-rest-0246")) \hideNote r8
  \D <f \tweak output-attributes #'((data-sid . "op47-tie-0124")) ~ b \tweak
    output-attributes #'((data-sid . "op47-tie-0125")) ~>8 \D <f b>4. | % 93
  \D e8 \tweak output-attributes #'((data-sid . "op47-rest-0249")) \hideNote r8
  \D f8 \tweak output-attributes #'((data-sid . "op47-tie-0130")) ~ \D f4. s2.
  s4*9 | % 98
  \tweak output-attributes #'((data-sid . "op47-rest-0255")) \hideNote r4.
  \tweak output-attributes #'((data-sid . "op47-rest-0256")) \hideNote r4 \D <b
    d'>8 | % 99

  \barNumberCheck #100
  \tweak output-attributes #'((data-sid . "op47-rest-0260")) \hideNote r8 \D
  des'!2 \D <des' es' \tweak output-attributes #'((data-sid . "op47-tie-0135"))
    ~>8 | % 100
  \D <c' es'>8 \tweak output-attributes #'((data-sid . "op47-rest-0263"))
  \hideNote r8 \tweak output-attributes #'((data-sid . "op47-rest-0264"))
  \hideNote r8 \D f'4 \D fis'8 | % 101
  \D g'8 \D f'2 \D <f' g' \tweak output-attributes #'((data-sid .
    "op47-tie-0137")) ~>8 | % 102
  \D <e' g'>8 \tweak output-attributes #'((data-sid . "op47-rest-0268"))
  \hideNote r8 \tweak output-attributes #'((data-sid . "op47-rest-0269"))
  \hideNote r2 s1. s4*15 s4*15 s1*3 s1*3 s1*3 s4*9 s1*3 s2. | % 135
  \tweak output-attributes #'((data-sid . "op47-rest-0340")) \hideNote r4. \D
  des''4. | % 136
  \tweak output-attributes #'((data-sid . "op47-rest-0341")) \hideNote r4. \D
  des''4. | % 137
  \tweak output-attributes #'((data-sid . "op47-rest-0342")) \hideNote r4 \D f'2
  | % 138
  \D <f' as'>4. \D <des' g'>4. | % 139

  \barNumberCheck #140
  \tweak output-attributes #'((data-sid . "op47-rest-0344")) \hideNote r4. \U
  des'''4. | % 140
  \tweak output-attributes #'((data-sid . "op47-rest-0345")) \hideNote r4. \U
  des''4. | % 141
  \tweak output-attributes #'((data-sid . "op47-rest-0346")) \hideNote r8 \D f'4
  \tweak output-attributes #'((data-sid . "op47-tie-0173")) ~ \D f'4. | % 142
  \D <f' as'>4. \tweak output-attributes #'((data-sid . "op47-rest-0347"))
  \hideNote r4. s1*3 s4*15 s1. | % 154
  \tweak output-attributes #'((data-sid . "op47-rest-0399")) \hideNote r4 \D c'8
  [ \D des'8 ] \tweak output-attributes #'((data-sid . "op47-rest-0400"))
  \hideNote r8 \D bes8 [ | % 155
  \D fes'8 ] \tweak output-attributes #'((data-sid . "op47-rest-0403"))
  \hideNote r8 \D des'8 [ \D es'8 ] \tweak output-attributes #'((data-sid .
  "op47-rest-0404")) \hideNote r8 \D c'8 \bar "||" % 156
  \tweak output-attributes #'((data-sid . "op47-rest-0406")) \hideNote r8 \tweak
  output-attributes #'((data-sid . "op47-rest-0407")) \hideNote r8 \tweak
  output-attributes #'((data-sid . "op47-rest-0408")) \hideNote r2 s4*9 s1*3
  s1*3 s1*3 s1*3 s4*9 s4*9 s4*9 | % 185
  \tweak output-attributes #'((data-sid . "op47-rest-0445")) \hideNote r4 \D gis8
  \tweak output-attributes #'((data-sid . "op47-tie-0235")) ~ \D gis4. | % 186
  \D g!4 \D e8 \D g4 \D e8 | % 187
  \D g!4. \tweak output-attributes #'((data-sid . "op47-tie-0240")) ~ \D g8 [ \D
  <fis a>8 \D <e g>8 ] | % 188
  \D <b, fis>8 \tweak output-attributes #'((data-sid . "op47-rest-0446"))
  \hideNote r8 \tweak output-attributes #'((data-sid . "op47-rest-0447"))
  \hideNote r2 | % 189

  \barNumberCheck #190
  \D gis8 \tweak output-attributes #'((data-sid . "op47-rest-0448")) \hideNote r8
  \tweak output-attributes #'((data-sid . "op47-rest-0449")) \hideNote r2 s2. | % 191
  \D dis'4. \tweak output-attributes #'((data-sid . "op47-rest-0452")) \hideNote
  r8 \tweak output-attributes #'((data-sid . "op47-rest-0453")) \hideNote r4 s2.
  \bar "||" % 193
  \tweak output-attributes #'((data-sid . "op47-rest-0457")) \hideNote r4 \D a8
  \tweak output-attributes #'((data-sid . "op47-tie-0249")) ~ \D a4. | % 194
  \D as!4 \D f8 \D as4 \D f8 | % 195
  \D as4. \D as8 [ \D <g bes!>8 \D <f as>8 ] | % 196
  \D <c g>8 \tweak output-attributes #'((data-sid . "op47-rest-0458")) \hideNote
  r4 \D des'!4. | % 197
  \D <c' fis'>4. \tweak output-attributes #'((data-sid . "op47-rest-0459"))
  \hideNote r8 \tweak output-attributes #'((data-sid . "op47-rest-0460"))
  \hideNote r4 s2. | % 199

  \barNumberCheck #200
  \D c'4. \tweak output-attributes #'((data-sid . "op47-rest-0462")) \hideNote r4.
  | % 200
  \tweak output-attributes #'((data-sid . "op47-rest-0465")) \hideNote r4 \D c'4
  \tweak output-attributes #'((data-sid . "op47-rest-0466")) \hideNote r8 \D c'8
  \tweak output-attributes #'((data-sid . "op47-tie-0263")) ~ | % 201
  \D c'8 \tweak output-attributes #'((data-sid . "op47-rest-0468")) \hideNote r8
  \tweak output-attributes #'((data-sid . "op47-rest-0469")) \hideNote r2 s2.
  s2. | % 204
  \D es'4. \D es'4. \tweak output-attributes #'((data-sid . "op47-tie-0277")) ~
  | % 205
  \D es'4. \tweak output-attributes #'((data-sid . "op47-rest-0474")) \hideNote
  r4. s2. s1. s4*9 | % 212
  \D es''8 [ \D <g'' bes'' des'''!>8 ] \tweak output-attributes #'((data-sid .
  "op47-rest-0475")) \hideNote r2 | % 213
  \D c'''8 [ \D <es''' as'''>8 ] \tweak output-attributes #'((data-sid .
  "op47-rest-0476")) \hideNote r8 \D es'''8 [ \D <as''' c''''>8 ] \tweak
  output-attributes #'((data-sid . "op47-rest-0477")) \hideNote r8 | % 214
  \D <des'''! des''''!>8 [ \D <c''' c''''>8 \D <bes'' bes'''>8 ] \oneVoice
  \slashedGrace { \D c''''8 } \D <bes'' g''' bes'''>8 [ \D <a'' fis''' a'''!>8
  \D <bes'' g''' bes'''>8 ] s2. | % 216
  \voiceTwo \D es'8 [ \D <g' des''>8 \D <f' des''>8 ] \tweak output-attributes
  #'((data-sid . "op47-rest-0482")) \hideNote r8 \tweak output-attributes
  #'((data-sid . "op47-rest-0483")) \hideNote r4 | % 217
  \D c''8 [ \D <es'' as''>8 ] \tweak output-attributes #'((data-sid .
  "op47-rest-0484")) \hideNote r8 \D es''8 [ \D <as'' c'''>8 ] \tweak
  output-attributes #'((data-sid . "op47-rest-0485")) \hideNote r8 | % 218
  \D <des''! des'''!>8 [ \D <c'' c'''>8 \D <bes' bes''>8 ] \oneVoice
  \slashedGrace { \D c'''8 } \D <bes' g'' bes''>8 [ \D <a' fis'' a''!>8 \D <bes'
    g'' bes''>8 ] | % 219

  \barNumberCheck #220
  \tweak output-attributes #'((data-sid . "op47-rest-0489")) \hideNote r4.
  \voiceTwo \D es''8 [ \D <as'' c'''>8 ] \tweak output-attributes #'((data-sid .
  "op47-rest-0490")) r8 | % 220
  \D <des''! des'''!>8 [ \D <c'' c'''>8 \D <bes' bes''>8 ] \oneVoice
  \slashedGrace { \D c'''8 } \D <bes' g'' bes''>8 [ \D <a' fis'' a''!>8 \D <bes'
    g'' bes''>8 ] s2. s4*9 s1*3 s4*9 s1*3 s4*15 \bar "|."
}

PartPOneVoiceFive = {
  \clef "bass" \time 6/8 \key as \major \oneVoice \tweak output-attributes
  #'((data-sid . "op47-rest-0001")) r4 \D d'8 \D des'8 [ \D c'8 \D g8 ] | % 1
  \D as4 \D <es b d'>8 \D <es c'>4. | % 2
  \D des'!8 [ \D c'8 \D bes!8 ] \D bes8 ^\prall [ \D a8 \D bes8 ] | % 3
  \D c'8 [ \D as!8. \D es16 ] \D es4. | % 4
  \U es,4 \U f,8 \U g,8 [ \U as,8 \U bes,8 ] | % 5
  \U c4 \D f8 \D es4. \tweak output-attributes #'((data-sid . "op47-tie-0007"))
  ~ | % 6
  \D es4. \tweak output-attributes #'((data-sid . "op47-tie-0008")) ~ \voiceOne
  \D es4 \U <des' es'>8 | % 7
  \U <es' as'>4 \U <c' es'>8 \U <c' es'>4 \tweak output-attributes #'((data-sid
  . "op47-rest-0004")) r8 | % 8
  \set Staff.pedalSustainStyle = #'bracket \oneVoice \U <as,, as,>8 \sustainOn
  \tweak output-attributes #'((data-sid . "op47-rest-0008")) r8 \clef "treble"
  \D <ges' as' es''>8 <> \sustainOff \U <f' as' d''>4 \tweak output-attributes
  #'((data-sid . "op47-rest-0009")) r8 | % 9

  \barNumberCheck #10
  \clef "bass" \U <as,, as,>8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0012")) r8 \D <fes as des'>8 <> \sustainOff \D <es as c'>4 \tweak
  output-attributes #'((data-sid . "op47-rest-0013")) r8 | % 10
  \U <es,, es,>8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0018")) r8 \D <es c'>8 <> \sustainOff \D <d f b>4 \tweak
  output-attributes #'((data-sid . "op47-rest-0019")) r8 | % 11
  \D es,8 [ \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0024")) r8 \D <d f b>8 ] <> \sustainOff \D <des g bes>4 \tweak
  output-attributes #'((data-sid . "op47-rest-0025")) r8 | % 12
  \U <as,, as,>8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0028")) r16 \clef "treble" \D <ges' as' es''>16 [ \D <ges' as'
    es''>8 ] <> \sustainOff \D <f' as' d''>4 \tweak output-attributes
  #'((data-sid . "op47-rest-0029")) r8 | % 13
  \clef "bass" \U <as,, as,>8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0032")) r16 \D <fes as des'>16 [ \D <fes as des'>8 ] <> \sustainOff
  \D <es as c'>4 \tweak output-attributes #'((data-sid . "op47-rest-0033")) r8 | % 14
  \U <es,, es,>8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0036")) r8 \D <es c'>8 <> \sustainOff \D <d f b>4 \tweak
  output-attributes #'((data-sid . "op47-rest-0037")) r8 | % 15
  \U es,8 \sustainOn \tweak output-attributes #'((data-sid . "op47-rest-0040"))
  r8 \D <d f b>8 <> \sustainOff \D <des g bes>4 \tweak output-attributes
  #'((data-sid . "op47-rest-0041")) r8 | % 16
  \D <as,, as,>8 [ \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0042")) r8 \D <c ges as>8 ] <> \sustainOff \D <b, f as>4. | % 17
  \D <as,, as,>8 [ \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0047")) r8 \D <as, es bes!>8 ] <> \sustainOff \D <as, es as>4. | % 18
  \U <f,, f,>8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0051")) r8 <> \sustainOff \U <g,! g!>8 \U <f, f>4 \tweak
  output-attributes #'((data-sid . "op47-rest-0052")) r8 | % 19

  \barNumberCheck #20
  \U <es,, es,>8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0059")) r8 <> \sustainOff \U <f, f>8 \U <es, es>4 \tweak
  output-attributes #'((data-sid . "op47-rest-0060")) r8 | % 20
  \U <as,, as,>8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0062")) r16 \D <ges as ges'!>16 [ \D <ges as ges'>8 ] <>
  \sustainOff \D <f as f'>4 \tweak output-attributes #'((data-sid .
  "op47-rest-0063")) r8 | % 21
  \U <as,, as,>8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0066")) r16 \D <fes as fes'!>16 [ \D <fes as fes'>8 ] <>
  \sustainOff \D <es as es'>4 \tweak output-attributes #'((data-sid .
  "op47-rest-0067")) r8 | % 22
  \U <f,, f,>8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0071")) r16 \D <g g'>16 [ \D <g g'>8 ] <> \sustainOff \D <f f'>4
  \tweak output-attributes #'((data-sid . "op47-rest-0072")) r8 | % 23
  \U <es,, es,>8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0079")) r16 \D <f f'>16 [ \D <f f'>8 ] <> \sustainOff \D <es es'>4
  \tweak output-attributes #'((data-sid . "op47-rest-0080")) r8 | % 24
  \U <as,, as,>8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0082")) r16 \D <ges ges'!>16 [ \D <ges ges'>8 ] <> \sustainOff \D
  <ges ges'>4. \sustainOn | % 25
  \D <bes c' es'>4. <> \sustainOff \D es'16 [ \sustainOn \D c'16 \D a16 \D f16
  \D f,8 ] <> \sustainOff | % 26
  \U <bes,, bes,>8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0084")) r16 \D <as d' f'>16 [ \D <as d' f'>8 ] <> \sustainOff \D
  <as d' f'>8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0085")) r16 \U <b,, b,!>16 [ \U <b,, b,>8 ] | % 27
  \U <b,, b,>4. <> \sustainOff \D f'16 [ \sustainOn \D d'16 \D b!16 \D g16 \D g,8
  ] <> \sustainOff | % 28
  \U <c, c>8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0087")) r8 \D <g e'>8 <> \sustainOff \D f'16 [ \sustainOn \D d'16
  \D b16 \D g16 \D g,8 ] <> \sustainOff | % 29

  \barNumberCheck #30
  \U <c, c>8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0089")) r8 \D <g e'>8 <> \sustainOff \D f'16 [ \sustainOn \D d'16
  \D b16 \D g16 \D g,8 ] <> \sustainOff | % 30
  \U <c, c>8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0091")) r8 \D <g e'>8 <> \sustainOff \D f'16 [ \sustainOn \D d'16
  \D b16 \D g16 \D g,8 ] <> \sustainOff | % 31
  \U <c, c>8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0093")) r8 \D <g e'>8 <> \sustainOff \D f'16 [ \sustainOn \D d'16
  \D b16 \D g16 \D g,8 ] <> \sustainOff | % 32
  \U <c, c>8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0094")) r8 \tweak output-attributes #'((data-sid .
  "op47-rest-0095")) r8 \D <c \tweak output-attributes #'((data-sid .
    "op47-tie-0024")) ~ g \tweak output-attributes #'((data-sid .
    "op47-tie-0025")) ~ e' \tweak output-attributes #'((data-sid .
    "op47-tie-0026")) ~>4. \arpeggio | % 33
  \D <c g e'>4. <> \sustainOff \voiceOne \U f'4 \U e'!8 \sustainOn | % 34
  \oneVoice \D <c e c'>4 \tweak output-attributes #'((data-sid .
  "op47-rest-0097")) r2 | % 35
  \U <c,, c,>4. <> \sustainOff \U <c,, c,>8 [ \U <des,,! des,!>8 \U <d,, d,!>8 ]
  | % 36
  \U <es,, es,>8 \tweak output-attributes #'((data-sid . "op47-rest-0099")) r8
  \D d'8 \D des'8 [ \D c'8 \D g8 ] | % 37
  \D as4 \D <es b d'>8 \D <es c'>4. | % 38
  \D des'!8 [ \D c'8 \D bes!8 ] \D bes8 ^\prall [ \D a8 \D bes8 ] | % 39

  \barNumberCheck #40
  \D c'8 [ \D as!8. \D es16 ] \D es4. | % 40
  \U es,4 \U f,8 \U g,8 [ \U as,8 \U bes,8 ] | % 41
  \U c8 \U f,8 [ \U g,8 ] \U a,8 [ \U bes,8 \U c8 ] | % 42
  \D des8 \U as,!8 [ \U bes,8 ] \D c8 [ \D des8 \D es8 ] | % 43
  \D f8 \U bes,8 [ \U c8 ] \D d8 [ \D es8 \D f8 ] | % 44
  \tweak output-attributes #'((data-sid . "op47-rest-0100")) \hideNote r4
  \voiceOne \U d'8 \U <des' es'>8 [ \U <c' es'>8 \U <g es'>8 ] | % 45
  \U <as es'>4 \sustainOn \clef "treble" \oneVoice \U <es' b' d''>8 <>
  \sustainOff \U <es' c''>4 \D <es'' b''! d'''!>8 | % 46
  \D <es'' c'''>4 \tweak output-attributes #'((data-sid . "op47-rest-0105")) r8
  \clef "bass" \U <es,, \tweak output-attributes #'((data-sid .
    "op47-tie-0037")) ~ es, \tweak output-attributes #'((data-sid .
    "op47-tie-0038")) ~>4. \sustainOn | % 47
  \D <es,, es,>8 [ <> \sustainOff \D as,,8 \D bes,,8 ] \U c,4 \U bes,,8 | % 48
  \U c,4 \U as,,8 \U <as,, as,>4. \sustainOn | % 49

  \barNumberCheck #50
  \clef "treble" \U <c' \tweak output-attributes #'((data-sid .
    "op47-tie-0041")) ~ es' \tweak output-attributes #'((data-sid .
    "op47-tie-0042")) ~ as' \tweak output-attributes #'((data-sid .
    "op47-tie-0043")) ~ c'' \tweak output-attributes #'((data-sid .
    "op47-tie-0044")) ~>2. | % 50
  \U <c' \tweak output-attributes #'((data-sid . "op47-tie-0047")) ~ es' \tweak
    output-attributes #'((data-sid . "op47-tie-0048")) ~ as' \tweak
    output-attributes #'((data-sid . "op47-tie-0049")) ~ c'' \tweak
    output-attributes #'((data-sid . "op47-tie-0050")) ~>2. | % 51
  \U <c' es' as' c''>8 \tweak output-attributes #'((data-sid .
  "op47-rest-0111")) r8 <> \sustainOff \tweak output-attributes #'((data-sid .
  "op47-rest-0112")) r2 | % 52
  \tweak output-attributes #'((data-sid . "op47-rest-0115")) R2. | % 53
  \clef "bass" \U c,8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0118")) r8 \D <g c' f'>8 [ \D c8 ] <> \sustainOff \tweak
  output-attributes #'((data-sid . "op47-rest-0119")) r8 \D <g c' e'>8 [
  \sustainOn | % 54
  \D f8 ] <> \sustainOff \tweak output-attributes #'((data-sid .
  "op47-rest-0121")) r8 \D <c' f'>8 [ \sustainOn \D d8 ] \tweak
  output-attributes #'((data-sid . "op47-rest-0122")) r8 \D <a c'>8 | % 55
  \U g,8 <> \sustainOff \tweak output-attributes #'((data-sid .
  "op47-rest-0125")) r8 \D <d g c'>8 [ \sustainOn \D g,8 ] <> \sustainOff \tweak
  output-attributes #'((data-sid . "op47-rest-0126")) r8 \U <g b>8 [ | % 56
  \U c,8 ] \sustainOn \tweak output-attributes #'((data-sid . "op47-rest-0128"))
  r8 \D <g c' \tweak output-attributes #'((data-sid . "op47-tie-0056")) ~>8 <>
  \sustainOff \voiceOne \U c'4. | % 57
  \U <g c'>8 \sustainOn \oneVoice \tweak output-attributes #'((data-sid .
  "op47-rest-0133")) r8 \D <g c' f'>8 [ \D c8 ] <> \sustainOff \tweak
  output-attributes #'((data-sid . "op47-rest-0134")) r8 \D <g c' e'>8 [ | % 58
  \D f8 ] \tweak output-attributes #'((data-sid . "op47-rest-0138")) r8
  \sustainOn \D <c' f'>8 [ \D d8 ] <> \sustainOff \tweak output-attributes
  #'((data-sid . "op47-rest-0139")) r8 \D <a c'>8 [ | % 59

  \barNumberCheck #60
  \D g,8 ] \tweak output-attributes #'((data-sid . "op47-rest-0142")) r8
  \sustainOn \D <d g c'>8 [ \D g,8 ] <> \sustainOff \tweak output-attributes
  #'((data-sid . "op47-rest-0143")) r8 \D <g b>8 | % 60
  \U c,8 \sustainOn \tweak output-attributes #'((data-sid . "op47-rest-0145")) r8
  \D <g c' \tweak output-attributes #'((data-sid . "op47-tie-0063")) ~>8 <>
  \sustainOff \voiceOne \U c'4. | % 61
  \U <g c'>8 \sustainOn \oneVoice \tweak output-attributes #'((data-sid .
  "op47-rest-0149")) r8 \D <g c' \tweak output-attributes #'((data-sid .
    "op47-tie-0070")) ~>8 <> \sustainOff \voiceOne \U c'4. | % 62
  \U <g c'>8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0156")) r8 \U <g c'>8 <> \sustainOff \tweak output-attributes
  #'((data-sid . "op47-rest-0157")) \hideNote r4 \sustainOn \U <as c'>8 | % 63
  \tweak output-attributes #'((data-sid . "op47-rest-0161")) \hideNote r4 \U <as
    d'>8 <> \sustainOff \tweak output-attributes #'((data-sid .
  "op47-rest-0162")) \hideNote r4 \sustainOn \U <bes c'>8 <> \sustainOff | % 64
  \oneVoice \U f,8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0165")) r8 \D <c as c'>8 [ \D f,8 ] <> \sustainOff \tweak
  output-attributes #'((data-sid . "op47-rest-0166")) r8 \D <f c' f'>8
  \sustainOn | % 65
  \U f,8 \tweak output-attributes #'((data-sid . "op47-rest-0167")) r8 \D <f
    des' f'>8 [ \D f,8 ] <> \sustainOff \tweak output-attributes #'((data-sid .
  "op47-rest-0168")) r8 \sustainOn \D <f c'>8 [ | % 66
  \D <f, f>8 ] <> \sustainOff \tweak output-attributes #'((data-sid .
  "op47-rest-0173")) r8 \U <fes, fes!>8 [ \U es,8 ] \tweak output-attributes
  #'((data-sid . "op47-rest-0174")) r8 \sustainOn \D <es c'>8 [ | % 67
  \D es,8 ] \tweak output-attributes #'((data-sid . "op47-rest-0176")) r8 <>
  \sustainOff \D <es c'>8 [ \D es,8 ] \sustainOn \tweak output-attributes
  #'((data-sid . "op47-rest-0177")) r16 \D <es c'>16 [ <> \sustainOff \D <es
    \tweak output-attributes #'((data-sid . "op47-tie-0079")) ~ bes>8 ] | % 68
  \D <as, es as>8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0180")) r8 <> \sustainOff \D <g, g>8 [ \D f,8 ] \tweak
  output-attributes #'((data-sid . "op47-rest-0181")) r8 \sustainOn \D <c as c'>8
  [ | % 69

  \barNumberCheck #70
  \D f,8 ] <> \sustainOff \tweak output-attributes #'((data-sid .
  "op47-rest-0182")) r8 \D <f c' f'>8 [ \sustainOn \D f,8 ] \tweak
  output-attributes #'((data-sid . "op47-rest-0183")) r8 <> \sustainOff \D <f
    des' f'>8 | % 70
  \D <f c' f'>8 \sustainOn \voiceOne \U c'4 \tweak output-attributes
  #'((data-sid . "op47-rest-0185")) \hideNote r8 \sustainOn \tweak
  output-attributes #'((data-sid . "op47-rest-0186")) \hideNote r4 | % 71
  \oneVoice \D es8 [ \sustainOn \D d8 -. <> \sustainOff \D c8 ] \U g,4. | % 72
  \U c,8 \sustainOn \tweak output-attributes #'((data-sid . "op47-rest-0190")) r8
  \D <bes c' g'>8 \U c8 <> \sustainOff \tweak output-attributes #'((data-sid .
  "op47-rest-0191")) r8 \D <as c' f'>8 \sustainOn | % 73
  \U c8 <> \sustainOff \tweak output-attributes #'((data-sid .
  "op47-rest-0193")) r8 \D <g bes es'!>8 \sustainOn \U c8 \tweak
  output-attributes #'((data-sid . "op47-rest-0194")) r8 \D <f as des'>8 | % 74
  \U c8 <> \sustainOff \tweak output-attributes #'((data-sid .
  "op47-rest-0196")) r8 \sustainOn \D <bes c' g'>8 \U c8 <> \sustainOff \tweak
  output-attributes #'((data-sid . "op47-rest-0197")) r8 \D <as c' f'>8
  \sustainOn | % 75
  \U c8 <> \sustainOff \tweak output-attributes #'((data-sid .
  "op47-rest-0198")) r8 \D <g bes es'!>8 [ \sustainOn \D c8 ] \tweak
  output-attributes #'((data-sid . "op47-rest-0199")) r8 \D <f as des'>8 [ | % 76
  \D c8 ] <> \sustainOff \tweak output-attributes #'((data-sid .
  "op47-rest-0201")) r8 \D <es c'>8 [ \sustainOn \D c8 ] <> \sustainOff \tweak
  output-attributes #'((data-sid . "op47-rest-0202")) r8 \D <f c' d'>8 [
  \sustainOn | % 77
  \D c8 ] <> \sustainOff \tweak output-attributes #'((data-sid .
  "op47-rest-0203")) r8 \D <as c' f'>8 [ \sustainOn \D c8 ] <> \sustainOff
  \tweak output-attributes #'((data-sid . "op47-rest-0204")) r8 \D <g c' e'>8 [
  \sustainOn | % 78
  \D c8 ] <> \sustainOff \tweak output-attributes #'((data-sid .
  "op47-rest-0205")) r8 \D <f c' d'>8 [ \sustainOn \D c8 ] <> \sustainOff \tweak
  output-attributes #'((data-sid . "op47-rest-0206")) r8 \D <g c' e'>8 [
  \sustainOn | % 79

  \barNumberCheck #80
  \D c8 ] <> \sustainOff \tweak output-attributes #'((data-sid .
  "op47-rest-0207")) r8 \D <bes c' as'>8 [ \sustainOn \D <c, c>8 ] <>
  \sustainOff \tweak output-attributes #'((data-sid . "op47-rest-0208")) r8 \D
  <g bes c' g'>8 | % 80
  \U <f,, f,>8 [ \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0210")) r8 \D <f as c' f'>8 ] \D <f, f>8 [ \tweak output-attributes
  #'((data-sid . "op47-rest-0211")) r8 \D <f as c' f'>8 ] <> \sustainOff | % 81
  \D <f, f>8 [ \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0212")) r8 \D <f bes des' f'>8 ] <> \sustainOff \D <f, f>8 [
  \sustainOn \tweak output-attributes #'((data-sid . "op47-rest-0213")) r8 \D <c
    c'>8 ] <> \sustainOff | % 82
  \U <f, f>8 [ \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0216")) r8 <> \sustainOff \U <fes, fes!>8 ] \D <es, es>8 [
  \sustainOn \tweak output-attributes #'((data-sid . "op47-rest-0217")) r8 \D
  <es as c' es'>8 ] | % 83
  \D <es, es>8 [ \tweak output-attributes #'((data-sid . "op47-rest-0220")) r16
  \D <as c' f'>16 <> \sustainOff \D <es as c' es'>8 ] \D <es, es>8 [ \sustainOn
  \tweak output-attributes #'((data-sid . "op47-rest-0221")) r16 \D <es c' es'>16
  <> \sustainOff \D <es g des' es'>8 ] | % 84
  \D <as, as>8 [ \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0224")) r8 <> \sustainOff \D <g, g>8 ] \D <f, f>8 [ \sustainOn
  \tweak output-attributes #'((data-sid . "op47-rest-0225")) r8 \D <c f as c'>8
  ] | % 85
  \U <f,, f,>8 \tweak output-attributes #'((data-sid . "op47-rest-0227")) r8 \D
  <f as f'>8 \slashedGrace { \U <g g'>8 } \D <f as f'>8 [ <> \sustainOff \D <fes
    as fes'!>8 \D <es as es'>8 ] | % 86
  \D <d as d'>8 \tweak output-attributes #'((data-sid . "op47-rest-0229")) r16
  \D <des as des'!>16 [ \D <c as c'>8 ] \D <c as c'>8 [ \D <g, c g>8 \D <bes, c
    bes>8 ] | % 87
  \D <as, c as>8 \tweak output-attributes #'((data-sid . "op47-rest-0232")) r8
  \U <as,, \tweak output-attributes #'((data-sid . "op47-tie-0104")) ~ as,
    \tweak output-attributes #'((data-sid . "op47-tie-0105")) ~>8 \U <as,, as,>4.
  | % 88
  \U <des, des>4 \tweak output-attributes #'((data-sid . "op47-rest-0236")) r8
  \tweak output-attributes #'((data-sid . "op47-rest-0237")) r4 \tweak
  output-attributes #'((data-sid . "op47-rest-0238")) r8 | % 89

  \barNumberCheck #90
  \tweak output-attributes #'((data-sid . "op47-rest-0241")) r4 \U <as,, \tweak
    output-attributes #'((data-sid . "op47-tie-0109")) ~ as, \tweak
    output-attributes #'((data-sid . "op47-tie-0110")) ~>8 \U <as,, as,>4. | % 90
  \U <des, des>4 \U <g,,! \tweak output-attributes #'((data-sid .
    "op47-tie-0116")) ~ g,! \tweak output-attributes #'((data-sid .
    "op47-tie-0117")) ~>8 \U <g,, g,>4. | % 91
  \U <g,, g,>8 \tweak output-attributes #'((data-sid . "op47-rest-0244")) r8 \U
  <g,, g,>8 \U <g,, g,>8 [ \U <as,, as,>8 \U <bes,, bes,>8 ] | % 92
  \U <c, c>8 \tweak output-attributes #'((data-sid . "op47-rest-0247")) r8 \U
  <g,, \tweak output-attributes #'((data-sid . "op47-tie-0126")) ~ g, \tweak
    output-attributes #'((data-sid . "op47-tie-0127")) ~>8 \U <g,, g,>4. | % 93
  \U <c, g,>8 \tweak output-attributes #'((data-sid . "op47-rest-0250")) r8
  \voiceOne \U g,8 \tweak output-attributes #'((data-sid . "op47-tie-0131")) ~
  \sustainOn \U g,4. | % 94
  \oneVoice \U c,4. \voiceOne \U c4. | % 95
  \U f4 \U g8 \U c'4 \U bes8 | % 96
  \oneVoice \D <c g bes c'>4 \D <c g bes d'>8 \D <c g bes f'>4 \D <c g bes e'>8
  | % 97
  \D <c f bes d'>4 \D <c g bes e'>8 \D <c bes c' as'>4 \D <bes c' g'>8 | % 98
  \D <f c' f'>8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0257")) r8 <> \sustainOff \tweak output-attributes #'((data-sid .
  "op47-rest-0258")) r8 \tweak output-attributes #'((data-sid .
  "op47-rest-0259")) r4 \U <fes, fes!>8 | % 99

  \barNumberCheck #100
  \voiceOne \change Staff="1" \D <c' es'>8 [ \sustainOn \change Staff="2" \U
  bes!8 \U as8 ] <> \sustainOff \U g8 [ \U f8 \U g8 ] | % 100
  \tweak output-attributes #'((data-sid . "op47-rest-0265")) \hideNote r4. \U d'4
  \U es'8 | % 101
  \U es'8 [ \U d'8 \U c'8 ] \U b8 [ \U a8 \U b8 ] | % 102
  \U c'8 \sustainOn \oneVoice \tweak output-attributes #'((data-sid .
  "op47-rest-0270")) r8 \tweak output-attributes #'((data-sid .
  "op47-rest-0271")) r8 \tweak output-attributes #'((data-sid .
  "op47-rest-0272")) r4 \tweak output-attributes #'((data-sid .
  "op47-rest-0273")) r8 | % 103
  \tweak output-attributes #'((data-sid . "op47-rest-0278")) R2. | % 103
  <> \sustainOff | % 104
  \once \set Staff.forceClef = ##t \clef "bass" \U c,8 \sustainOn \tweak
  output-attributes #'((data-sid . "op47-rest-0281")) r8 \D <g c' f'>8 [ \D c8 ]
  <> \sustainOff \tweak output-attributes #'((data-sid . "op47-rest-0282")) r8
  \D <g c' e'>8 | % 105
  \D f8 \tweak output-attributes #'((data-sid . "op47-rest-0284")) r8 \sustainOn
  \D <c' f'>8 [ \D d8 ] \tweak output-attributes #'((data-sid .
  "op47-rest-0285")) r8 <> \sustainOff \D <a c'>8 [ | % 106
  \D g,8 ] \tweak output-attributes #'((data-sid . "op47-rest-0288")) r8
  \sustainOn \D <d g c'>8 [ \D g,8 ] <> \sustainOff \tweak output-attributes
  #'((data-sid . "op47-rest-0289")) r8 \U <g b>8 [ | % 107
  \U c,8 ] \sustainOn \tweak output-attributes #'((data-sid . "op47-rest-0291"))
  r8 \D <g c' \tweak output-attributes #'((data-sid . "op47-tie-0143")) ~>8 <>
  \sustainOff \voiceOne \U c'4. | % 108
  \U <g c'>8 \sustainOn \oneVoice \tweak output-attributes #'((data-sid .
  "op47-rest-0296")) r8 \D <g d'>8 [ \D c8 ] <> \sustainOff \tweak
  output-attributes #'((data-sid . "op47-rest-0297")) r8 \D <g e'>8 [ | % 109

  \barNumberCheck #110
  \D f8 ] \tweak output-attributes #'((data-sid . "op47-rest-0301")) r8
  \sustainOn \D <c' f'>8 [ \D d8 ] <> \sustainOff \tweak output-attributes
  #'((data-sid . "op47-rest-0302")) r8 \D <c' a'>8 | % 110
  \U g,8 \tweak output-attributes #'((data-sid . "op47-rest-0305")) r8
  \sustainOn \D <d a>8 [ \D g,8 ] <> \sustainOff \tweak output-attributes
  #'((data-sid . "op47-rest-0306")) r8 \U <d b>8 [ | % 111
  \U c,8 ] \sustainOn \tweak output-attributes #'((data-sid . "op47-rest-0308"))
  r8 \D <g c' \tweak output-attributes #'((data-sid . "op47-tie-0150")) ~>8 <>
  \sustainOff \voiceOne \U c'4. | % 112
  \U <g c'>8 \sustainOn \oneVoice \tweak output-attributes #'((data-sid .
  "op47-rest-0312")) r8 \D <g c' \tweak output-attributes #'((data-sid .
    "op47-tie-0156")) ~>8 <> \sustainOff \voiceOne \U c'4. | % 113
  \U <g c'>4 \oneVoice \D <g c'>8 \U c4 \D <g c'>8 | % 114
  \U c4 \D <g c'>8 \U c4 \D <g c'>8 | % 115
  \U as,8 \sustainOn \tweak output-attributes #'((data-sid . "op47-rest-0320"))
  r8 \D <es as es'>8 \D <fes as fes'!>4. <> \sustainOff | % 116
  \U as,,8 \sustainOn \tweak output-attributes #'((data-sid . "op47-rest-0321"))
  r8 \D es8 \voiceOne \U c'4 <> \sustainOff \U bes8 | % 117
  \oneVoice \U as,8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0323")) r8 \D <es c' as'>8 \arpeggio <> \sustainOff \D <fes c' as'>4.
  \arpeggio \sustainOn <> \sustainOff | % 118
  \U as,8 \tweak output-attributes #'((data-sid . "op47-rest-0324")) r8 \D f8 \D
  <f c'>4 \D <bes, as>8 | % 119

  \barNumberCheck #120
  \U es,8 \sustainOn \tweak output-attributes #'((data-sid . "op47-rest-0325"))
  r8 \D <bes, g es'>8 \arpeggio <> \sustainOff \D <ces g es'>4. \arpeggio
  \sustainOn <> \sustainOff | % 120
  \U es,,8 \sustainOn \tweak output-attributes #'((data-sid . "op47-rest-0326"))
  r8 \U bes,8 \voiceOne \U g4 <> \sustainOff \U f8 | % 121
  \oneVoice \U es,8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0328")) r8 \D <es bes bes'>8 \arpeggio <> \sustainOff \D <es ces'
    ces''!>4. \arpeggio \sustainOn <> \sustainOff | % 122
  \U es,8 \sustainOn \tweak output-attributes #'((data-sid . "op47-rest-0329"))
  r8 \D es8 \clef "treble" \U <bes es' g' des''>4 \arpeggio \tweak
  output-attributes #'((data-sid . "op47-rest-0330")) r8 <> \sustainOff | % 123
  \clef "bass" \U as,8 \D <es c' es'>4 \U bes,8 \sustainOn \D <es g es'>4 <>
  \sustainOff | % 124
  \U c8 \D <es as es'>4 \U g,8 \sustainOn \D <es bes es'>4 <> \sustainOff | % 125
  \U as,8 \tweak output-attributes #'((data-sid . "op47-rest-0331")) r8 \tweak
  output-attributes #'((data-sid . "op47-rest-0332")) r8 \voiceOne \U ges'4 \U
  d'8 | % 126
  \U es'4. \U e'4. | % 127
  \oneVoice \D des8 \D <as f' as'>4 \D es8 \D <as c' as'>4 | % 128
  \D f8 \D <as des' as'>4 \U c8 \D <as es' as'>4 | % 129

  \barNumberCheck #130
  \U des,8 \tweak output-attributes #'((data-sid . "op47-rest-0334")) r8 \tweak
  output-attributes #'((data-sid . "op47-rest-0335")) r8 \clef "treble"
  \voiceOne \U <f' as'>4. | % 130
  \U <f' as'>2. | % 131
  \clef "bass" \oneVoice \D des8 \sustainOn \tweak output-attributes
  #'((data-sid . "op47-rest-0337")) r8 \clef "treble" \U <f' as' bes'>8 \U <f'
    as' bes'>8 \tweak output-attributes #'((data-sid . "op47-rest-0338")) r16 \U
  <f' as' c''>16 [ \U <as' bes' des''>8 ] | % 132
  \D <as' bes' des''>4 \U <as bes des' f'>8 \U <as bes des' f'>4 \tweak
  output-attributes #'((data-sid . "op47-rest-0339")) r8 <> \sustainOff | % 133
  \clef "bass" \U <des, des>8 \sustainOn \D <bes f'>8 [ \D f8 ] <> \sustainOff
  \U c8 \sustainOn \D <a es'>8 [ \D f8 ] <> \sustainOff | % 134
  \U bes,8 \sustainOn \D <bes des'>8 [ \D f8 ] <> \sustainOff \D des8 \sustainOn
  \D <bes f'>8 [ \D as8 ] <> \sustainOff | % 135
  \D es,16 [ \sustainOn \D bes,16 \D es16 \D g16 \D es16 \D bes,16 ] \D f,16 [
  \sustainOn <> \sustainOff \D as,16 \D des16 \D as16 \D des16 \D as,16 ] <>
  \sustainOff | % 136
  \D g,16 [ \sustainOn \D des16 \D es16 \D bes16 \D es16 \D des16 ] \D f,16 [
  \sustainOn <> \sustainOff \D as,16 \D des16 \D as16 \D des16 \D as,16 ] <>
  \sustainOff | % 137
  \D g,16 [ \sustainOn \D des16 \D es16 \D bes16 \D es16 \D des16 ] <>
  \sustainOff \D a,16 [ \sustainOn \D es16 \D f16 \D c'16 \D f16 \D es16 ] <>
  \sustainOff | % 138
  \D bes,16 [ \sustainOn \D f16 \D as16 \D des'16 \D as16 \D f16 ] <>
  \sustainOff \D es,16 [ \sustainOn \D bes,16 \D es16 \D g16 \D es16 \D bes,16 ]
  <> \sustainOff | % 139

  \barNumberCheck #140
  \D f,16 [ \sustainOn \D as,16 \D des16 \D f16 \D as16 \D des'16 ] <>
  \sustainOff \D f'16 [ \sustainOn \D des'16 \D as16 \D f16 \D des16 \D as,16 ]
  <> \sustainOff | % 140
  \D g,16 [ \sustainOn \D des16 \D es16 \D des'16 \D es16 \D des16 ] <>
  \sustainOff \D f,16 [ \sustainOn \D des16 \D as16 \D des'16 \D as16 \D des16 ]
  <> \sustainOff | % 141
  \D g,16 [ \sustainOn \D es16 \D bes16 \D des'16 \D bes16 \D es16 ] <>
  \sustainOff \D a,16 [ \sustainOn \D es16 \D f16 \D c'16 \D f16 \D es16 ] <>
  \sustainOff | % 142
  \D bes,16 [ \sustainOn \D f16 \D as16 \D des'16 \D as16 <> \sustainOff \D f16
  ] \tweak output-attributes #'((data-sid . "op47-rest-0348")) \hideNote r4
  \sustainOn \voiceOne \U es8 \tweak output-attributes #'((data-sid .
  "op47-tie-0174")) ~ <> \sustainOff | % 143
  \U <es as>8 \oneVoice \tweak output-attributes #'((data-sid .
  "op47-rest-0352")) r8 \tweak output-attributes #'((data-sid .
  "op47-rest-0353")) r8 \tweak output-attributes #'((data-sid .
  "op47-rest-0354")) r4 \tweak output-attributes #'((data-sid .
  "op47-rest-0355")) r8 | % 144
  \tweak output-attributes #'((data-sid . "op47-rest-0360")) R2. | % 145
  \U as,,8 \sustainOn \tweak output-attributes #'((data-sid . "op47-rest-0363"))
  r8 \D <es as des'>8 \U as,8 <> \sustainOff \tweak output-attributes
  #'((data-sid . "op47-rest-0364")) r8 \D <es as c'>8 \sustainOn | % 146
  \D des8 <> \sustainOff \tweak output-attributes #'((data-sid .
  "op47-rest-0366")) r8 \D <as des'>8 \sustainOn \U bes,8 \tweak
  output-attributes #'((data-sid . "op47-rest-0367")) r8 \D <f as>8 | % 147
  \key as \major \U es,8 <> \sustainOff \tweak output-attributes #'((data-sid .
  "op47-rest-0370")) r8 \D <es as>8 [ \D es,8 ] \tweak output-attributes
  #'((data-sid . "op47-rest-0371")) r8 \U <es g!>8 [ | % 148
  \U as,,8 ] \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0373")) r8 \D <es as \tweak output-attributes #'((data-sid .
    "op47-tie-0179")) ~>8 <> \sustainOff \voiceOne \U as4. | % 149

  \barNumberCheck #150
  \U <es as>8 \sustainOn \oneVoice \tweak output-attributes #'((data-sid .
  "op47-rest-0378")) r8 \D <es bes>8 [ \D as,8 ] <> \sustainOff \tweak
  output-attributes #'((data-sid . "op47-rest-0379")) r8 \D <es c'>8 [ | % 150
  \D des8 ] \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0383")) r8 \D <as des'>8 [ \D bes,8 ] <> \sustainOff \tweak
  output-attributes #'((data-sid . "op47-rest-0384")) r8 \D <as f'>8 [ | % 151
  \D es,8 ] \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0387")) r8 \U <bes, f>8 [ <> \sustainOff \U es,8 ] \sustainOn
  \tweak output-attributes #'((data-sid . "op47-rest-0388")) r8 \D <bes, g!>8 <>
  \sustainOff | % 152
  \U as,,8 \sustainOn \tweak output-attributes #'((data-sid . "op47-rest-0390"))
  r8 \D <es as \tweak output-attributes #'((data-sid . "op47-tie-0186")) ~>8
  \voiceOne \U as4. | % 153
  \U <es as>8 \sustainOn \oneVoice \tweak output-attributes #'((data-sid .
  "op47-rest-0394")) r8 \D <es as \tweak output-attributes #'((data-sid .
    "op47-tie-0192")) ~>8 \voiceOne \U as4. | % 154
  \oneVoice \U as,4 \sustainOn \D <es as>8 <> \sustainOff \U as,4 \sustainOn \D
  <fes as>8 | % 155
  \U as,4 \D <fes bes>8 <> \sustainOff \U as,4 \sustainOn \D ges8 <> \sustainOff
  \bar "||" % 156
  \key e \major \U cis,8 \U bis,,16 [ \U cis,16 \U fis,16 \U e,16 ] \U dis,16 [
  \U e,16 \U a,16 \U gis,16 \U fisis,16 \U gis,16 ] | % 157
  \D dis16 [ \D cis16 \D bis,16 \D cis16 \D cisis16 \D dis16 ] \D e16 [ \D eis16
  \D fis16 \D fisis16 \D gis16 \D a16 ] | % 158
  \D <cis gis>8 \D bis16 [ \D cis'16 \D dis'16 \D cis'16 ] \D b16 [ \D c'16 \D
  d'16 \D c'16 \D d'16 \D c'16 ] | % 159

  \barNumberCheck #160
  \D ais16 [ \D b16 \D cis'!16 \D b16 \D cis'16 \D b16 ] \U b,8 [ \U cis16 \U b,16
  \U cis16 \U b,16 ] | % 160
  \U e,8 [ \U a,16 \U gis,16 \U dis,16 \U gis,16 ] \U cis,16 [ \U gis,16 \U
  fisis,16 \U gis,16 \U dis16 \U cis16 ] | % 161
  \D bis,16 [ \D cis16 \D fis16 \D e16 \D dis16 \D e16 ] \D a16 [ \D gis16 \D
  fisis16 \D gis16 \D dis'16 \D cis'16 ] | % 162
  \D bis16 [ \D cis'16 \D cisis'16 \D dis'16 \D fis'16 \D e'16 ] \D cisis'16 [
  \D dis'16 \D e'16 \D dis'16 \D cis'16 \D gis16 ] | % 163
  \D ais16 [ \D b16 \D cis'16 \D b16 \D gis16 \D b,16 ] \D dis8 [ \D e16 \D dis16
  \D e16 \D dis16 ] | % 164
  \U gis,8 \tweak output-attributes #'((data-sid . "op47-rest-0425")) r8 \D <fis
    \tweak output-attributes #'((data-sid . "op47-tie-0213")) ~ gis \tweak
    output-attributes #'((data-sid . "op47-tie-0214")) ~ dis' \tweak
    output-attributes #'((data-sid . "op47-tie-0215")) ~>8 \D <fis gis dis'>4 \D
  <e \tweak output-attributes #'((data-sid . "op47-tie-0216")) ~ gis \tweak
    output-attributes #'((data-sid . "op47-tie-0217")) ~ cis' \tweak
    output-attributes #'((data-sid . "op47-tie-0218")) ~>8 | % 165
  \D <e gis cis'>4 \D <dis fis b>8 \voiceOne \U a8 [ \U e8 \U fis8 ] | % 166
  \oneVoice \U <gis, bis, gis>8 \tweak output-attributes #'((data-sid .
  "op47-rest-0427")) r8 \D <fis \tweak output-attributes #'((data-sid .
    "op47-tie-0219")) ~ gis \tweak output-attributes #'((data-sid .
    "op47-tie-0220")) ~ dis' \tweak output-attributes #'((data-sid .
    "op47-tie-0221")) ~>8 \D <fis gis dis'>4 \D <e \tweak output-attributes
    #'((data-sid . "op47-tie-0222")) ~ gis \tweak output-attributes #'((data-sid
    . "op47-tie-0223")) ~ cis' \tweak output-attributes #'((data-sid .
    "op47-tie-0224")) ~>8 | % 167
  \D <e gis cis'>4 \D <dis fis b!>8 \voiceOne \U a!8 [ \U e8 \U fis8 ] | % 168
  \oneVoice \U <gis,, gis,>8 \tweak output-attributes #'((data-sid .
  "op47-rest-0429")) r8 \D <bis, \tweak output-attributes #'((data-sid .
    "op47-tie-0225")) ~ dis \tweak output-attributes #'((data-sid .
    "op47-tie-0226")) ~ gis \tweak output-attributes #'((data-sid .
    "op47-tie-0227")) ~>8 \D <bis, dis gis>4 \D <cis \tweak output-attributes
    #'((data-sid . "op47-tie-0228")) ~ e \tweak output-attributes #'((data-sid .
    "op47-tie-0229")) ~ ais \tweak output-attributes #'((data-sid .
    "op47-tie-0230")) ~>8 | % 169

  \barNumberCheck #170
  \D <cis e ais>4 \D <e \tweak output-attributes #'((data-sid .
    "op47-tie-0231")) ~ gis \tweak output-attributes #'((data-sid .
    "op47-tie-0232")) ~ cis' \tweak output-attributes #'((data-sid .
    "op47-tie-0233")) ~>8 \D <e gis cis'>4 \D <dis gis bis>8 \sustainOn | % 170
  \U gis,4 <> \sustainOff \D <cis gis ais>8 \sustainOn \U gis,4 <> \sustainOff
  \D <dis gis bis>8 \sustainOn | % 171
  \U gis,4 <> \sustainOff \D <fis gis bis e'>8 \U <gis,, gis,>4 \D <fis gis bis
    dis'>8 | % 172
  \U <cis, cis>8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0430")) r8 \D <e gis cis'>8 \U <cis, cis>8 \tweak output-attributes
  #'((data-sid . "op47-rest-0431")) r8 \clef "treble" \U <cis' e' gis' cis''>8
  <> \sustainOff | % 173
  \clef "bass" \D <cis cis'>8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0432")) r8 \clef "treble" \U <cis' fis' a' cis''>8 <> \sustainOff
  \clef "bass" \D <cis cis'>8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0433")) r8 \D <gis cis' e' gis'>8 <> \sustainOff | % 174
  \U <cis, cis>4 \sustainOn \D <e gis cis' e'>8 <> \sustainOff \U <c, c!>4
  \sustainOn \D <e gis c'! e'>8 <> \sustainOff | % 175
  \U <b,, b,>4 \sustainOn \D <e gis e'>8 <> \sustainOff \U <b,, b,>4 \sustainOn
  \D <fis b dis'>8 <> \sustainOff | % 176
  \U <e, e>4 \sustainOn \D <e gis b e'>8 <> \sustainOff \U <dis, dis>4
  \sustainOn \D <e gis bis e'>8 <> \sustainOff | % 177
  \U <cis, cis>8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0434")) r8 \clef "treble" \U <gis cis' e' cis''>8 \arpeggio <>
  \sustainOff \clef "bass" \D <cis cis'>8 \sustainOn \tweak output-attributes
  #'((data-sid . "op47-rest-0435")) r8 \clef "treble" \U <a cis' fis' cis''>8
  \arpeggio <> \sustainOff | % 178
  \clef "bass" \D <cis cis'>8 [ \sustainOn \clef "treble" \D <e' cis''>8 <>
  \sustainOff \clef "bass" \D <fis fis'>8 ] \D <b, b>8 [ \sustainOn \clef
  "treble" \D <dis' b'>8 <> \sustainOff \clef "bass" \D <e e'>8 ] | % 179

  \barNumberCheck #180
  \D <a, a>8 [ \sustainOn \D <cis' a'>8 <> \sustainOff \D <dis! dis'!>8 ] \D
  <gis, gis>8 [ \sustainOn \D <bis gis'>8 <> \sustainOff \D <cis cis'>8 ] | % 180
  \D <fis, fis>8 [ \sustainOn \D <ais fis'>8 <> \sustainOff \D <b, b>8 ] \D <e,
    e>8 [ \sustainOn \D <gis e'>8 <> \sustainOff \D <ais,! ais!>8 ] | % 181
  \D <dis, dis>8 [ \sustainOn \D <fisis dis'>8 <> \sustainOff \D <gis, gis>8 ]
  \D <cis, cis>8 [ \sustainOn \D <eis cis'>8 <> \sustainOff \D <fis, fis!>8 ] | % 182
  \U <b,, b,>8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0438")) r8 <> \sustainOff \tweak output-attributes #'((data-sid .
  "op47-rest-0439")) r8 \U ais,,16 [ \U b,,16 \U b,16 \U b,,16 \U b,16 \U b,,16
  ] | % 183
  \U ais,,16 [ \U b,,16 \U b,16 \U b,,16 \U b,16 \U b,,16 ] \U ais,,16 [ \U b,,16
  \U b,16 \U b,,16 \U b,16 \U b,,16 ] | % 184
  \U ais,,16 [ \U b,,16 \U b,16 \U b,,16 \U b,16 \U b,,16 ] \U ais,,16 [ \U b,,16
  \U b,16 \U b,,16 \U b,16 \U b,,16 ] | % 185
  \U ais,,16 [ \U b,,16 \U b,16 \U b,,16 \U b,16 \U b,,16 ] \U ais,,16 [ \U b,,16
  \U b,16 \U b,,16 \U b,16 \U b,,16 ] | % 186
  \U ais,,16 [ \U b,,16 \U b,16 \U b,,16 \U b,16 \U b,,16 ] \U ais,,16 [ \U b,,16
  \U b,16 \U b,,16 \U b,16 \U b,,16 ] | % 187
  \U ais,,16 [ \U b,,16 \U b,16 \U b,,16 \U b,16 \U b,,16 ] \U ais,,16 [ \U b,,16
  \U b,16 \U b,,16 \U b,16 \U b,,16 ] | % 188
  \U b,,16 [ \sustainOn \U fis,16 \U fis16 \U fis,16 \U fis16 \U fis,16 ] \U b,,16
  [ \sustainOn <> \sustainOff \U a,16 \U a16 \U a,16 \U a16 \U a,16 ] <>
  \sustainOff | % 189

  \barNumberCheck #190
  \U b,,16 [ \sustainOn \U gis,!16 \U gis!16 \U gis,16 \U gis16 \U a,16 ] <>
  \sustainOff \U b,,16 [ \sustainOn \U g,16 \U g!16 \U g,16 \U g16 \U g,16 ] | % 190
  \U b,,16 [ \U g,16 \U g!16 \U g,16 <> \sustainOff \U g16 \U g,16 ] \U b,,16 [
  \sustainOn \U g,16 \U g16 \U g,16 \U g16 \U g,16 ] <> \sustainOff | % 191
  \U b,,16 [ \sustainOn \U fis,16 \U fis16 <> \sustainOff \U eis16 \U e16 \U dis16
  ] \U d16 [ \U cis16 \U c16 \U b,16 \U bes,16 \U a,!16 ] | % 192
  \U as,16 [ \U g,16 \U fis,!16 \U f,16 \U e,16 \U es,16 ] \U d,16 [ \U des,16
  \U c,16 \U b,,!16 \U d,16 \U c,16 ] \bar "||" % 193
  \key as \major \U b,,16 [ \U c,16 \U c16 \U c,16 \U c16 \U c,16 ] \U b,,16 [
  \U c,16 \U c16 \U c,16 \U c16 \U c,16 ] | % 194
  \U b,,16 [ \U c,16 \U c16 \U c,16 \U c16 \U c,16 ] \U b,,16 [ \U c,16 \U c16
  \U c,16 \U c16 \U c,16 ] | % 195
  \U b,,16 [ \U c,16 \U c16 \U c,16 \U c16 \U c,16 ] \U b,,16 [ \U c,16 \U c16
  \U c,16 \U c16 \U c,16 ] | % 196
  \U c,16 [ \sustainOn \U g,16 \U g16 \U g,16 \U g16 <> \sustainOff \U g,16 ] \U
  c,16 [ \sustainOn \U bes,16 \U bes16 \U bes,16 \U bes16 \U bes,16 ] <>
  \sustainOff | % 197
  \U c,16 [ \sustainOn \U a,16 \U a!16 \U a,16 \U a16 <> \sustainOff \U a,16 ]
  \U c,16 [ \sustainOn \U as,16 \U as!16 \U as,16 \U as16 \U as,16 ] | % 198
  \U c,16 [ \U as,16 \U as16 \U as,16 \U as16 <> \sustainOff \U as,16 ] \U c,16
  [ \sustainOn \U as,16 \U as16 \U as,16 \U as16 \U as,16 ] <> \sustainOff | % 199

  \barNumberCheck #200
  \U c,16 [ \sustainOn \U g,16 <> \sustainOff \U g16 \U fis16 \U f16 \U e16 ] \U
  es16 [ \U d16 \U des16 \U c16 \U b,16 \U bes,16 ] | % 200
  \U a,16 [ \U as,16 \U g,16 \U fis,16 \U f,16 \U e,16 ] \U es,16 [ \U d,16 \U
  des,16 \U des,16 \U es,16 \U des,16 ] | % 201
  \U cis,16 [ \U d,16 \U d!16 \U d,16 \U d16 \U d,16 ] \U cis,16 [ \U d,16 \U d16
  \U d,16 \U d16 \U d,16 ] | % 202
  \U cis,16 [ \U d,16 \U d!16 \U d,16 \U d16 \U d,16 ] \U cis,16 [ \U d,16 \U d16
  \U d,16 \U d16 \U d,16 ] | % 203
  \U cis,16 [ \U d,16 \U d!16 \U d,16 \U d16 \U d,16 ] \tweak output-attributes
  #'((data-sid . "op47-rest-0470")) \hideNote r4 \voiceOne \U es8 \tweak
  output-attributes #'((data-sid . "op47-tie-0270")) ~ | % 204
  \U es8 \tweak output-attributes #'((data-sid . "op47-rest-0472")) \hideNote r4
  \oneVoice \U d,16 [ \U es,16 \U es16 \U es,16 \U es16 \U es,16 ] | % 205
  \U d,16 [ \U es,16 \U es16 \U es,16 \U es16 \U es,16 ] \U d,16 [ \U es,16 \U
  es16 \U es,16 \U es16 \U es,16 ] | % 206
  \U d,16 [ \U es,16 \U es16 \U es,16 \U es16 \U es,16 ] \U d,16 [ \U es,16 \U
  es16 \U es,16 \U es16 \U es,16 ] | % 207
  \U d,16 [ \U es,16 \U es16 \U es,16 \U es16 \U es,16 ] \U d,16 [ \U es,16 \U
  es16 \U es,16 \U es16 \U es,16 ] | % 208
  \U es,,16 \sustainOn \D as16 [ \D bes16 \D ces'16 <> \sustainOff \D bes16 \D
  as16 ] \D es16 [ \D as16 \D bes16 \D ces'16 \D bes16 \D as16 ] | % 209

  \barNumberCheck #210
  \U es,16 \sustainOn \D as16 [ \D bes16 \D ces'16 <> \sustainOff \D bes16 \D as16
  ] \D es16 [ \D as16 \D bes16 \D ces'16 \D bes16 \D as16 ] | % 210
  \U <es, es>16 \sustainOn \D as16 [ \D bes16 \D ces'16 <> \sustainOff \D bes16
  \D as16 ] \D es16 [ \D as16 \D bes16 \D ces'16 \D bes16 \D as16 ] | % 211
  \U <es, es>16 \sustainOn \D as16 [ \D bes16 \D ces'16 <> \sustainOff \D bes16
  \D as16 ] \D <es d'>16 [ \sustainOn \D as16 \D bes16 \D ces'16 \D bes16 \D as16
  ] <> \sustainOff | % 212
  \U <es, es>8 \sustainOn \clef "treble" \U <g bes des'! es'>8 [ \U <bes des'
    es' g'>8 ] \U <des' es' g' bes'>8 [ \U <bes des' es' g'>8 \U <g bes des'
    es'>8 ] <> \sustainOff | % 213
  \clef "bass" \U <as,, as,>8 \sustainOn \clef "treble" \U <as es'>8 [ \U <c'
    as'>8 ] \D <es' c''>8 [ \D <as' es''>8 \D <c'' as''>8 ] <> \sustainOff | % 214
  \clef "bass" \U <es, es>8 \sustainOn \D <es des'>8 [ \D <g es'>8 ] \D <des'
    g'>8 [ \D <g es'>8 \D <es des'>8 ] <> \sustainOff | % 215
  \D <as, as>8 \sustainOn \D <es c'>8 [ \D <as es'>8 ] \D <es c'>8 [ \D <as es'>8
  \tweak output-attributes #'((data-sid . "op47-rest-0481")) r16 \D <c c'>16 ]
  <> \sustainOff | % 216
  \D <c c'>8 [ \D <bes, bes>8 \D <as, as>8 ] \U <g, g>8 [ \U <f, f>8 \U <es, es>8
  ] | % 217
  \U <as,, as,>8 \sustainOn \D <es c'>8 [ \D <as es'>8 ] \D <c' as'>4 <>
  \sustainOff \tweak output-attributes #'((data-sid . "op47-rest-0486")) r8 | % 218
  \U <es, es>8 \sustainOn \D <es des'>8 [ \D <g es'>8 ] \D <des' g'>8 [ <>
  \sustainOff \D <g es'>8 \D <es des'>8 ] | % 219

  \barNumberCheck #220
  \D <as, as>8 \sustainOn \D <es c'>8 [ \D <as es'>8 ] \D <c' as'>4 <>
  \sustainOff \tweak output-attributes #'((data-sid . "op47-rest-0491")) r8 | % 220
  \U <es, es>8 \sustainOn \D <es des'>8 [ \D <g es'>8 ] \D <des' g'>8 [ <>
  \sustainOff \D <g es'>8 \D <es des'>8 ] | % 221
  \U <d, d>8 \sustainOn \D <d ces'>8 [ \D <as f'>8 ] \D <ces' as'>8 [ \D <as f'>8
  \D <d ces'>8 ] <> \sustainOff | % 222
  \U <des,! des!>8 \sustainOn \D <des bes>8 [ \D <g e'>8 ] \D <des bes>8 [ \D <g
    e'>8 ] <> \sustainOff \tweak output-attributes #'((data-sid .
  "op47-rest-0497")) r8 | % 223
  \U <c, c>8 \sustainOn \D <c a>8 [ \D <fis es'!>8 ] \D <c a>8 [ \D <fis es'>8 ]
  <> \sustainOff \tweak output-attributes #'((data-sid . "op47-rest-0500")) r8 | % 224
  \U <b,, b,>8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0502")) r16 \D <fis b! fis'!>16 [ \D <fis b fis'>8 ] \D <fis b
    fis'>8 [ \D <fis b fis'>8 \D <fis b fis'>8 ] <> \sustainOff | % 225
  \U e,8 \sustainOn \D <e! b e'!>8 [ <> \sustainOff \D <e b e'>8 ] \D <e b e'>8
  -> [ \D <e ais e'>8 -> \D <e gis e'>8 -> ] | % 226
  \U <es,! es!>8 \sustainOn \D <es c'>8 [ \D <es c'>8 ] \D <es c'>8 [ \D <es c'>8
  \D <es c'>8 ] | % 227
  \D <es c'>8 [ <> \sustainOff \D <es c' es'>8 \D <es c' es'>8 ] \D <es c' es'>8
  [ \D <es c' es'>8 \D <es c' es'>8 ] | % 228
  \U <es,, es,>8 \sustainOn \D <es bes des' es'>8 [ \D <es bes des' es'>8 ] \D
  <es bes des' es'>8 [ <> \sustainOff \D <bes des' f'!>8 \sustainOn \D <bes des'
    f'>8 ] | % 229

  \barNumberCheck #230
  \D <bes des' f'>8 [ \D <bes des' f' as'>8 \D <bes des' f' as'>8 ] <>
  \sustainOff \D <bes des' f' as'>8 [ \D <bes es' g'>8 \D <bes es' g'>8 ] | % 230
  \U <as,, as,>8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0503")) r8 \D <es as es'>8 <> \sustainOff \D <fes as fes'!>4.
  \sustainOn <> \sustainOff | % 231
  \voiceOne \U as,8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0504")) r8 \U es8 \U c'4 <> \sustainOff \U bes8 | % 232
  \oneVoice \U <as,, as,>8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0506")) r8 \D <es c' as'>8 \arpeggio <> \sustainOff \D <fes c' as'>4.
  \arpeggio \sustainOn <> \sustainOff | % 233
  \voiceOne \U as,8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0507")) r8 \U es8 \U c'4 <> \sustainOff \U bes8 | % 234
  \oneVoice \U as,,8 \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0509")) r8 \D es8 \D <c' as'>4 <> \sustainOff \tweak
  output-attributes #'((data-sid . "op47-rest-0510")) r8 | % 235
  \U as,8 \sustainOn \tweak output-attributes #'((data-sid . "op47-rest-0511"))
  r8 \clef "treble" \U es'8 \D <c'' as''>4 <> \sustainOff \tweak
  output-attributes #'((data-sid . "op47-rest-0512")) r8 | % 236
  \U <as es' c''>4 \arpeggio \sustainOn \tweak output-attributes #'((data-sid .
  "op47-rest-0513")) r8 \tweak output-attributes #'((data-sid .
  "op47-rest-0514")) r4 \tweak output-attributes #'((data-sid .
  "op47-rest-0515")) r8 | % 237
  \clef "bass" \tweak output-attributes #'((data-sid . "op47-rest-0518")) r4
  \tweak output-attributes #'((data-sid . "op47-rest-0519")) r8 \U f16 [ \U es16
  \U c16 \U as,16 \U f,16 \U es,16 ] <> \sustainOff | % 238
  \U as,,4 \tweak output-attributes #'((data-sid . "op47-rest-0522")) r8 \U <c,
    c>4. -> | % 239

  \barNumberCheck #240
  \U <f, f>4. -> \U <es, es>4. -> | % 240
  \U <as,, as,>2. -> \bar "|."
}

PartPOneVoiceSix = {
  \clef "bass" \time 6/8 \key as \major s2*9 | % 6
  \tweak output-attributes #'((data-sid . "op47-rest-0002")) \hideNote r8 \U <c'
    es'>8 [ \U <des' es'>8 ] \U <es' as'>4 \D es,8 | % 7
  \D as,4 \D es8 \D as4 \tweak output-attributes #'((data-sid .
  "op47-rest-0005")) r8 s4*9 s4*15 s4*15 s4*15 s4*15 s1. | % 33
  \tweak output-attributes #'((data-sid . "op47-rest-0096")) \hideNote r4. \D <g
    c'>4. s2. s2*9 s4*9 | % 44
  \oneVoice \D es2. \tweak output-attributes #'((data-sid . "op47-tie-0036")) ~
  | % 45
  \voiceTwo \D es4 \tweak output-attributes #'((data-sid . "op47-rest-0101"))
  \hideNote r2 s2. s1*6 s2. | % 56
  \tweak output-attributes #'((data-sid . "op47-rest-0129")) \hideNote r4. \D g8
  [ \D as!8 \D g8 ] | % 57
  \D c8 \tweak output-attributes #'((data-sid . "op47-rest-0135")) \hideNote r8
  \tweak output-attributes #'((data-sid . "op47-rest-0136")) \hideNote r2 s1. | % 60
  \tweak output-attributes #'((data-sid . "op47-rest-0146")) \hideNote r4. \U g8
  [ \U as!8 \U g8 ] | % 61
  \D c8 \tweak output-attributes #'((data-sid . "op47-rest-0150")) \hideNote r4
  \U g8 [ \U as!8 \U g8 ] | % 62
  \D c4. \oneVoice \D c4. | % 63
  \D c4. \D c4. s2. s4*15 | % 70
  \tweak output-attributes #'((data-sid . "op47-rest-0187")) \hideNote r8
  \voiceTwo \D es8 [ <> \sustainOff \D f8 ] \oneVoice \D g8 -. [ \D as8 -. <>
  \sustainOff \D g8 ] s1*3 s4*15 s4*15 s4*15 s4*9 | % 93
  \tweak output-attributes #'((data-sid . "op47-rest-0251")) \hideNote r4
  \voiceTwo \D g,,8 \tweak output-attributes #'((data-sid . "op47-tie-0132")) ~
  \D g,,8 [ <> \sustainOff \D as,,8 \D bes,,8 ] | % 94
  \tweak output-attributes #'((data-sid . "op47-rest-0252")) \hideNote r4. \D c,4.
  | % 95
  \D c2. s4*9 | % 99

  \barNumberCheck #100
  \oneVoice \slashedGrace { \U es,8 } \D es2. | % 100
  \slashedGrace { \U as,8 } \D as2. | % 101
  \voiceTwo \D g2. | % 102
  \D <c g>8 \tweak output-attributes #'((data-sid . "op47-rest-0274")) \hideNote
  r8 \tweak output-attributes #'((data-sid . "op47-rest-0275")) \hideNote r2 s1.
  s1. | % 107
  \tweak output-attributes #'((data-sid . "op47-rest-0292")) \hideNote r4. \D g8
  [ \D as!8 \D g8 ] | % 108
  \D c8 \tweak output-attributes #'((data-sid . "op47-rest-0298")) \hideNote r8
  \tweak output-attributes #'((data-sid . "op47-rest-0299")) \hideNote r2 s2.
  s2. | % 111
  \tweak output-attributes #'((data-sid . "op47-rest-0309")) \hideNote r4. \D g8
  [ \D as!8 \D g8 ] | % 112
  \D c8 \tweak output-attributes #'((data-sid . "op47-rest-0313")) \hideNote r4
  \D g8 [ \D as8 \D g8 ] | % 113
  \D c4 \tweak output-attributes #'((data-sid . "op47-rest-0317")) \hideNote r2
  s2. s2. | % 116
  \tweak output-attributes #'((data-sid . "op47-rest-0322")) \hideNote r4. \D es4.
  s1. s2. | % 120
  \tweak output-attributes #'((data-sid . "op47-rest-0327")) \hideNote r4. \D
  bes,4. s1. s1. | % 125
  \tweak output-attributes #'((data-sid . "op47-rest-0333")) \hideNote r4. \D
  <ges \tweak output-attributes #'((data-sid . "op47-tie-0166")) ~ as \tweak
    output-attributes #'((data-sid . "op47-tie-0167")) ~ c' \tweak
    output-attributes #'((data-sid . "op47-tie-0168")) ~>4. | % 126
  \D <ges as c'>2. s1. | % 129

  \barNumberCheck #130
  \tweak output-attributes #'((data-sid . "op47-rest-0336")) \hideNote r4. \D
  des'4 \D a8 | % 130
  \D bes4. \D c'4. s4*9 s1*3 s1*3 | % 142
  \tweak output-attributes #'((data-sid . "op47-rest-0349")) \hideNote r4.
  \oneVoice \D es,16 [ \D bes,16 \D es16 \D g16 \voiceTwo \D es16 \D bes,16 ] | % 143
  \D as,8 \tweak output-attributes #'((data-sid . "op47-rest-0356")) \hideNote r8
  \tweak output-attributes #'((data-sid . "op47-rest-0357")) \hideNote r2 s4*9
  s2. | % 148
  \tweak output-attributes #'((data-sid . "op47-rest-0374")) \hideNote r4. \D es8
  [ \D fes8 \D es8 ] | % 149

  \barNumberCheck #150
  \D as,8 \tweak output-attributes #'((data-sid . "op47-rest-0380")) \hideNote r8
  \tweak output-attributes #'((data-sid . "op47-rest-0381")) \hideNote r2 s1. | % 152
  \tweak output-attributes #'((data-sid . "op47-rest-0391")) \hideNote r4. \D es8
  [ <> \sustainOff \D fes8 \D es8 ] | % 153
  \D as,8 \tweak output-attributes #'((data-sid . "op47-rest-0395")) \hideNote r4
  \D es8 [ <> \sustainOff \D fes8 \D es8 ] s1. \bar "||" % 156
  \change Staff="1" \D e'8 \change Staff="2" \tweak output-attributes
  #'((data-sid . "op47-rest-0409")) \hideNote r8 \change Staff="1" \D <gis
    \tweak output-attributes #'((data-sid . "op47-tie-0195")) ~ cis' \tweak
    output-attributes #'((data-sid . "op47-tie-0196")) ~>8 \D <gis cis'>4 \D
  <cis' \tweak output-attributes #'((data-sid . "op47-tie-0197")) ~ e' \tweak
    output-attributes #'((data-sid . "op47-tie-0198")) ~>8 \change Staff="2" | % 157
  \change Staff="1" \D <cis' e'>8 [ \D <cis' e'>8 \D <bis fis'>8 ] \D <gis cis'>8
  [ \D cis'8 \D cis'8 ] \change Staff="2" | % 158
  \change Staff="1" \D <cis' e'>8 \change Staff="2" \tweak output-attributes
  #'((data-sid . "op47-rest-0411")) \hideNote r8 \change Staff="1" \D e'8 \tweak
  output-attributes #'((data-sid . "op47-tie-0201")) ~ \D e'4 \D e'8 \tweak
  output-attributes #'((data-sid . "op47-tie-0202")) ~ \change Staff="2" | % 159

  \barNumberCheck #160
  \change Staff="1" \D e'8 [ \D e'8 \D <e' fis'>8 ] \D <dis' a'>8 [ \D ais8 \D
  <ais b dis'>8 ] \change Staff="2" | % 160
  \change Staff="1" \D <gis b e'>8 \change Staff="2" \tweak output-attributes
  #'((data-sid . "op47-rest-0415")) \hideNote r8 \change Staff="1" \D <gis bis
    fis'>8 \change Staff="2" \tweak output-attributes #'((data-sid .
  "op47-rest-0416")) \hideNote r4 \change Staff="1" \D <gis \tweak
    output-attributes #'((data-sid . "op47-tie-0204")) ~ cis' \tweak
    output-attributes #'((data-sid . "op47-tie-0205")) ~ e' \tweak
    output-attributes #'((data-sid . "op47-tie-0206")) ~>8 \change Staff="2" | % 161
  \change Staff="1" \D <gis cis' e'>8 \change Staff="2" \tweak output-attributes
  #'((data-sid . "op47-rest-0417")) \hideNote r8 \change Staff="1" \D <cis'
    \tweak output-attributes #'((data-sid . "op47-tie-0208")) ~ e' \tweak
    output-attributes #'((data-sid . "op47-tie-0209")) ~>8 \D <cis' e'>8 [ \D
  <cis' e'>8 \D e'8 ] \change Staff="2" | % 162
  \change Staff="1" \D e'8 [ \change Staff="2" \tweak output-attributes
  #'((data-sid . "op47-rest-0419")) \hideNote r8 \change Staff="1" \D gis'8 ] \D
  gis'8 \change Staff="2" \tweak output-attributes #'((data-sid .
  "op47-rest-0420")) \hideNote r8 \change Staff="1" \D <e' gis'>8 [ \change
  Staff="2" | % 163
  \change Staff="1" \D <dis' gis'>8 ] \change Staff="2" \tweak output-attributes
  #'((data-sid . "op47-rest-0423")) \hideNote r8 \change Staff="1" \D <dis'
    \tweak output-attributes #'((data-sid . "op47-tie-0211")) ~ gis' \tweak
    output-attributes #'((data-sid . "op47-tie-0212")) ~ b'>8 \D <dis' gis'
    ais'>8 \change Staff="2" \tweak output-attributes #'((data-sid .
  "op47-rest-0424")) \hideNote r8 \change Staff="1" \D <cis' dis' fisis' ais'>8
  \change Staff="2" s2. | % 165
  \tweak output-attributes #'((data-sid . "op47-rest-0426")) \hideNote r4. \D
  cis4. s2. | % 167
  \tweak output-attributes #'((data-sid . "op47-rest-0428")) \hideNote r4. \D
  cis4. s1*3 s1*3 s4*9 s4*9 s1*3 s1*3 s4*9 \bar "||"
  s1*3 s4*9 s4*9 | % 203
  \tweak output-attributes #'((data-sid . "op47-rest-0471")) \hideNote r4.
  \oneVoice \D cis,16 [ \D d,16 \D d16 \D d,16 \voiceTwo \D es16 \D es,16 ] | % 204
  \D d,16 [ \D es,16 \oneVoice \D es16 \D es,16 \D es16 \D es,16 ] \tweak
  output-attributes #'((data-sid . "op47-rest-0473")) \hideNote r4. s1. s1. s4*9
  s4*9 s4*9 s1*3 s4*9 s1*3 s1. | % 231
  \voiceTwo \D as,8 \tweak output-attributes #'((data-sid . "op47-rest-0505")) r8
  \D es8 \tweak output-attributes #'((data-sid . "op47-tie-0289")) ~ \D es4. s2.
  | % 233
  \D as,8 \tweak output-attributes #'((data-sid . "op47-rest-0508")) r8 \D es8
  \tweak output-attributes #'((data-sid . "op47-tie-0291")) ~ \D es4. s1. s4*15
  \bar "|."
}

PartPOneVoiceSeven = {
  \clef "bass" \time 6/8 \key as \major s2*9 s4*15 s4*15 s4*15 s4*15 s4*15 s1*3
  s2*9 s2*9 s1*6 s2. | % 56
  \tweak output-attributes #'((data-sid . "op47-rest-0130")) \hideNote r4. \D c4.
  s4*9 | % 60
  \tweak output-attributes #'((data-sid . "op47-rest-0147")) \hideNote r4. \D c4.
  | % 61
  \tweak output-attributes #'((data-sid . "op47-rest-0151")) \hideNote e'4.\rest
  \D c4. s4*9 s4*15 s4*15 s4*15 s4*15 s4*15 s4*15 s4*15 s4*15 s1. | % 107
  \tweak output-attributes #'((data-sid . "op47-rest-0293")) \hideNote r4. \D c4.
  s1. s2. | % 111
  \tweak output-attributes #'((data-sid . "op47-rest-0310")) \hideNote r4. \D c4.
  | % 112
  \tweak output-attributes #'((data-sid . "op47-rest-0314")) \hideNote r4. \D c4.
  s1. s1*3 s1*3 s1*3 s4*9 s1*3 s1*3 s1*3 s4*15 s2. | % 148
  \tweak output-attributes #'((data-sid . "op47-rest-0375")) \hideNote r4. \D
  as,4. s4*9 | % 152
  \tweak output-attributes #'((data-sid . "op47-rest-0392")) \hideNote r4. \D
  as,4. | % 153
  \tweak output-attributes #'((data-sid . "op47-rest-0396")) \hideNote r4. \D
  as,4. s1. \bar "||"
  s2. s4*9 s1*3 s1*3 s1*3 s1*3 s4*9 s4*9 s1*3 s1*3 s4*9 \bar "||"
  s1*3 s4*9 s4*9 s1*3 s1. s4*9 s4*9 s4*9 s1*3 s4*9 s1*3 s4*9 s1*3 s4*15 \bar
  "|."
}


% The score definition
\score {
  <<
    \new PianoStaff <<
      
      
      \context Staff = "1" <<
        \new Voice { \opFortySevenCrossTieOneA }
        \new Voice \with { \remove "Dynamic_align_engraver" } { \referenceMarksUpper }
        \new NullVoice { \lockedLayout }
        \mergeDifferentlyDottedOn
        \mergeDifferentlyHeadedOn
        \context Voice = "PartPOneVoiceOne" {
          \voiceOne \referenceNotes #1 \PartPOneVoiceOne
        }
        \context Voice = "PartPOneVoiceTwo" {
          \voiceTwo \referenceNotes #2 \PartPOneVoiceTwo
        }
      >>
      \context Staff = "2" <<
        \new Voice { \opFortySevenCrossTieTwoB }
        \new Voice { \opFortySevenCrossTieTwoA }
        \new Voice \with { \remove "Dynamic_align_engraver" } { \referenceMarksLower }
        \override Staff.BarLine.allow-span-bar = ##f
        \mergeDifferentlyDottedOn
        \mergeDifferentlyHeadedOn
        \context Voice = "PartPOneVoiceFive" {
          \voiceOne \referenceNotes #5 \PartPOneVoiceFive
        }
        \context Voice = "PartPOneVoiceSix" {
          \voiceTwo \referenceNotes #6 \PartPOneVoiceSix
        }
        \context Voice = "PartPOneVoiceSeven" {
          \voiceThree \referenceNotes #7 \PartPOneVoiceSeven
        }
      >>
    >>
  >>
  \layout {}
  % To create MIDI output, uncomment the following line:
  % \midi { \tempo 4 = 100 }
}

