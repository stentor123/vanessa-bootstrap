@chcp 65001
@set RUNNER_ibconnection="/FC:\tools\ACC"
@set RUNNER_dbuser="Administrator"

@call runner run --ordinaryapp 1 --command "acc.propertiesPaths=C:\tools\MYTEST\tools\acc-export\acc.properties;" --execute "C:\tools\MYTEST\tools\acc-export\acc-export.epf"
