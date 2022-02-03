![version](https://img.shields.io/badge/version-19%2B-5682DF)
[![license](https://img.shields.io/github/license/4D-JP/4d-tips-query-view-pro-cell-value)](LICENSE)

# 4d-tips-query-view-pro-cell-value
View Proのセル値ですばやく検索するには

### はじめに

View Proスプレッドシートは標準的なJSONオブジェクトです。

既定のプロパティの他，デベロッパー各自で自由に使用して良い領域として[`meta`](https://doc.4d.com/4Dv19/4D/19/Handling-4D-View-Pro-areas.300-5442948.ja.html)プロパティが予約されています。

View Proスプレッドシートのシート・列・行はそれぞれがオブジェクトであり，オブジェクト記法の値ではなくパスを構成します。

たとえば`シート1`の`11`行目`C`列のパスは

```
spreadJS.sheets.シート1.data.dataTable.10.2.value
```

となります。

これでは，オブジェクト記法でセルの値をクエリすることができません。パス（オブジェクトがデータベースだとすると，テーブルやフィールドの名前に相当する情報）そのものが動的な文字列となるためです。

### どうするか

必要なときにクエリするのではなく，後でクエリできるようにトリガでオブジェクトの構造を調整し，`meta`に保存することができます。

```4d
$event:=Trigger event

If ($event=On Saving New Record Event) | ($event=On Saving Existing Record Event)

	$obdata1:=[main]obdata1

	$meta:=New object("values"; New collection)

	$obdata1.meta:=$meta

	$sheets:=$obdata1.spreadJS.sheets

	For each ($sheet; $sheets)
		$dataTable:=$sheets[$sheet].data.dataTable
		For each ($c; $dataTable)
			$col:=$dataTable[$c]
			For each ($r; $col)
				$row:=$col[$r]
				$value:=New object("value"; $row.value; "row"; Num($r); "col"; Num($c); "sheet"; $sheet; "path"; New collection("spreadJS"; "sheets"; $sheet; "data"; "dataTable"; $c; $r).join("."))
				$meta.values.push($value)
			End for each 
		End for each 
	End for each 

End if 
```

こうしておけば

```4d
$find:=ds.main.query("obdata1.meta.values[].value == :1"; "aaa")
```

または

```4d
QUERY BY ATTRIBUTE([main]; [main]obdata1; "meta.values[].value"; =; "aaa")
```
みたいにクエリすることができます。

`meta`の構造は一例です。検索の用途に合わせて最適化してください。
