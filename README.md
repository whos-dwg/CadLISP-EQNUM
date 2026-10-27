# EQNUM 尺寸等分文字

![EQNUM](assets/banner.svg)

[工具儲存庫](https://github.com/whos-dwg/CadLISP-EQNUM) · [全部工具索引](https://github.com/whos-dwg/CadLISP-Index)

依輸入數量，為選取尺寸套用 EQ 覆寫或等分後綴。

| 項目 | 內容 |
| --- | --- |
| 指令 | `EQNUM` |
| 檔案 | [EQ_NUM.lsp](lsp/EQ_NUM.lsp) |
| 分類 | 尺寸與註解 |
| 狀態 | 來源快照，實機回歸待完成 |
| 授權 | [MIT](LICENSE)，Copyright (c) 2026 whos-dwg |

[安裝](#安裝) · [操作](#操作) · [相依與設定](#相依與設定) · [已知問題](docs/KNOWN_ISSUES.md) · [驗證紀錄](docs/VALIDATION.md)

## 安裝

以 Windows 桌面版 AutoCAD 為目標。原碼使用的 Visual LISP／ActiveX、DCL 或原生命令，需在目標 AutoCAD 版本分別確認；尚未做整包年份、LT、Mac 或其他 CAD 的相容性認證。ActiveX 的平台限制見 [Autodesk](https://help.autodesk.com/cloudhelp/2026/ENU/AutoCAD-AutoLISP/files/GUID-A0459510-CE7A-4206-9EAA-E25AAB569B20.htm)。

1. 下載並解壓縮本工具到固定位置，先開啟測試圖面。
2. 依公司環境把 `lsp` 資料夾加入需要的支援搜尋路徑與受信任位置。
3. 輸入 `APPLOAD`，載入 `EQ_NUM.lsp`；關閉視窗後輸入 `EQNUM`。

也可使用完整路徑單獨載入；下列路徑需依實際位置修改：

```lisp
(load "C:/CAD/CadLISP-EQNUM/lsp/EQ_NUM.lsp")
```

完成驗證後，可將這支 LISP 加入 APPLOAD 的 Startup Suite。請維持既定的 SECURELOAD 政策，使用受信任位置處理載入限制。[SECURELOAD 說明](https://help.autodesk.com/cloudhelp/2026/ENU/AutoCAD-Core/files/GUID-541566C6-2738-49DD-87C3-C1490E924A02.htm)。

## 操作

1. 輸入 `EQNUM`，輸入 0 或正整數。
2. 選取 DIMENSION 並按 Enter。
3. 檢查顯示文字；0 為 EQ，1 為 (EQ)，2 以上為 (nEQ)。

## 相依與設定

實際指令為 `EQNUM`，不是檔名 `EQ_NUM`。

圖面影響：修改選取尺寸的文字覆寫或後綴。

## 行為與限制

0 使用 TextOverride；正整數使用 TextSuffix，保留量測值。上次數量保存於環境變數 EQ_LAST_COUNT。

## 操作示範

![尺寸等分文字操作示範](assets/demos/eq_num.gif)

這是既有操作錄影，未與本快照逐段比對；本次不是以錄影作為實機回歸證據。媒體範圍見 [媒體說明](assets/NOTICE.md)。

## 來源與授權

本工具依維護者確認為自行從零撰寫，或以 AI 協作從零開發。程式與本次文件採 [MIT 授權](LICENSE)，允許使用、修改與再散布，須保留授權及著作權聲明。詳細來源紀錄見 [provenance.json](metadata/provenance.json)。

## 回報與維護

回報時附 AutoCAD 完整版本、命令列錯誤與去識別的重現範例。修改前請閱讀 [CONTRIBUTING](CONTRIBUTING.md)；發行步驟見 [PUBLISHING](docs/PUBLISHING.md)。本工具可獨立維護、下載及發布，不依賴其他 CadLISP 工具儲存庫。
