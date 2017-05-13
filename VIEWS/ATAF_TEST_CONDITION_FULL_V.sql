CREATE OR REPLACE FORCE VIEW "ATAF_TEST_CONDITION_FULL_V" ("ROW_KEY", "DATA_ITEM_ID", "DATA_ID", "TEST_COND_ID", "ROW_NUMBER", "CON_SORT_ORDER", "PAGE_ID", "OUTCOME_PAGE_ID", "ACTION_ID", "DATA_ATTRIBUTE", "TEST_DATA_ID", "TEST_CASE_ID", "TEST_CASE", "NOTES", "ID", "DOM_ID", "NAME", "LABEL", "ELEMENT_TYPE", "REGION_ID", "REGION_NAME", "SCRIPT", "ACTION", "DATA_ITEM_VALUE", "DATA_ITEM_NAME", "PAGE_TITLE", "OUTCOME_PAGE_TITLE", "THEME_NUMBER", "APPLICATION_ID", "PROJECT_ID", "DATA_GROUP_ID", "AND_WAIT", "NOT_IN_GROUP") AS 
  SELECT
--
--+============================================================================
--|                     Apex Test Automation Framework
--|                                Andover
--+=============================================================================+
--|                                                                             |
--| $Author: $                                                                  |
--| $Date: $                                                                    |
--| $Revision: $                                                                |
--| $HeadURL: $                                                                 |
--|                                                                             |
--| Description : Denormalised View of Test Conditions                          |
--|                                                                             |
--| Modification History :                                                      |
--| ----------------------                                                      |
--|                                                                             |
--| Author          Date      Version Remarks                                   |
--| --------------- --------- ------- ------------------------------------------
--| S. Hunt         19-Jul-16 1       Initial Version                           |
--| S. Hunt         13-May-17 2       Not In Group.                             |
--+=============================================================================+ 
  ac.row_key,
  con.data_item_id,
  con.data_id,
  con.test_cond_id,
  con.row_number,
  con.sort_order con_sort_order,
  con.page_id,
  con.outcome_page_id,
  con.action_id,
  -- con.outcome_id,
  con.data_attribute,
  tc.test_data_id,
  tc.test_case_id,
  tc.test_case,
  tc.notes,
  iv.id,
  iv.dom_id,
  iv.name,
  iv.label,
  iv.element_type,
  iv.region_id,
  iv.region_name,
  ac.script,
  ac.action,
  -- ac1.script outcome_script,
  -- ac1.action action_outcome,
  di.data_item_value,
  di.data_item_name,
  pv.page_title,
  pv2.page_title outcome_page_title,
  aa.theme_number,
  aa.application_id,
  pr.project_id,
  con.data_group_id,
  ac1.and_wait,
  con.not_in_group
FROM
  -- Use ataf_test_cond_full_v if outcomes are reqd on separate rows ataf_test_cond for the same row
  ataf_test_cond_full_v con
  LEFT OUTER JOIN ataf_test_case tc                ON con.test_case_id = tc.test_case_id
--  LEFT OUTER JOIN ataf_test_data td                ON tc.test_data_id = td.test_data_id
  JOIN ataf_project pr                             ON tc.project_id = pr.project_id
  LEFT OUTER JOIN apex_application_themes aa       ON pr.application_id = aa.application_id and ui_type_NAME = 'DESKTOP'
                                                      and aa.workspace = v('ATAF_WORKSPACE')
  JOIN ataf_action ac                              ON con.action_id = ac.action_id
  LEFT OUTER JOIN ataf_action ac1                  ON con.outcome_id = ac1.action_id
  -- For prod change to ataf_apex_page_items for dev use ataf_apex_page_items_v
  LEFT OUTER JOIN ataf_apex_page_items iv          ON (con.apex_item_id = iv.id AND con.page_id = decode(iv.page_id,0,con.page_id,iv.page_id))
--------------------------------------------------------------------------------------------
  LEFT OUTER JOIN ataf_full_test_data_v di         ON con.data_item_id = di.data_item_id
                                                  AND con.data_id = di.data_id
---------------------------------------------------------------------------------------------
  LEFT OUTER JOIN apex_application_pages pv        ON con.page_id = pv.page_id and pr.application_id = pv.application_id
                                                      and pv.workspace = v('ATAF_WORKSPACE')
  LEFT OUTER JOIN apex_application_pages pv2       ON con.outcome_page_id = pv2.page_id and pr.application_id = pv2.application_id
                                                      and pv2.workspace = v('ATAF_WORKSPACE')
--WHERE di.data_group_id = td.default_data_group_id
--    OR td.default_data_group_id IS NULL
/
