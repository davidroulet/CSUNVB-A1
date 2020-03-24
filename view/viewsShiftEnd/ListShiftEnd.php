<?php
/**
 * Auteur: Thomas Grossmann / Mounir Fiaux
 * Date: Mars 2020
 **/

ob_start();
$title = "CSU-NVB - Remise de garde";
?>
<FORM action="/index.php?action=listShiftEnd" method="post">
    <SELECT name="site" size="1">
        <OPTION value="4" <?php if($_SESSION["Selectsite"]==4){?> selected="selected"  <?php }?> name="site">Payerne
        <OPTION value="1" <?php if($_SESSION["Selectsite"]==1){?> selected="selected" <?php }?>name="site">Yverdon
        <OPTION value="3" <?php if($_SESSION["Selectsite"]==3){?> selected="selected" <?php }?>name="site">Saint-Loup
        <OPTION value="2" <?php if($_SESSION["Selectsite"]==2){?> selected="selected" <?php }?>name="site">Sainte-Croix
        <OPTION value="5" <?php if($_SESSION["Selectsite"]==5){?> selected="selected" <?php }?>name="site">Vallée-de-Joux
    </SELECT>
    <button type="submit">Recharger</button>
</FORM>

<?php
// TODO Déplacer ce code, ce n'est ps la bonne place pour faire cela. Il faut une fonction getGuardSheetsByBase($base_id) dans le modèle. Le contrôleur fait ensuite $liste=getGuard... et la vue a du coup toutes les données qu'il lui faut
foreach ($liste as $item) {
    if ($item["base_id"] == $_SESSION["Selectsite"]) {
        $remises[] = $item;
    }
} ?>

<div class="row">
    <table class="table table-bordered">
        <thead>
        <th>Date</th>
        <th>État</th>
        </thead>
        <tbody>
    <?php foreach ($remises as $remise) { ?>
        <tr>
            <td><a href="index.php?action=shiftend"><?=$remise['date']?></a></td><td><?=$remise['state']?></td>
        </tr>
    <?php } ?>
        </tbody>
    </table>
</div>

<?php
$content = ob_get_clean();
require "view/gabarit.php";
?>
