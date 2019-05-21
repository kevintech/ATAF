CREATE OR REPLACE FORCE VIEW "ATAF_FULL_TEST_DATA_CV" ("PROJECT_ID", "DATA_ID", "DATA_ITEM_ID", "ROW_NAME", "ROW_NUMBER", "ROW_KEY", "DATA_ITEM_VALUE", "TEST_DATA_ID", "LAST_UPDATED_DATE", "LAST_UPDATED_BY", "ATTRIBUTE", "DATA_ITEM_NAME", "DATA_GROUP_ID") AS 
  select 
 c001 PROJECT_ID,
 c002 DATA_ID,
 c003 DATA_ITEM_ID,
 c004 ROW_NAME,
 c005 ROW_NUMBER,
 c006 ROW_KEY,
 c007 DATA_ITEM_VALUE,
 c008 TEST_DATA_ID,
 c009 LAST_UPDATED_DATE,
 c010 LAST_UPDATED_BY,
 c011 ATTRIBUTE,
 c012 DATA_ITEM_NAME,
 c013 DATA_GROUP_ID
 from APEX_COLLECTIONS
where collection_name = 'ATAF_DATA'
/
