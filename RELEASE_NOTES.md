# EQNUM 首次預覽發行說明草稿

依輸入數量，為選取尺寸套用 EQ 覆寫或等分後綴。

- 指令：EQNUM。
- 相依與設定：實際指令為 `EQNUM`，不是檔名 `EQ_NUM`。
- 驗證：完成來源與文件靜態檢查；AutoCAD 實機回歸待完成。
- 已知事項：0 使用 TextOverride；正整數使用 TextSuffix，保留量測值。上次數量保存於環境變數 EQ_LAST_COUNT。
- 授權：MIT，Copyright (c) 2026 whos-dwg。

本次保留來源位元組；發布時請按實際修補及測試結果更新這份說明。[完整操作](README.md)。
