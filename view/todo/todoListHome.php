<?php
/**
 * Title: CSUNVB
 * USER: marwan.alhelo
 * DATE: 13.02.2020
 * Time: 11:29
 **/
/**
 * Title: CSUNVB - View Home
 * USER: Gatien.Jayme
 * DATE: 27.08.2020
 **/
ob_start();
$title = "CSU-NVB - Tâches hebdomadaires";

?>
<h1 class="center p-4"><?= $title ?></h1>



<FORM action="/index.php?action=todolist" method="post">
    <SELECT onchange="this.form.submit()" name="site" size="1">
        <?php
        foreach ($bases as $base) { ?>

        <OPTION value="<?= $base["id"] ?>" <?php if ($_SESSION["Selectsite"] == $base["id"]) { ?> selected="selected"  <?php } ?>
                name="site"><?= $base["name"] ?>

            <?php }
            ?>

    </SELECT>
    <?php if ($_SESSION['username']['admin'] == 1) { ?>
        <button name="newtodo">Nouvelle feuille</button>
    <?php } ?>
</FORM>

<div class="row">
    <table class="table table-bordered">
        <thead>
        <th>Date</th>
        <th>État</th>
        </thead>
        <tbody>
        <?php
        foreach ($todoSheets as $todosheet) {

            ?>

            <tr>
                <form action="/index.php?action=edittod&sheetid" method="post">
                    <td>


                        <?php
                        //Convert the date string into a unix timestamp.
                        //$unixTimestamp = strtotime($todosheet['week']);
                        //Get the day of the week using PHP's date function.
                        //$dayOfWeek = date("W", $unixTimestamp); ?>
                        <button class="btn" name="semaine"
                                value="<?= $todosheet['id'] ?>">
                            <?php echo "Semaine " . $todosheet['week'] ?>  </button>
                    </td>
                    </td>
                    <td><?= $todosheet['state'] ?></td>
                </form>
                <td>
                    <form action="/index.php?action=reopenToDo" method="post">
                        <button class="btn" name="reopen" value="<?= $todosheet['id'] ?>"
                        </button>Reopen
                    </form>
                    <form action="/index.php?action=closedToDo" method="post">
                        <button class="btn" name="close" value="<?= $todosheet['id'] ?>"
                        </button>Close
                    </form>
                </td>
            </tr>
        <?php } ?>
        </tbody>
    </table>
</div>

<?php
$content = ob_get_clean();
require "view/gabarit.php";
?>

