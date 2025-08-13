<!-- Topbar -->
<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

    <!-- Sidebar Toggle (Topbar) -->
    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
        <i class="fa fa-bars"></i>
    </button>

    <!-- View Site and Dark Mode Buttons -->
    <a href="{$SITE_HOME}" target="_blank" class="btn btn-primary" style="margin-right: 20px">{$VIEW_SITE}</a>

    <button onclick="toggleDarkLightMode()" id="dark_mode_button" class="btn btn-outline-secondary" title="{$MODE_TOGGLE}" style="margin-right: 20px">
        <i class="fas fa-moon" id="theme-icon-panel"></i>
    </button>

    <script type="text/javascript">
        // Fallback for theme icon update (in case main script doesn't work)
        $(document).ready(function() {
            if ($("html").hasClass("dark")) {
                $("#theme-icon-panel").removeClass("fa-moon").addClass("fa-sun");
            } else {
                $("#theme-icon-panel").removeClass("fa-sun").addClass("fa-moon");
            }
        });
    </script>

    <!-- Topbar Navbar -->
    <ul class="navbar-nav ml-auto">

        <!-- Nav Item - Alerts -->
        <li class="nav-item dropdown no-arrow mx-1">
            <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button" data-toggle="dropdown"
                aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-bell fa-fw"></i>
                <!-- Counter - Alerts -->
                {if $NOTICES|count > 0}
                <span class="badge badge-danger badge-counter">{$NOTICES|count}</span>
                {/if}
            </a>
            <!-- Dropdown - Alerts -->
            <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                aria-labelledby="alertsDropdown">
                {if $NOTICES|count eq 0}
                <span class="dropdown-item d-flex align-items-center">{$NO_NOTICES}</span>
                {else}
                {foreach from=$NOTICES key=url item=notice}
                <a href="{$url}" class="dropdown-item d-flex align-items-center"
                    style="color:#6c757d!important">{$notice}</a>
                {/foreach}
                {/if}
            </div>
        </li>

        <!-- Divider -->
        <div class="topbar-divider d-none d-sm-block"></div>

        <!-- Nav Item - User Information -->
        <li class="nav-item dropdown no-arrow">
            <a class="nav-link" href="{$LOGGED_IN_USER.panel_profile}">
                <span class="mr-2 d-none d-lg-inline text-gray-600 small">{$LOGGED_IN_USER.nickname}</span>
                <img class="img-profile rounded-circle" src="{$LOGGED_IN_USER.avatar}" alt="{$LOGGED_IN_USER.username}">
            </a>
        </li>

    </ul>

</nav>
<!-- End of Topbar -->