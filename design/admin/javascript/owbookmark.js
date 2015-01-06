$(document).ready(function() {
    $('.tooltip').tooltipster();

    applyFancyBox('.fancybox_inline');

    $('.popin .button_close').click(function() {
        $.fancybox.close();
    });
});

function applyFancyBox(id) {
    $(id).fancybox({
        type: 'inline',
        autoSize : false,
        autoHeight: true,
        title: '',
        helpers : {
            title: {
                type: 'inside',
                position: 'top'
            }
        },
        beforeLoad : function() {
            if (this.element.data('fancybox-width')) {
                this.width  = parseInt(this.element.data('fancybox-width'));
            }
        }
    });
}