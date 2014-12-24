<div class="popin" id="{$popin_id}">
    <form action="#" method="post">

        <div class="block">
            <label>Personnaliser le nom du signet :</label>
            <input type="text" value="{$title|wash}" name="newname" class="box" />
        </div>

        <hr />

        <input type="button" value="Annuler" class="button button_close" />
        <input type="button" value="Supprimer le signet" class="button button_delete" />
        <input type="button" value="Enregistrer le signet" class="defaultbutton" />

    </form>
</div>