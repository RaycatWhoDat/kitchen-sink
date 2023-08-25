REBOL []

import 'csv
records: load-csv read %../d/MOCK_DATA.csv
foreach field fields [print field]