  SELECT * FROM 
    (SELECT
   
   x.*,
    a.*,
--  a.id,
	substr(a.END_TIME-START_TIME,12,8) dif,
   to_char( START_TIME,'HH24:MI') s
   
   --,
   
 ---  a.*
FROM
    dba_optstat_operations a,
    xmltable('/params/param'
PASSING xmlparse(document a.notes)
COLUMNS
 category_name path '@name',
 val path '@val'

) X
WHERE
    1 = 1
   --AND operation = 'gather_database_stats (auto)'
  --AND a.id = 9522
ORDER BY
    1 DESC )
    
PIVOT(
    max(val) 
    FOR category_name
    IN (
     'partname'                 AS   "PARTNAME",
 'gather_temp'                 AS   "GATHER_TEMP",
 'force'                 AS   "FORCE",
 'estimate_percent'                 AS   "ESTIMATE_PERCENT",
 'stattype'                 AS   "STATTYPE",
 'indname'                 AS   "INDNAME",
 'block_sample'                 AS   "BLOCK_SAMPLE",
 'cascade_parts'                 AS   "CASCADE_PARTS",
 'method_opt'                 AS   "METHOD_OPT",
 'gather_sys'                 AS   "GATHER_SYS",
 'degree'                 AS   "DEGREE",
 'ownname'                 AS   "OWNNAME",
 'cascade'                 AS   "CASCADE",
 'cascade_indexes'                 AS   "CASCADE_INDEXES",
 'granularity'                 AS   "GRANULARITY",
 'stattab'                 AS   "STATTAB",
 'concurrent'                 AS   "CONCURRENT",
 'statown'                 AS   "STATOWN",
 'cascade_columns'                 AS   "CASCADE_COLUMNS",
 'gather_fixed'                 AS   "GATHER_FIXED",
 'tabname'                 AS   "TABNAME",
 'reporting_mode'                 AS   "REPORTING_MODE",
 'no_invalidate'                 AS   "NO_INVALIDATE",
 'statid'                 AS   "STATID",
 'options'                 AS   "OPTIONS",
 'stat_category'                 AS   "STAT_CATEGORY"
)
)
--where degree='8'
ORDER BY 1;
