<?php
/**
 * @file
 * Provides API functions specifically for managing project
 * records in Chado.
 */

/**
 * @defgroup tripal_project_api Chado Project
 * @ingroup tripal_chado_api
 * @{
 * Provides API functions specifically for managing project
 * records in Chado.
 * @}
 */

/**
 * Used for autocomplete in forms for identifying projects
 *
 * @param $string
 *   The string to search for.
 *
 * @return
 *   A json array of terms that begin with the provided string.
 *
 * @ingroup tripal_project_api
 */
function chado_autocomplete_project($string = '') {
  $items = [];
  $sql = "
    SELECT
      P.project_id as id, P.name
    FROM {project} P
    WHERE lower(P.name) like lower(:str)
    ORDER by P.name
    LIMIT 25 OFFSET 0
  ";
  $records = chado_query($sql, [':str' => $string . '%']);
  while ($r = $records->fetchObject()) {
    $key = "$r->name [id: $r->id]";
    $items[$key] = "$r->name";
  }

  drupal_json_output($items);
}
