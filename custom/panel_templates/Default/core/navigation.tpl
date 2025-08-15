{include file='header.tpl'}

<body id="page-top">

    <!-- Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        {include file='sidebar.tpl'}

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main content -->
            <div id="content">

                <!-- Topbar -->
                {include file='navbar.tpl'}

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h3 mb-0 text-gray-800">{$NAVIGATION}</h1>
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="{$PANEL_INDEX}">{$DASHBOARD}</a></li>
                            <li class="breadcrumb-item active">{$CONFIGURATION}</li>
                            <li class="breadcrumb-item active">{$NAVIGATION}</li>
                        </ol>
                    </div>

                    <!-- Update Notification -->
                    {include file='includes/update.tpl'}

                    <div class="card shadow mb-4">
                        <div class="card-body">

                            <!-- Success and Error Alerts -->
                            {include file='includes/alerts.tpl'}

                            <form action="" method="post">
                                <div class="card shadow border-left-primary">
                                    <div class="card-body">
                                        <h5><i class="icon fa fa-info-circle"></i> {$INFO}</h5>
                                        <p>{$NAVBAR_ORDER_INSTRUCTIONS}</p>
                                        <p>{$NAVBAR_ICON_INSTRUCTIONS}</p>
                                    </div>
                                </div>
                                <br />
                                <div id="sortable-nav-items" class="nav-items-container">
                                {foreach from=$NAV_ITEMS key=key item=item}
                                    <div class="nav-item-card card mb-3" data-key="{if isset($item.custom) && is_numeric($item.custom)}{$item.custom}{else}{$key}{/if}">
                                        <div class="card-header d-flex justify-content-between align-items-center" style="cursor: move;">
                                            <strong><i class="fas fa-grip-vertical me-2"></i>{$item.title|escape}</strong>
                                            <small class="text-muted">Order: <span class="order-display">{$item.order|escape}</span></small>
                                        </div>
                                        <div class="card-body">
                                            <div class="form-group">
                                                <label for="input{$item.title|escape}Icon">{$NAVBAR_ICON}</label>
                                                <input type="text" class="form-control" id="input{$item.title|escape}Icon"
                                                    name="inputIcon[{if isset($item.custom) && is_numeric($item.custom)}{$item.custom}{else}{$key}{/if}]"
                                                    value="{$item.icon|escape}"
                                                    placeholder='<i class="fas fa-home icon"></i>'>
                                                <input type="hidden" class="order-input"
                                                    name="inputOrder[{if isset($item.custom) && is_numeric($item.custom)}{$item.custom}{else}{$key}{/if}]"
                                                    value="{$item.order|escape}">
                                            </div>
                                            
                                            {if isset($item.items) && count($item.items)}
                                            <hr>
                                            <h6>{$item.title|escape} &raquo; {$DROPDOWN_ITEMS}</h6>
                                            <div id="sortable-dropdown-{if isset($item.custom) && is_numeric($item.custom)}{$item.custom}{else}{$key}{/if}" class="dropdown-items-container">
                                                {foreach from=$item.items key=dropdown_key item=dropdown_item}
                                                <div class="dropdown-item-card card mb-2" data-key="{if isset($dropdown_item.custom) && is_numeric($dropdown_item.custom)}{$dropdown_item.custom}{else}{$dropdown_key}{/if}">
                                                    <div class="card-body">
                                                        <div class="d-flex justify-content-between align-items-center mb-2" style="cursor: move;">
                                                            <strong><i class="fas fa-grip-vertical me-2"></i>{$dropdown_item.title|escape}</strong>
                                                            <small class="text-muted">Order: <span class="order-display">{$dropdown_item.order|escape}</span></small>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="input{$dropdown_item.title|escape}Icon">{$NAVBAR_ICON}</label>
                                                            <input type="text" class="form-control"
                                                                id="input{$dropdown_item.title|escape}Icon"
                                                                name="inputIcon[{if isset($dropdown_item.custom) && is_numeric($dropdown_item.custom)}{$dropdown_item.custom}{else}{$dropdown_key}{/if}]"
                                                                value="{$dropdown_item.icon|escape}">
                                                            <input type="hidden" class="order-input"
                                                                name="inputOrder[{if isset($dropdown_item.custom) && is_numeric($dropdown_item.custom)}{$dropdown_item.custom}{else}{$dropdown_key}{/if}]"
                                                                value="{$dropdown_item.order|escape}">
                                                        </div>
                                                    </div>
                                                </div>
                                                {/foreach}
                                            </div>
                                            {/if}
                                        </div>
                                    </div>
                                {/foreach}
                                </div>
                                <hr>
                                <div class="form-group">
                                    <label for="dropdown_name">{$DROPDOWN_NAME}</label>
                                    <input type="text" class="form-control" id="dropdown_name" name="dropdown_name"
                                        value="{$DROPDOWN_NAME_VALUE}">
                                </div>
                                <div class="form-group">
                                    <input type="hidden" name="token" value="{$TOKEN}">
                                    <input type="submit" value="{$SUBMIT}" class="btn btn-primary">
                                </div>
                            </form>

                        </div>
                    </div>

                    <!-- Spacing -->
                    <div style="height:1rem;"></div>

                    <!-- End Page Content -->
                </div>

                <!-- End Main Content -->
            </div>

            {include file='footer.tpl'}

            <!-- End Content Wrapper -->
        </div>

        <!-- End Wrapper -->
    </div>

    {include file='scripts.tpl'}
    
    <script src="https://cdn.jsdelivr.net/npm/sortablejs@1.15.0/Sortable.min.js"></script>
    <script>
    $(document).ready(function() {
        // Initialize sortable for main navigation items
        var navSortable = new Sortable(document.getElementById('sortable-nav-items'), {
            animation: 150,
            ghostClass: 'sortable-ghost',
            chosenClass: 'sortable-chosen',
            dragClass: 'sortable-drag',
            handle: '.card-header',
            onEnd: function(evt) {
                updateNavOrder();
            }
        });

        // Initialize sortable for dropdown items
        $('.dropdown-items-container').each(function() {
            new Sortable(this, {
                animation: 150,
                ghostClass: 'sortable-ghost',
                chosenClass: 'sortable-chosen',
                dragClass: 'sortable-drag',
                handle: '.card-body > .d-flex',
                onEnd: function(evt) {
                    updateDropdownOrder(evt.to);
                }
            });
        });

        function updateNavOrder() {
            $('#sortable-nav-items .nav-item-card').each(function(index) {
                var newOrder = index + 1;
                $(this).find('.order-input').val(newOrder);
                $(this).find('.order-display').text(newOrder);
            });
        }

        function updateDropdownOrder(container) {
            $(container).find('.dropdown-item-card').each(function(index) {
                var newOrder = index + 1;
                $(this).find('.order-input').val(newOrder);
                $(this).find('.order-display').text(newOrder);
            });
        }

        // Initial order setup
        updateNavOrder();
        $('.dropdown-items-container').each(function() {
            updateDropdownOrder(this);
        });
    });
    </script>
    
    <style>
    .nav-items-container .nav-item-card {
        transition: all 0.3s ease;
        border: 1px solid #e3e6f0;
    }
    
    .nav-item-card:hover {
        box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
    }
    
    .dropdown-item-card {
        background-color: #f8f9fc;
        border: 1px solid #e3e6f0;
        transition: all 0.3s ease;
    }
    
    .dropdown-item-card:hover {
        box-shadow: 0 0.15rem 1rem 0 rgba(58, 59, 69, 0.1);
    }
    
    .sortable-ghost {
        opacity: 0.5;
        transform: rotate(2deg);
    }
    
    .sortable-chosen {
        box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.3);
    }
    
    .sortable-drag {
        transform: rotate(5deg);
        z-index: 9999;
    }
    
    .card-header[style*="cursor: move"]:hover,
    .d-flex[style*="cursor: move"]:hover {
        background-color: #f8f9fc;
    }
    
    .fas.fa-grip-vertical {
        color: #858796;
        margin-right: 8px;
    }
    
    .order-input[readonly] {
        background-color: #f8f9fc;
        border: 1px solid #d1d3e2;
    }
    
    .nav-items-container {
        min-height: 100px;
    }
    
    .dropdown-items-container {
        min-height: 50px;
        padding: 10px;
        background-color: #f8f9fc;
        border: 1px dashed #d1d3e2;
        border-radius: 0.35rem;
        margin-top: 10px;
    }
    </style>

</body>

</html>