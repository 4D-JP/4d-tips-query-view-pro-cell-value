//%attributes = {"invisible":true}
TRUNCATE TABLE:C1051([main:1])

$f:=New object:C1471("get"; Formula:C1597(JSON Parse:C1218(Folder:C1567(fk resources folder:K87:11).file($1).getText(); Is object:K8:27)))

$e:=ds:C1482.main.new()

$e.obdata1:=$f.get("sample.json")

$e.save()