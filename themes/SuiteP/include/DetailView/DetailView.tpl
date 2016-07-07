{*
/*********************************************************************************
 * SugarCRM Community Edition is a customer relationship management program developed by
 * SugarCRM, Inc. Copyright (C) 2004-2013 SugarCRM Inc.

 * SuiteCRM is an extension to SugarCRM Community Edition developed by Salesagility Ltd.
 * Copyright (C) 2011 - 2014 Salesagility Ltd.
 *
 * This program is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Affero General Public License version 3 as published by the
 * Free Software Foundation with the addition of the following permission added
 * to Section 15 as permitted in Section 7(a): FOR ANY PART OF THE COVERED WORK
 * IN WHICH THE COPYRIGHT IS OWNED BY SUGARCRM, SUGARCRM DISCLAIMS THE WARRANTY
 * OF NON INFRINGEMENT OF THIRD PARTY RIGHTS.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more
 * details.
 *
 * You should have received a copy of the GNU Affero General Public License along with
 * this program; if not, see http://www.gnu.org/licenses or write to the Free
 * Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
 * 02110-1301 USA.
 *
 * You can contact SugarCRM, Inc. headquarters at 10050 North Wolfe Road,
 * SW2-130, Cupertino, CA 95014, USA. or at email address contact@sugarcrm.com.
 *
 * The interactive user interfaces in modified source and object code versions
 * of this program must display Appropriate Legal Notices, as required under
 * Section 5 of the GNU Affero General Public License version 3.
 *
 * In accordance with Section 7(b) of the GNU Affero General Public License version 3,
 * these Appropriate Legal Notices must retain the display of the "Powered by
 * SugarCRM" logo and "Supercharged by SuiteCRM" logo. If the display of the logos is not
 * reasonably feasible for  technical reasons, the Appropriate Legal Notices must
 * display the words  "Powered by SugarCRM" and "Supercharged by SuiteCRM".
 ********************************************************************************/

*}

{{include file='themes/SuiteP/include/DetailView/header.tpl'}}
{sugar_include include=$includes}
<div>
    {{counter name="tabCount" start=-1 print=false assign="tabCount"}}
    <ul class="nav nav-tabs">
        {{foreach name=section from=$sectionPanels key=label item=panel}}
        {{capture name=label_upper assign=label_upper}}{{$label|upper}}{{/capture}}
        {* override from tab definitions *}
        {{if (isset($tabDefs[$label_upper].newTab) && $tabDefs[$label_upper].newTab == true)}}
        {{counter name="tabCount" print=false}}
        {{if $tabCount == '0'}}
        <li role="presentation" class="active">
            <a id="tab{{$tabCount}}" href="#tab-content-{{$tabCount}}" data-toggle="tab" class="hidden-xs">
                {sugar_translate label='{{$label}}' module='{{$module}}'}
            </a>
            <a id="xstab{{$tabCount}}" href="#" class="visible-xs first-tab-xs dropdown-toggle" data-toggle="dropdown">
                {sugar_translate label='{{$label}}' module='{{$module}}'}
            </a>
            <ul id="first-tab-menu-xs" class="dropdown-menu">
                {{counter name="tabCountXS" start=-1 print=false assign="tabCountXS"}}
                {{foreach name=sectionXS from=$sectionPanels key=label item=panelXS}}
                {{counter name="tabCountXS" print=false}}
                <li role="presentation">
                    <a id="tab{{$tabCountXS}}" href="#tab-content-{{$tabCountXS}}" data-toggle="tab" onclick="changeFirstTab(this, 'tab-content-{{$tabCountXS}}');">
                        {sugar_translate label='{{$label}}' module='{{$module}}'}
                    </a>
                </li>
                {{/foreach}}
            </ul>
        </li>
        {{else}}
        <li role="presentation" class="hidden-xs">
            <a id="tab{{$tabCount}}" href="#tab-content-{{$tabCount}}" data-toggle="tab">
                {sugar_translate label='{{$label}}' module='{{$module}}'}
            </a>
        </li>
        {{/if}}
        {{/if}}
        {{/foreach}}
        <li id="tab-actions" class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">{{$APP.LBL_LINK_ACTIONS}}</a>
            <ul class="dropdown-menu">
                {{if !isset($form.buttons)}}
                    <li>{{sugar_button module="$module" id="EDIT" view="$view" form_id="formDetailView"}}</li>
                    <li>{{sugar_button module="$module" id="DUPLICATE" view="EditView" form_id="formDetailView"}}</li>
                    <li>{{sugar_button module="$module" id="DELETE" view="$view" form_id="formDetailView"}}</li>
                {{else}}
                    {{counter assign="num_buttons" start=0 print=false}}
                    {{foreach from=$form.buttons key=val item=button}}
                        {{if !is_array($button) && in_array($button, $built_in_buttons)}}
                            {{counter print=false}}
                            <li>{{sugar_button module="$module" id="$button" view="EditView" form_id="formDetailView"}}</li>
                        {{/if}}
                    {{/foreach}}
                    {{if count($form.buttons) > $num_buttons}}
                        {{foreach from=$form.buttons key=val item=button}}
                            {{if is_array($button) && $button.customCode}}
                               <li>{{sugar_button module="$module" id="$button" view="EditView" form_id="formDetailView"}}</li>
                            {{/if}}
                        {{/foreach}}
                    {{/if}}
                    {{if empty($form.hideAudit) || !$form.hideAudit}}
                        {{sugar_button module="$module" id="Audit" view="EditView" form_id="formDetailView"}}
                    {{/if}}
                {{/if}}
            </ul>
        </li>
    </ul>
    <div class="clearfix"></div>
    <div class="tab-content">
        {{* Loop through all top level panels first *}}
        {{counter name="panelCount" print=false start=0 assign="panelCount"}}
        {{counter name="tabCount" start=-1 print=false assign="tabCount"}}
        {{foreach name=section from=$sectionPanels key=label item=panel}}
        {{assign var='panel_id' value=$panelCount}}
        {{capture name=label_upper assign=label_upper}}
        {{$label|upper}}
        {{/capture}}
        {{counter name="tabCount" print=false}}

        {{if $tabCount == '0'}}
        <div class="tab-pane active fade in" id='tab-content-{{$tabCount}}'>
            test{{$tabCount}}
        </div>
        {{else}}
        <div class="tab-pane fade" id='tab-content-{{$tabCount}}'>
            test{{$tabCount}}
        </div>
        {{/if}}

        {{/foreach}}
    </div>
</div>
{{include file=''}}
<script type="text/javascript" src="modules/Favorites/favorites.js"></script>
