;;; EQ_NUM.lsp  v2026-07-06-NUM
;;; Command: EQNUM
;;; 0 = same as old 0e: TextOverride = "EQ"
;;; 1 = TextSuffix = (EQ)
;;; 2+ = TextSuffix = (nEQ)
;;; Last value is saved in environment variable EQ_LAST_COUNT.

(vl-load-com)

(setq *EQNUM:EnvKey* "EQ_LAST_COUNT")

(defun EQNUM:GetDefault (/ v n)
  (setq v (getenv *EQNUM:EnvKey*))
  (setq n (if (and v (/= v "")) (atoi v) 1))
  (if (< n 0) 1 n)
)

(defun EQNUM:SetDefault (n)
  (setenv *EQNUM:EnvKey* (itoa n))
)

(defun EQNUM:ReadNumber (/ def n)
  (setq def (EQNUM:GetDefault))
  (setq n nil)
  (while (null n)
    ;; No initget here. getint itself accepts 0.
    ;; This keeps the input behavior closer to normal numeric input.
    (setq n
      (getint
        (strcat
          "\nEQNUM quantity [0=override EQ, 1=(EQ), 2=(2EQ)...] <"
          (itoa def)
          ">: "
        )
      )
    )
    (cond
      ((null n)
        (setq n def)
      )
      ((< n 0)
        (prompt "\n請輸入 0 或正整數。")
        (setq n nil)
      )
    )
  )
  n
)

(defun EQNUM:MakeSuffix (n)
  (cond
    ((= n 1) "(EQ)")
    (T (strcat "(" (itoa n) "EQ)"))
  )
)

(defun EQNUM:RemoveOne (s find / p len left right)
  (if (null s) (setq s ""))
  (setq len (strlen find))
  (while (setq p (vl-string-search find s))
    (setq left  (substr s 1 p))
    (setq right (substr s (+ p len 1)))
    (setq s (strcat left right))
  )
  s
)

(defun EQNUM:CleanSuffix (s / i)
  (if (null s) (setq s ""))
  (setq s (EQNUM:RemoveOne s "(EQ)"))
  (setq i 0)
  (while (<= i 999)
    (setq s (EQNUM:RemoveOne s (strcat "(" (itoa i) "EQ)")))
    (setq i (1+ i))
  )
  s
)

(defun EQNUM:SetDim (obj n / suffix)
  (if (= n 0)
    (vla-put-TextOverride obj "EQ")
    (progn
      (vla-put-TextOverride obj "<>")
      (setq suffix (vla-get-TextSuffix obj))
      (vla-put-TextSuffix obj (strcat (EQNUM:CleanSuffix suffix) (EQNUM:MakeSuffix n)))
    )
  )
)

(defun EQNUM:Run (/ n ss i obj count)
  (vl-load-com)
  (setq n (EQNUM:ReadNumber))
  (EQNUM:SetDefault n)

  (prompt "\n選取標註物件: ")
  (setq ss (ssget '((0 . "DIMENSION"))))

  (if ss
    (progn
      (setq i 0 count 0)
      (while (< i (sslength ss))
        (setq obj (vlax-ename->vla-object (ssname ss i)))
        (EQNUM:SetDim obj n)
        (setq count (1+ count))
        (setq i (1+ i))
      )
      (princ (strcat "\n完成：已處理 " (itoa count) " 個標註；目前 EQ = " (itoa n) "。"))
    )
    (princ "\n沒有選取標註。")
  )
  (princ)
)

(defun c:EQNUM ()
  (EQNUM:Run)
)

(princ "\nEQ_NUM.lsp v2026-07-06 loaded. Type EQNUM.")
(princ)
