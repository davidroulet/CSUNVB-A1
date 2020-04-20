<?php

echo "Tests unitaires des 'todosheets'\n\n\n";

require 'model/todoListModel.php';

echo "1. Test unitaire de la fonction readTodoSheets\n\n";

echo "Test 1ère partie - tester que le nombre d'items lus soit le bon\n\n";

$todoItems = readTodoSheets();

if (count($todoItems) == 22) {
    echo "-> Test réussie";
} else {
    echo "-> Test échoué";
}

$i = 0;
$j = 0;

echo "\n\nTest 2ème partie - tester que tous les items aient bien 4 champs\n\n";

foreach ($todoItems as $todoItem) {
    if (count($todoItem) == 4) {
        $i += 1;
    }
}

if (count($todoItems) == $i) {
    echo "-> Test réussi\n\n\n\n";
} else {
    echo "-> Test échoué\n\n\n\n";
}


echo "2. Test unitaire de la fonction readTodoSheet (by Id)\n\n";

echo "Test 1ère partie - tester que les bons champs soient retournés\n\n";

$item = readTodoSheet(2);

if ($item['id'] == 2 && $item['week'] == 2009 && $item['state'] == "closed" && $item['base_id'] == 1) {
    echo "-> Test réussi\n\n";
} else {
    echo "-> Test échoué\n\n";
}

echo "Test 2ème partie - tester que le nombre de champs soit juste \n\n";

$countItem = count($item);

if ($countItem == 4) {
    echo "-> Test réussi\n\n";
} else {
    echo "-> Test échoué\n\n";
}

echo "Test 3ème partie - tester que si on met un autre id, ça ne retourne pas les mêmes champs\n\n";

$item2 = readTodoSheet(3);

if ($item2['id'] == 2 && $item2['week'] == 2009 && $item2['state'] == "closed" && $item2['base_id'] == 1) {
    echo "-> Test échoué\n\n";
} else {
    echo "-> Test réussi\n\n";
}

echo "Test 4ème partie - tester que rien n'est retourné si l'id de l'item n'existe pas\n\n";

$nullItem = readTodoSheet(23);

if ($nullItem != null) {
    echo "-> test échoué\n\n\n\n";
} else {
    echo "-> Test réussi\n\n\n\n";
}


echo "3. Test unitaire de la fonction readTodoSheetsForBase (By base)\n\n";

echo "test 1 et 2ème partie - Vérifier que les items cherchés ont bien la bonne base et qu'il y a un juste nombre d'items\n\n";


$items = readTodoSheetsForBase(5);

$count = 0;

foreach ($items as $item) {
    if ($item['base_id'] == 5) {
        $count += 1;
    }
}

if ($count == 3) {
    echo "-> Test réussi\n\n\n\n";
} else {
    echo "-> Test échoué\n\n\n\n";
}


echo "4. Test unitaire de la fonction createTodosSheet\n\n";

echo "Test 1ère partie - tester que les bons champs ont été crées\n\n";

$item = ["week" => 3, "state" => 3, "base_id" => 5];
$items = readTodoSheets();
$countItems = count($items);

$idgiven = createTodoSheet($item);

if ($idgiven != null) {
    $readback = readTodoSheet($idgiven);
    $item['id'] = $idgiven;
    if (empty(array_diff($readback, $item)) == true) {
        echo "-> test réussi";
    } else {
        echo "-> test échoué";
    }
} else {
    echo "-> test échoué";
}

echo "\n\nTest 2ème partie - tester que qu'un item a été bien ajouté au nombre d'items précédent\n\n";

$itemsAfter = readTodoSheets();

if (count($itemsAfter) == ($countItems + 1)) {
    echo "-> test réussi\n\n\n\n";
} else {
    echo "-> test échoué\n\n\n\n";
}

echo "5.Test unitaire de la fonction saveTodoSheets\n\n";

$item = readTodoSheet(23);

$items = readTodoSheets();
$items[23]['week'] = 2;


echo "Test 1ère partie - avant l'update le numéro 23 n'a pas les même champs qu'après l'update dans le champ week\n\n";

if ($item['id'] == 23 && $item['week'] == 2 && $item['state'] == 3 && $item['base_id'] == 5) {
    echo "-> Test échoué\n\n";
} else {
    echo "-> Test réussi\n\n";
}

saveTodoSheets($items);

$item = readTodoSheet(23);


echo "Test 2ème partie tester que l'item à l'id 23 a bien été update\n\n";

if ($item['id'] == 23 && $item['week'] == 2 && $item['state'] == 3 && $item['base_id'] == 5) {
    echo "-> Test réussi\n\n";
} else {
    echo "-> Test échoué\n\n";
}

echo "Test 3ème et 4ème partie - tester que le bon nombre de champ a été enregistré et que chaque enregistrement a 4 champs\n\n";

$items = readTodoSheets();

$s = 0;

foreach ($items as $Item) {
    if (count($Item) == 4) {
        $s += 1;
    }
}

if (23 == $s) {
    echo "-> Test réussi\n\n\n\n";
} else {
    echo "-> Test échoué\n\n\n\n";
}


echo "6. Test unitaire de la fonction updateTodoSheet\n\n";

echo "Test 1ère partie - avant l'update il ne doit pas y avoir les mêmes champs qu'après l'update\n\n";

$firstItemReaded = readTodoSheet(23);

if ($firstItemReaded['id'] == 23 && $firstItemReaded['week'] == 2 && $firstItemReaded['state'] == "open" && $firstItemReaded['base_id'] == 5) {
    echo "-> Test échoué";
} else {
    echo "-> Test réussi";
}

echo "\n\nTest 2ème partie - la modification existe belle et bien\n\n";

$item = readTodoSheet(23);
$item['state'] = "open";


$itemsBeforeUpdate = readTodoSheets();

updateTodoSheet($item);

$itemsAfterUpdate = readTodoSheets();

$itemReaded = readTodoSheet(23);

if ($itemReaded['id'] == 23 && $itemReaded['week'] == 2 && $itemReaded['state'] == "open" && $itemReaded['base_id'] == 5) {
    echo "-> Test réussi";
} else {
    echo "-> Test échoué";
}

echo "\n\nTest 3ème partie - le nombre de champs est le bon\n\n";

if ($itemReaded != null) {
    if (count($itemReaded) == 4) {
        echo "-> Test réussi";
    } else {
        echo "-> Test échoué";
    }
} else {
    echo "-> Test échoué";
}


echo "\n\nTest 4ème partie - le même nombre d'items doit exister avant et après l'update\n\n";

if (count($itemsBeforeUpdate) == count($itemsAfterUpdate)) {
    echo "-> Test réussi\n\n\n\n";
} else {
    echo "-> Test échoué\n\n\n\n";
}

echo "7. Test unitaire de la fonction destroyTodoSheet\n\n";

echo "Test 1ère partie - test qu'il y a le bon nombre d'item une fois l'item supprimé\n\n";

$items = readTodoSheets();
$countItems = count($items);

destroyTodoSheet(23);

$itemsAfter = readTodoSheets();


if (count($itemsAfter) == ($countItems - 1)) {
    echo "-> test réussi";
} else {
    echo "-> test échoué";
}

echo "\n\nTest 2ème partie - test que l'item sous l'id normalement supprimé n'existe plus\n\n";

$item = readTodoSheet(23);

if ($item == null) {
    echo "-> test réussi";
} else {
    echo "-> test échoué";
}

?>
