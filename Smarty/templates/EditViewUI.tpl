{*<!--
/*********************************************************************************
  ** The contents of this file are subject to the vtiger CRM Public License Version 1.0
   * ("License"); You may not use this file except in compliance with the License
   * The Original Code is:  vtiger CRM Open Source
   * The Initial Developer of the Original Code is vtiger.
   * Portions created by vtiger are Copyright (C) vtiger.
   * All Rights Reserved.
 ********************************************************************************/
-->*}
		{if isset($maindata[0][0])}
			{assign var="uitype" value=$maindata[0][0]}
		{else}
			{assign var="uitype" value=''}
		{/if}
		{if isset($maindata[1][0])}
			{assign var="fldlabel" value=$maindata[1][0]}
		{else}
			{assign var="fldlabel" value=''}
		{/if}
		{if isset($maindata[1][1])}
			{assign var="fldlabel_sel" value=$maindata[1][1]}
		{else}
			{assign var="fldlabel_sel" value=''}
		{/if}
		{if isset($maindata[1][2])}
			{assign var="fldlabel_combo" value=$maindata[1][2]}
		{else}
			{assign var="fldlabel_combo" value=''}
		{/if}
		{if isset($maindata[1][3])}
			{assign var="fldlabel_other" value=$maindata[1][3]}
		{else}
			{assign var="fldlabel_other" value=''}
		{/if}
		{if isset($maindata[2][0])}
			{assign var="fldname" value=$maindata[2][0]}
		{else}
			{assign var="fldname" value=''}
		{/if}
		{if isset($maindata[3][0])}
			{assign var="fldvalue" value=$maindata[3][0]}
		{else}
			{assign var="fldvalue" value=''}
		{/if}
		{if isset($maindata[3][1])}
			{assign var="secondvalue" value=$maindata[3][1]}
		{else}
			{assign var="secondvalue" value=''}
		{/if}
		{if isset($maindata[3][2])}
			{assign var="thirdvalue" value=$maindata[3][2]}
		{else}
			{assign var="thirdvalue" value=''}
		{/if}
		{if isset($maindata[4])}
			{assign var="typeofdata" value=$maindata[4]}
		{else}
			{assign var="typeofdata" value=''}
		{/if}
		{if isset($maindata[5][0])}
			{assign var="vt_tab" value=$maindata[5][0]}
		{else}
			{assign var="vt_tab" value=''}
		{/if}
		{if $typeofdata eq 'M'}
			{assign var="mandatory_field" value="*"}
		{else}
			{assign var="mandatory_field" value=""}
		{/if}
		{* vtlib customization: Help information for the fields *}
		{assign var="usefldlabel" value=$fldlabel}
		{assign var="fldhelplink" value=""}
		{if isset($FIELDHELPINFO) && isset($FIELDHELPINFO.$fldname)}
			{assign var="fldhelplinkimg" value='help_icon.gif'|@vtiger_imageurl:$THEME}
			{assign var="fldhelplink" value="<img style='cursor:pointer' onclick='vtlib_field_help_show(this, \"$fldname\");' border=0 src='$fldhelplinkimg'>"}
			{if $uitype neq '10'}
				{assign var="usefldlabel" value="$fldlabel $fldhelplink"}
			{/if}
		{/if}

		{if $uitype eq '10'}
            <!-- Field: UI type 10 -->
            {* Some field logic *}
			{assign var="use_parentmodule" value=$fldlabel.options.0}
			{assign var=vtui10func value=$use_parentmodule|getvtlib_open_popup_window_function:$fldname:$MODULE}
           	{if count($fldlabel.options) eq 1}
           	<input type='hidden' class='small' name="{$fldname}_type" id="{$fldname}_type" value="{$use_parentmodule}">
           	<input id="{$fldname}" name="{$fldname}" type="hidden" value="{$fldvalue.entityid}">
           	{/if}
            <div class="slds-col slds-size_1-of-2 slds-grid">
                <div class="slds-form-element slds-p-horizontal_small">
                    <label class="slds-form-element__label">
                    	{if $mandatory_field == '*'}<abbr class="slds-required" title="required">* </abbr>{/if}{$fldlabel.displaylabel}
					</label>
                    <div class="slds-form-element__control">
                        <div class="slds-grid">
                        	{if $MASS_EDIT == '1'}
                        	{* Mass-editing, add the checkbox *}
                            <div class="slds-col slds-size_1-of-12 slds-m-right_small">
                                <div class="slds-checkbox_add-button">
                                    <input class="slds-assistive-text" type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" />
                                    <label for="{$fldname}_mass_edit_check" class="slds-checkbox_faux">
                                        <span class="slds-assistive-text">{$fldname}</span>
                                    </label>
                                </div>
							</div>
                            <div class="slds-col slds-grid slds-size_11-of-12">
                            {/if}
                            	<div class="slds-col slds-size_4-of-12 slds-p-left--none slds-p-right_xxx-small">
                            		<div class="slds-select_container">
                            			{if $fromlink eq 'qcreate'}
                            			<select class="slds-select" id="{$fldname}_type" name="{$fldname}_type" onChange='document.QcEditView.{$fldname}_display.value=""; document.QcEditView.{$fldname}.value="";'>
                        				{else}
                        				<select id="{$fldname}_type" class="slds-select" name="{$fldname}_type" onChange='document.EditView.{$fldname}_display.value=""; document.EditView.{$fldname}.value="";document.getElementById("qcform").innerHTML=""'>
                        				{/if}
                        				{foreach item=option from=$fldlabel.options}
                        				<option value="{$option}"
                        				{if $fldlabel.selected == $option}selected{/if}>
                        				{$option|@getTranslatedString:$option}
	                        			</option>
	                        			{/foreach}
                            			</select>
                            		</div>                            		
                            	</div>
                                <div class="slds-col slds-size_6-of-12 slds-p-left--none slds-p-right_xxx-small">
								{if ( isset($maindata['extendedfieldinfo']) && isset($maindata['extendedfieldinfo']['searchfields']) )}
									{assign var="autocomp" value=$maindata['extendedfieldinfo'] }
									<input
										id="{$fldname}_display"
										name="{$fldname}_display"
										type="text"
										value="{$fldvalue.displayvalue}"
										autocomplete="off"
										class="autocomplete-input slds-input"
										style="background-color: #ffffff; border: 1px solid rgb(221, 219, 218);" 
										data-autocomp='{$maindata["extendedfieldinfo"]|@json_encode}'>
										<div id="listbox-unique-id" role="listbox" class="">
											<ul class="slds-listbox slds-listbox_vertical slds-dropdown slds-dropdown_fluid relation-autocomplete__target" style="opacity: 0; width: 100%; list-style-type: none; width: 90%; left: 0; transform: translateX(0); max-width: none;" role="presentation"></ul>
										</div>										
								{else}
									<input
										id="{$fldname}_display"
										name="{$fldname}_display"
										readonly
										type="text"
										class="autocomplete-input slds-input" 
										style="background-color: #ffffff; border: 1px solid rgb(221, 219, 218);"
										value="{$fldvalue.displayvalue}">
								{/if}
                                </div>
                                <div class="slds-col slds-size_2-of-12 slds-p-horizontal_none">
                                    <div class="slds-button-group">
                                        <button type="button" class="slds-button slds-button_icon slds-button_icon-border" title="{'LBL_SELECT'|@getTranslatedString}" onclick='return {$vtui10func}("{$fromlink}","{$fldname}","{$MODULE}","{if isset($ID)}{$ID}{/if}");'>
                                            <svg class="slds-button__icon" aria-hidden="true">
                                                <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#add"></use>
                                            </svg>
                                            <span class="slds-assistive-text">{'LBL_SELECT'|@getTranslatedString}</span>
                                        </button>
                                        <button type="button" class="slds-button slds-button_icon slds-button_icon-border" title="{'LBL_CLEAR'|@getTranslatedString}" onClick="this.form.{$fldname}.value=''; this.form.{$fldname}_display.value=''; return false;">
                                            <svg class="slds-button__icon" aria-hidden="true">
                                                <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#delete"></use>
                                            </svg>
                                            <span class="slds-assistive-text">{'LBL_CLEAR'|@getTranslatedString}</span>
                                        </button>
                                    </div>
                                </div>
                            {if $MASS_EDIT == '1'}
                            {* Close the extra div when mass-editing *}
                            </div>
                            {/if}
                        </div>
                    </div>
                </div>
            </div>
            <!-- // Field: UI type 10  -->

		{elseif $uitype eq 2}
            <!-- Field: UI type 2 -->
            <div class="slds-col slds-size_1-of-2 slds-grid">
                <div class="slds-form-element slds-p-horizontal_small">
                    <label class="slds-form-element__label">
                    	{if $mandatory_field == '*'}<abbr class="slds-required" title="required">* </abbr>{/if}{$usefldlabel}
                	</label>
                    <div class="slds-form-element__control">
                    	{if $MASS_EDIT eq '1'}
                    		{* Mass edit mode, so include the checkbox *}
	                        <div class="slds-grid">
	                            <div class="slds-col slds-size_1-of-12 slds-m-right_small">
	                                <div class="slds-checkbox_add-button">
	                                    <input class="slds-assistive-text" type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" />
	                                    <label for="{$fldname}_mass_edit_check" class="slds-checkbox_faux">
	                                        <span class="slds-assistive-text">{$usefldlabel}</span>
	                                    </label>
	                                </div>
	                            </div>
	                            <div class="slds-col slds-size_11-of-12">
								{if ( isset($maindata['extendedfieldinfo']) && isset($maindata['extendedfieldinfo']['searchfields']) )}
									{assign var="autocomp" value=$maindata['extendedfieldinfo'] }
									<div style="position: relative;">
									<input
										type="text"
										name="{$fldname}"
										id="{$fldname}"
										tabindex="{$vt_tab}"
										value="{$fldvalue}"
										tabindex="{$vt_tab}"
										autocomplete="off"
										class="autocomplete-input detailedViewTextBox slds-input"
										data-autocomp='{$maindata["extendedfieldinfo"]|@json_encode}' />
										<div role="listbox" class="">
											<ul class="slds-listbox slds-listbox_vertical slds-dropdown slds-dropdown_fluid relation-autocomplete__target" style="opacity: 0; width: 100%; list-style-type: none; width: 90%; left: 0; transform: translateX(0); max-width: none;" role="presentation"></ul>
										</div>
									</div>
								{else}
									<input type="text" name="{$fldname}" id="{$fldname}" tabindex="{$vt_tab}" value="{$fldvalue}" tabindex="{$vt_tab}" class="detailedViewTextBox slds-input">
								{/if}	                            	
	                            </div>
	                        </div>
                        {else}
                        	{* Normal mode, don't include the checkbox *}
                        	<input type="text" name="{$fldname}" id="{$fldname}" tabindex="{$vt_tab}" value="{$fldvalue}" tabindex="{$vt_tab}" class="detailedViewTextBox slds-input">
                        {/if}
                    </div>
                </div>
            </div>
            <!-- // Field: UI type 2 -->
		{elseif $uitype eq 1025}
			<td width=20% class="dvtCellLabel{if $mandatory_field == '*'} mandatory_field_label{/if}" align=right>
			<font color="red">{$mandatory_field}</font>
			{$fldlabel.displaylabel}

			{assign var="use_parentmodule" value=$fldlabel.options.0}
			{assign var=vtui10func value=$use_parentmodule|getvtlib_open_popup_window_function:$fldname:$MODULE}
			{if count($fldlabel.options) eq 1}
				<input type='hidden' class='small' name="{$fldname}_type" id="{$fldname}_type" value="{$use_parentmodule}">
			{else}
				<br>
				{if $fromlink eq 'qcreate'}
				<select id="{$fldname}_type" class="small" name="{$fldname}_type" onChange='document.QcEditView.{$fldname}_display.value=""; document.QcEditView.{$fldname}.value="";'>
				{else}
				<select id="{$fldname}_type" class="small" name="{$fldname}_type" onChange='document.EditView.{$fldname}_display.value=""; document.EditView.{$fldname}.value="";document.getElementById("qcform").innerHTML=""'>
				{/if}
				{foreach item=option from=$fldlabel.options}
					<option value="{$option}"
					{if $fldlabel.selected == $option}selected{/if}>
					{$option|@getTranslatedString:$option}
					</option>
				{/foreach}
				</select>
			{/if}
			{if $MASS_EDIT eq '1'}<input type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" class="small" >{/if}
			{$fldhelplink}

			</td>
			<td width="30%" align=left class="dvtCellInfo">
				<input id="{$fldname}" name="{$fldname}" type="hidden" value="{$fldvalue.entityid}">

				<div style="position: relative;">
				{if ( isset($maindata['extendedfieldinfo']) && isset($maindata['extendedfieldinfo']['searchfields']) )}
					{assign var="autocomp" value=$maindata['extendedfieldinfo'] }
					<input
						id="{$fldname}_display"
						name="{$fldname}_display"
						type="text"
						style="border:1px solid #bababa;"
						value="{$fldvalue.displayvalue}"
						autocomplete="off"
						class="autocomplete-input"
						data-autocomp='{$maindata["extendedfieldinfo"]|@json_encode}'>&nbsp;
				{else}
					<input
						id="{$fldname}_display"
						name="{$fldname}_display"
						type="text"
						style="border:1px solid #bababa;"
						value="{$fldvalue.displayvalue}">&nbsp;
				{/if}
				<input type="image" src="{'clear_field.gif'|@vtiger_imageurl:$THEME}"
alt="{'LBL_CLEAR'|@getTranslatedString}" title="{'LBL_CLEAR'|@getTranslatedString}" onClick="this.form.{$fldname}.value=''; this.form.{$fldname}_display.value=''; return false;" align="absmiddle" style='cursor:hand;cursor:pointer'>&nbsp;
				{if ( isset($maindata['extendedfieldinfo']) && isset($maindata['extendedfieldinfo']['searchfields']) )}
					<div id="listbox-unique-id" role="listbox" class="">
						<ul class="slds-listbox slds-listbox_vertical slds-dropdown slds-dropdown_fluid relation-autocomplete__target" style="opacity: 0; width: 100%; list-style-type: none; width: 90%; left: 0; transform: translateX(0); max-width: none;" role="presentation"></ul>
					</div>
				{/if}
				</div>
			</td>
		{elseif $uitype eq 3 || $uitype eq 4}<!-- Non Editable field, only configured value will be loaded -->
				<td width=20% class="dvtCellLabel{if $mandatory_field == '*'} mandatory_field_label{/if}" align=right><font color="red">{$mandatory_field}</font>{$usefldlabel} {if $MASS_EDIT eq '1'}<input type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" class="small">{/if}</td>
				<td width=30% align=left class="dvtCellInfo"><input readonly type="text" tabindex="{$vt_tab}" name="{$fldname}" id ="{$fldname}" {if $MODE eq 'edit'} value="{$fldvalue}" {else} value="{$MOD_SEQ_ID}" {/if} class=detailedViewTextBox onFocus="this.className='detailedViewTextBoxOn'" onBlur="this.className='detailedViewTextBox'"></td>

		{elseif $uitype eq 11 || $uitype eq 1 || $uitype eq 13 || $uitype eq 7 || $uitype eq 17 || $uitype eq 85 || $uitype eq 14}
            <!-- Field: UI type 1 / 11 / 13 / 7 / 17 / 85 / 14 -->
            <div class="slds-col slds-size_1-of-2 slds-grid">
                <div class="slds-form-element slds-p-horizontal_small">
                    <label class="slds-form-element__label">
                    	{if $mandatory_field == '*'}<abbr class="slds-required" title="required">* </abbr>{/if}{$usefldlabel}{if $uitype == 14}&nbsp;{"LBL_TIMEFIELD"|@getTranslatedString}{/if}
                	</label>
                    <div class="slds-form-element__control">
                        <div class="slds-grid">                    	
	                	{if $MASS_EDIT eq '1'}
	            		{* Mass edit mode, so include the checkbox *}
                            <div class="slds-col slds-size_1-of-12 slds-m-right_small">
                                <div class="slds-checkbox_add-button">
                                    <input class="slds-assistive-text" type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" />
                                    <label for="{$fldname}_mass_edit_check" class="slds-checkbox_faux">
                                        <span class="slds-assistive-text">{$usefldlabel}</span>
                                    </label>
                                </div>
                            </div>
                            <div class="slds-col slds-size_11-of-12">
                            	<div class="slds-form-element__control{if $uitype eq 85} slds-input-has-icon slds-input-has-icon_left{/if}">
                        {else}
                        	<div class="slds-col slds-size_12-of-12">
                        		<div class="slds-form-element__control{if $uitype eq 85} slds-input-has-icon slds-input-has-icon_left{/if}">
                        {/if}
									{if $uitype eq 85}
									<svg class="slds-icon slds-input__icon slds-input__icon_left slds-icon-text-default" aria-hidden="true">
										<use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#call" xmlns:xlink="http://www.w3.org/1999/xlink" />
									</svg>									
									{/if}
                                	<input type="text" tabindex="{$vt_tab}" name="{$fldname}" id="{$fldname}" value="{$fldvalue}" class="detailedViewTextBox slds-input"{if $uitype == 17} onkeyup="validateUrl('{$fldname}');"{/if} />
                            	</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- // Field: UI type 1 / 11 / 13 / 7 / 17 -->
		{elseif $uitype eq 9}
            <!-- Field: UI type 9 -->
            <div class="slds-col slds-size_1-of-2 slds-grid">
                <div class="slds-form-element slds-p-horizontal_small">
                    <label class="slds-form-element__label">
                    	{if $mandatory_field == '*'}<abbr class="slds-required" title="required">* </abbr>{/if}{$usefldlabel} {$APP.COVERED_PERCENTAGE}
                	</label>
                    <div class="slds-form-element__control">
                        <div class="slds-grid">                    	
	                	{if $MASS_EDIT eq '1'}
	            		{* Mass edit mode, so include the checkbox *}
                            <div class="slds-col slds-size_1-of-12 slds-m-right_small">
                                <div class="slds-checkbox_add-button">
                                    <input class="slds-assistive-text" type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" />
                                    <label for="{$fldname}_mass_edit_check" class="slds-checkbox_faux">
                                        <span class="slds-assistive-text">{$usefldlabel}</span>
                                    </label>
                                </div>
                            </div>
                            <div class="slds-col slds-size_11-of-12">
                        {else}
                        	<div class="slds-col slds-size_12-of-12">
                        {/if}
                                <input type="text" tabindex="{$vt_tab}" name="{$fldname}" id ="{$fldname}" value="{$fldvalue}" class="slds-input" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- // Field: UI type 9 -->		

		{elseif $uitype eq 19 || $uitype eq 20}
            <!-- Field: UI type 19 and 20-->
            {* Some field logic *}
            {* In Add Comment we should not display anything *}
			{assign var="i18nAddComment" value='LBL_ADD_COMMENT'|@getTranslatedString:$MODULE}
			{assign var="i18nSolution" value='Solution'|@getTranslatedString:$MODULE}
			{if $fldlabel eq $i18nAddComment}
				{assign var=fldvalue value=""}
			{/if}            
            <div class="slds-col slds-grid">
                <div class="slds-form-element slds-p-horizontal_small">
                    <label class="slds-form-element__label">
                    	{if $mandatory_field == '*'}<abbr class="slds-required" title="required">* </abbr>{/if}{$usefldlabel}
                	</label>
                    <div class="slds-form-element__control">
                    	{if $MASS_EDIT eq '1'}
                    	{* Mass-edit so include the checkbox *}
	                        <div class="slds-grid">
	                            <div class="slds-col slds-size_1-of-12 slds-m-right_small">
	                                <div class="slds-checkbox_add-button">
	                                    <input class="slds-assistive-text" type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" />
	                                    <label for="{$fldname}_mass_edit_check" class="slds-checkbox_faux">
	                                        <span class="slds-assistive-text">{$usefldlabel}</span>
	                                    </label>
	                                </div>
	                            </div>
	                            <div class="slds-col slds-size_11-of-12">
                        {/if}
	                                <textarea value="{$fldvalue}" name="{$fldname}" id="{$fldname}" tabindex="{$vt_tab}" class="slds-textarea" rows="8">{$fldvalue}</textarea>
									{if $fldlabel eq $i18nSolution}
									<input type="hidden" name="helpdesk_solution" id="helpdesk_solution" value='{$fldvalue}'>
									{/if}	                                
	                    {if $MASS_EDIT eq '1'}
	                    {* Close the extra checkbox divs when mass-editing *}
	                            </div>
	                        </div>
                        {/if}
                    </div>
                </div>
            </div>
			{if ($fldname eq 'notecontent') || (isset($maindata['extendedfieldinfo']) && isset($maindata['extendedfieldinfo']['RTE']) && $maindata['extendedfieldinfo']['RTE'] && vt_hasRTE())}
			<script>
				CKEDITOR.replace('{$fldname}',
				{ldelim}
					extraPlugins : 'uicolor',
					uiColor: '#dfdff1',
						on : {ldelim}
							instanceReady : function( ev ) {ldelim}
								 this.dataProcessor.writer.setRules( 'p',  {ldelim}
									indent : false,
									breakBeforeOpen : false,
									breakAfterOpen : false,
									breakBeforeClose : false,
									breakAfterClose : false
							{rdelim});
						{rdelim}
					{rdelim}
				{rdelim});
				var oCKeditor{$fldname} = CKEDITOR.instances[{$fldname}];
			</script>
			{/if}            
            <!-- // Field: UI type 19 and 20 -->		

		{elseif $uitype eq 21 || $uitype eq 22 || $uitype eq 24}
            <!-- Field: UI type 21 / 22 / 24 -->
            <div class="slds-col slds-size_1-of-2 slds-grid">
                <div class="slds-form-element slds-p-horizontal_small">
                    <label class="slds-form-element__label">
                    	{if $mandatory_field == '*' || $uitype == 22}<abbr class="slds-required" title="required">* </abbr>{/if}{$usefldlabel}
                	</label>
                    <div class="slds-form-element__control">
                    	{if $MASS_EDIT eq '1'}
                    	{* Mass-edit so include the checkbox *}
	                        <div class="slds-grid">
	                            <div class="slds-col slds-size_1-of-12 slds-m-right_small">
	                                <div class="slds-checkbox_add-button">
	                                    <input class="slds-assistive-text" type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" />
	                                    <label for="{$fldname}_mass_edit_check" class="slds-checkbox_faux">
	                                        <span class="slds-assistive-text">{$usefldlabel}</span>
	                                    </label>
	                                </div>
	                            </div>
	                            <div class="slds-col slds-size_11-of-12">
                        {/if}
	                                <textarea value="{$fldvalue}" name="{$fldname}" id="{$fldname}" tabindex="{$vt_tab}" class="slds-textarea" rows="2">{$fldvalue}</textarea>
	                    {if $MASS_EDIT eq '1'}
	                    {* Close the extra checkbox divs when mass-editing *}
	                            </div>
	                        </div>
                        {/if}
                    </div>
                </div>
            </div>
            <!-- // Field: UI type 21 / 22 / 24 -->

		{elseif $uitype eq 15 || $uitype eq 16  || $uitype eq 77 || $uitype eq '31' || $uitype eq '32' || $uitype eq '1613' || $uitype eq '1614'}
            <!-- Field: UI type 15 / 16 / 31 / 32 / 1613 / 1614-->
            <div class="slds-col slds-size_1-of-2 slds-grid">
                <div class="slds-form-element slds-p-horizontal_small">
                    <label class="slds-form-element__label">
                    	{if $mandatory_field == '*'}<abbr class="slds-required" title="required">* </abbr>{/if}{$usefldlabel}
                	</label>
                    <div class="slds-form-element__control">
                    	{if $MASS_EDIT == '1'}
                    	{* We're in mass edit. Show checbox *}
                        <div class="slds-grid">
                            <div class="slds-col slds-size_1-of-12 slds-m-right_small">
                                <div class="slds-checkbox_add-button">
                                    <input class="slds-assistive-text" type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" />
                                    <label for="{$fldname}_mass_edit_check" class="slds-checkbox_faux">
                                        <span class="slds-assistive-text">{$fldname}</span>
                                    </label>
                                </div>
                            </div>
                            <div class="slds-col slds-size_11-of-12">
                        {/if}
                                <div class="slds-form-element slds-col slds-grid slds-p-horizontal_none">
                                    <div class="slds-form-element__control slds-col slds-p-horizontal_none">
                                        <div class="slds-select_container">
                                            <select class="slds-select" name="{$fldname}" id="{$fldname}" tabindex="{$vt_tab}">
                                            {if $uitype != 77}
												{foreach item=arr from=$fldvalue}
													<option value="{$arr[1]}" {$arr[2]}>{$arr[0]}</option>
												{foreachelse}
													<option value=""></option>
													<option value="" disabled>{$APP.LBL_NONE}</option>
												{/foreach}
											{else}
												{foreach key=key_one item=arr from=$fldvalue}
													{foreach key=sel_value item=value from=$arr}
														<option value="{$key_one}" {$value}>{$sel_value}</option>
													{/foreach}
												{/foreach}											
											{/if}
                                            </select>
                                        </div>
                                    </div>
                                </div>
                        {if $MASS_EDIT == '1'}
                        {* Close the extra checkbox divs when mass-editing *}
                            </div>
                        </div>
                        {/if}
                    </div>
                </div>
            </div>
            <!-- // Field: UI type 15 / 16 / 31 / 32 / 1613 / 1614 -->
		{elseif $uitype eq '1615'}
			<td width="20%" class="dvtCellLabel{if $mandatory_field == '*'} mandatory_field_label{/if}" align=right>
				<font color="red">{$mandatory_field}</font>
				{$usefldlabel} {if $MASS_EDIT eq '1'}<input type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" class="small" >{/if}
			</td>
			<td width="30%" align=left class="dvtCellInfo">
				<select name="{$fldname}" id="{$fldname}" tabindex="{$vt_tab}" class="small" style="width:280px;">
				<option value="">{$APP.LBL_NONE}</option>
				{foreach item=arr from=$fldvalue}
					<optgroup label="{$arr[0]}">
					{foreach item=plarr key=plkey from=$arr[3]}
						{assign var=plvalue value="{$arr[1]}::{$plkey}"}
						<option value="{$plvalue}" {if $plvalue eq $arr[2]}selected{/if}>{$plarr|@getTranslatedString:$arr[0]}</option>
					{/foreach}
					</optgroup>
				{/foreach}
				</select>
			</td>
		{elseif $uitype eq '1616'}
			<td width="20%" class="dvtCellLabel{if $mandatory_field == '*'} mandatory_field_label{/if}" align=right>
				<font color="red">{$mandatory_field}</font>
				{$usefldlabel} {if $MASS_EDIT eq '1'}<input type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" class="small" >{/if}
			</td>
			<td width="30%" align=left class="dvtCellInfo">
				<select name="{$fldname}" id="{$fldname}" tabindex="{$vt_tab}" class="small" style="width:280px;">
				<option value="">{$APP.LBL_NONE}</option>
				{foreach item=arr from=$fldvalue}
					<option value="{$arr[1]}" {$arr[3]}>{$arr[2]}</option>
				{/foreach}
				</select>
			</td>
		{elseif $uitype eq 33 || $uitype eq 3313 || $uitype eq 3314 || $uitype eq 1024}
            <!-- Field: UI type 33 / 3313 / 3314 / 1024 -->
            {* Some template logic *}
			{if (isset($maindata['extendedfieldinfo']) && isset($maindata['extendedfieldinfo']['columns']))}
				{assign var=mplsize value=$maindata['extendedfieldinfo']['columns']}
			{else}
				{assign var=mplsize value=4}
			{/if}
			{if (isset($maindata['extendedfieldinfo']) && isset($maindata['extendedfieldinfo']['width']))}
				{assign var=mplwidth value=$maindata['extendedfieldinfo']['width']}
			{else}
				{assign var=mplwidth value=280}
			{/if}           
            <div class="slds-col slds-size_1-of-2 slds-grid">
                <div class="slds-form-element slds-p-horizontal_small">
                    <label class="slds-form-element__label">
                    	{if $mandatory_field == '*'}<abbr class="slds-required" title="required">* </abbr>{/if}{$usefldlabel}
                	</label>
                    <div class="slds-form-element__control">
                    	{if $MASS_EDIT == '1'}
                    	{* We're in mass edit. Show checbox *}
                        <div class="slds-grid">
                            <div class="slds-col slds-size_1-of-12 slds-m-right_small">
                                <div class="slds-checkbox_add-button">
                                    <input class="slds-assistive-text" type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" />
                                    <label for="{$fldname}_mass_edit_check" class="slds-checkbox_faux">
                                        <span class="slds-assistive-text">{$fldname}</span>
                                    </label>
                                </div>
                            </div>
                            <div class="slds-col slds-size_11-of-12">
                        {/if}
                                <div class="slds-form-element slds-col slds-grid slds-p-horizontal_none">
                                    <div class="slds-form-element__control slds-col slds-p-horizontal_none">
                                        <div class="slds-select_container">
                                            <select multiple="multiple" name="{$fldname}[]" id="{$fldname}" size="{$mplsize}" class="slds-select" tabindex="{$vt_tab}">
                                        	{foreach item=arr from=$fldvalue}
												<option value="{$arr[1]}" {$arr[2]}>{$arr[0]}</option>
											{/foreach}
                                            </select>
                                        </div>
                                    </div>
                                </div>
                        {if $MASS_EDIT == '1'}
                        {* Close the extra checkbox divs when mass-editing *}
                            </div>
                        </div>
                        {/if}
                    </div>
                </div>
            </div>
            <!-- // Field: UI type 33 / 3313 / 3314 / 1024 -->		

		{elseif $uitype eq 53}
			<!-- Field: UI type 53 -->
			{* Some field logic *}
			{assign var=check value=1}
			{foreach key=key_one item=arr from=$fldvalue}
				{foreach key=sel_value item=value from=$arr}
					{if $value ne ''}
						{assign var=check value=$check*0}
					{else}
						{assign var=check value=$check*1}
					{/if}
				{/foreach}
			{/foreach}

            <div class="slds-col slds-size_1-of-2 slds-grid">
                <div class="slds-form-element slds-p-horizontal_small">
                    <label class="slds-form-element__label">
                    	{if $mandatory_field == '*'}<abbr class="slds-required" title="required">* </abbr>{/if}{$usefldlabel}
                	</label>
                	<div class="slds-form-element__control">
                    	{if $MASS_EDIT eq '1'}
                    	{* We're mass editing, so include the checkbox *}                		
                        <div class="slds-grid">
                            <div class="slds-col slds-size_1-of-12 slds-m-right_small">
                                <div class="slds-checkbox_add-button">
                                    <input class="slds-assistive-text" type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" />
                                    <label for="{$fldname}_mass_edit_check" class="slds-checkbox_faux">
                                        <span class="slds-assistive-text">{$usefldlabel}</span>
                                    </label>
                                </div>
                            </div>
                            <div class="slds-col slds-size_11-of-12">
                        {/if}
                                <div class="slds-form-element slds-col slds-grid slds-p-horizontal_none">
                                    <div class="slds-form-element__control slds-col slds-p-horizontal_none">
                                        <div class="slds-grid">
                                            <div class="slds-col slds-size_5-of-12 slds-p-horizontal_none">
                                                <div class="slds-radio_button-group">
                                                    <span class="slds-button slds-radio_button">
                                                        <input tabindex="{$vt_tab}" name="assigntype" id="assigntype_u" type="radio"{if $check == 0} checked="checked"{/if} value="U" onclick="toggleAssignType(this.value)">
                                                        <label class="slds-radio_button__label" for="assigntype_u">
                                                            <span class="slds-radio_faux">{$APP.LBL_USER}</span>
                                                        </label>
                                                    </span>
                                                    {if $secondvalue neq ''}
                                                    <span class="slds-button slds-radio_button">
                                                        <input tabindex="{$vt_tab}" name="assigntype" id="assigntype_t" type="radio"{if $check != 0} checked="checked"{/if} value="T" onclick="toggleAssignType(this.value)">
                                                        <label class="slds-radio_button__label" for="assigntype_t">
                                                            <span class="slds-radio_faux">{$APP.LBL_GROUP}</span>
                                                        </label>
                                                    </span>
                                                    {/if}
                                                </div>
                                            </div>
                                            <div class="slds-col slds-size_7-of-12 slds-p-horizontal_none">
                                                <div class="slds-select_container{if $check != 0} slds-hide{else} slds-show{/if}" id="assign_user">
                                                    <select class="slds-select" name="{$fldname}" id="{$fldname}">
														{foreach key=key_one item=arr from=$fldvalue}
															{foreach key=sel_value item=value from=$arr}
																<option value="{$key_one}" {$value}>{$sel_value}</option>
															{/foreach}
														{/foreach}
                                                    </select>
                                                </div>
                                                {if $secondvalue neq ''}
                                                <div class="slds-select_container{if $check == 0} slds-hide{else} slds-show{/if}" id="assign_team">
                                                    <select class="slds-select" name="assigned_group_id" id="assigned_group_id">
														{foreach key=key_one item=arr from=$secondvalue}
															{foreach key=sel_value item=value from=$arr}
																<option value="{$key_one}" {$value}>{$sel_value}</option>
															{/foreach}
														{/foreach}
                                                    </select>
                                                </div>
                                                {/if}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                        {if $MASS_EDIT eq '1'}
                    	{* We're mass editing, so close the checkbox extra divs *}
                            </div>
                        </div>
                        {/if}
                    </div>
                </div>
            </div>
			<!-- // Field: UI type 53 -->		
		{elseif $uitype eq 52}	
			<td width="20%" class="dvtCellLabel{if $mandatory_field == '*'} mandatory_field_label{/if}" align=right>
				<font color="red">{$mandatory_field}</font>{$usefldlabel} {if $MASS_EDIT eq '1'}<input type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" class="small" >{/if}
			</td>
			<td width="30%" align=left class="dvtCellInfo">
				{if $uitype eq 52}
					<select name="{$fldname}" id="{$fldname}" tabindex="{$vt_tab}" class="small">
				{elseif $uitype eq 77}
					<select name="{$fldname}" id="{$fldname}" tabindex="{$vt_tab}" class="small">
				{else}
					<select name="{$fldname}" id="{$fldname}" tabindex="{$vt_tab}" class="small">
				{/if}

				{foreach key=key_one item=arr from=$fldvalue}
					{foreach key=sel_value item=value from=$arr}
						<option value="{$key_one}" {$value}>{$sel_value}</option>
					{/foreach}
				{/foreach}
				</select>
			</td>
		{elseif $uitype eq 51}
            <!-- Field: UI type 51 -->
            {* Some field logic *}
			{if $MODULE eq 'Accounts'}
				{assign var='popuptype' value = 'specific_account_address'}
			{else}
				{assign var='popuptype' value = 'specific_contact_account_address'}
			{/if}            
            <div class="slds-col slds-size_1-of-2 slds-grid">
                <div class="slds-form-element slds-p-horizontal_small">
                    <label class="slds-form-element__label">
                    	{if $mandatory_field == '*'}<abbr class="slds-required" title="required">* </abbr>{/if}{$usefldlabel}
                	</label>
                    <div class="slds-form-element__control">
                    	{if $MASS_EDIT eq '1'}
                    	{* We're mass editing, so include the checkbox *}
                        <div class="slds-grid">
                            <div class="slds-col slds-size_1-of-12 slds-m-right_small">
                                <div class="slds-checkbox_add-button">
                                    <input class="slds-assistive-text" type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" />
                                    <label for="{$fldname}_mass_edit_check" class="slds-checkbox_faux">
                                        <span class="slds-assistive-text">{$usefldlabel}</span>
                                    </label>
                                </div>
                            </div>
                            <div class="slds-col slds-grid slds-size_11-of-12">
                    	{else}
                    		<div class="slds-grid">
                    	{/if}
                                <div class="slds-col slds-size_10-of-12 slds-p-left--none slds-p-right_xxx-small">
                                    <input name="account_name" readonly="readonly" class="slds-input" value="{$fldvalue}" style="background-color: #ffffff; border: 1px solid rgb(221, 219, 218);" />
                                    <input name="{$fldname}" type="hidden" value="{$secondvalue}">
                                </div>
                                <div class="slds-col slds-size_2-of-12 slds-p-horizontal_none">
                                    <div class="slds-button-group">
                                        <button type="button" class="slds-button slds-button_icon slds-button_icon-border" title="{$APP.LBL_SELECT}" onclick='return window.open("index.php?module=Accounts&action=Popup&popuptype={$popuptype}&form=TasksEditView&form_submit=false&fromlink={$fromlink}&recordid={if isset($ID)}{$ID}{/if}","test{if $fromlink eq 'qcreate'}qc{/if}","width=640,height=602,resizable=0,scrollbars=0");'>
                                            <svg class="slds-button__icon" aria-hidden="true">
                                                <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#add"></use>
                                            </svg>
                                            <span class="slds-assistive-text">{$APP.LBL_SELECT}</span>
                                        </button>
                                        <button type="button" class="slds-button slds-button_icon slds-button_icon-border" title="{$APP.LBL_CLEAR}" onClick="this.form.account_id.value=''; this.form.account_name.value='';return false;">
                                            <svg class="slds-button__icon" aria-hidden="true">
                                                <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#delete"></use>
                                            </svg>
                                            <span class="slds-assistive-text">{$APP.LBL_CLEAR}</span> {* TO-DO: Translate *}
                                        </button>
                                    </div>
                                </div>
                            </div>
	                    {if $MASS_EDIT eq '1'}
	                    {* Close one extra div when mass-editing *}
	                    </div>
	                    {/if}
                    </div>
                </div>
            </div>
            <!-- // Field: UI type 51 -->

		{elseif $uitype eq 73}
            <!-- Field: UI type 73 -->
            <div class="slds-col slds-size_1-of-2 slds-grid">
                <div class="slds-form-element slds-p-horizontal_small">
                    <label class="slds-form-element__label">
                    	{if $mandatory_field == '*'}<abbr class="slds-required" title="required">* </abbr>{/if}{$usefldlabel}
                	</label>
                    <div class="slds-form-element__control">
                    	{if $MASS_EDIT eq '1'}
                    	{* We're mass editing, so include the checkbox *}
                        <div class="slds-grid">
                            <div class="slds-col slds-size_1-of-12 slds-m-right_small">
                                <div class="slds-checkbox_add-button">
                                    <input class="slds-assistive-text" type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" />
                                    <label for="{$fldname}_mass_edit_check" class="slds-checkbox_faux">
                                        <span class="slds-assistive-text">{$usefldlabel}</span>
                                    </label>
                                </div>
                            </div>
                            <div class="slds-col slds-grid slds-size_11-of-12">
                    	{else}
                    		<div class="slds-grid">
                    	{/if}
                                <div class="slds-col slds-size_10-of-12 slds-p-left--none slds-p-right_xxx-small">
                                    <input name="account_name" id="single_accountid" readonly="readonly" class="slds-input" value="{$fldvalue}" style="background-color: #ffffff; border: 1px solid rgb(221, 219, 218);" />
                                    <input name="{$fldname}" type="hidden" value="{$secondvalue}">
                                </div>
                                <div class="slds-col slds-size_2-of-12 slds-p-horizontal_none">
                                    <div class="slds-button-group">
                                        <button type="button" class="slds-button slds-button_icon slds-button_icon-border" title="{$APP.LBL_SELECT}" onclick='return window.open("index.php?module=Accounts&action=Popup&popuptype=specific_account_address&form=TasksEditView&form_submit=false&fromlink={$fromlink}","test","width=640,height=602,resizable=0,scrollbars=0");'>
                                            <svg class="slds-button__icon" aria-hidden="true">
                                                <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#add"></use>
                                            </svg>
                                            <span class="slds-assistive-text">{$APP.LBL_SELECT}</span>
                                        </button>
                                        <button type="button" class="slds-button slds-button_icon slds-button_icon-border" title="{$APP.LBL_CLEAR}" onClick="this.form.account_id.value=''; this.form.account_name.value='';return false;">
                                            <svg class="slds-button__icon" aria-hidden="true">
                                                <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#delete"></use>
                                            </svg>
                                            <span class="slds-assistive-text">{$APP.LBL_CLEAR}</span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        {if $MASS_EDIT eq '1'}
                        {* Close an extra div when doing mass-edit *}
                        </div>
                        {/if}
                    </div>
                </div>
            </div>
            <!-- // Field: UI type 73 -->

		{elseif $uitype eq 57}
            <!-- Field: UI type 57 -->
            {* Some special vars *}
            {if $fromlink == 'qcreate'}{$formname = 'QcEditView'}{else}{$formname = 'EditView'}{/if}

            <div class="slds-col slds-size_1-of-2 slds-grid">
                <div class="slds-form-element slds-p-horizontal_small">
                    <label class="slds-form-element__label">
                    	{if $mandatory_field == '*'}<abbr class="slds-required" title="required">* </abbr>{/if}{$usefldlabel}
                	</label>
                    <div class="slds-form-element__control">
                    	{if $MASS_EDIT eq '1'}
                    	{* We're mass editing, so include the checkbox *}
                        <div class="slds-grid">
                            <div class="slds-col slds-size_1-of-12 slds-m-right_small">
                                <div class="slds-checkbox_add-button">
                                    <input class="slds-assistive-text" type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" />
                                    <label for="{$fldname}_mass_edit_check" class="slds-checkbox_faux">
                                        <span class="slds-assistive-text">{$usefldlabel}</span>
                                    </label>
                                </div>
                            </div>
                            <div class="slds-col slds-grid slds-size_11-of-12">
                                <div class="slds-col slds-size_10-of-12 slds-p-left--none slds-p-right_xxx-small">
                                    <input name="contact_name" readonly="readonly" class="slds-input" value="{$fldvalue}" style="background-color: #ffffff; border: 1px solid rgb(221, 219, 218);" />
                                    <input name="{$fldname}" type="hidden" value="{$secondvalue}">
                                </div>
                                <div class="slds-col slds-size_2-of-12 slds-p-horizontal_none">
                                    <div class="slds-button-group">
                                        <button type="button" class="slds-button slds-button_icon slds-button_icon-border" title="{$APP.LBL_SELECT}" onclick='selectContact("false","general",document.{$formname})'>
                                            <svg class="slds-button__icon" aria-hidden="true">
                                                <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#add"></use>
                                            </svg>
                                            <span class="slds-assistive-text">{$APP.LBL_SELECT}</span>
                                        </button>
                                        <button type="button" class="slds-button slds-button_icon slds-button_icon-border" title="{$APP.LBL_CLEAR}" onClick="this.form.contact_id.value=''; this.form.contact_name.value='';return false;">
                                            <svg class="slds-button__icon" aria-hidden="true">
                                                <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#delete"></use>
                                            </svg>
                                            <span class="slds-assistive-text">{$APP.LBL_CLEAR}</span> {* TO-DO: Translate *}
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        {else}
                        {* No mass-edit, normal mode *}
                        <div class="slds-grid">
                            <div class="slds-col slds-size_10-of-12 slds-p-left--none slds-p-right_xxx-small">
                                <input name="contact_name" readonly="readonly" class="slds-input" value="{$fldvalue}" style="background-color: #ffffff; border: 1px solid rgb(221, 219, 218);" />
                                <input name="{$fldname}" type="hidden" value="{$secondvalue}">
                            </div>
                            <div class="slds-col slds-size_2-of-12 slds-p-horizontal_none">
                                <div class="slds-button-group">
                                    <button type="button" class="slds-button slds-button_icon slds-button_icon-border" title="{$APP.LBL_SELECT}" onclick='selectContact("false","general",document.{$formname})'>
                                        <svg class="slds-button__icon" aria-hidden="true">
                                            <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#add"></use>
                                        </svg>
                                        <span class="slds-assistive-text">{$APP.LBL_SELECT}</span>
                                    </button>
                                    <button type="button" class="slds-button slds-button_icon slds-button_icon-border" title="{$APP.LBL_CLEAR}" onClick="this.form.contact_id.value=''; this.form.contact_name.value='';return false;">
                                        <svg class="slds-button__icon" aria-hidden="true">
                                            <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#delete"></use>
                                        </svg>
                                        <span class="slds-assistive-text">{$APP.LBL_CLEAR}</span> {* TO-DO: Translate *}
                                    </button>
                                </div>
                            </div>
                        </div>                        
                        {/if}
                    </div>
                </div>
            </div>
            <!-- // Field: UI type 57 -->	

		{elseif $uitype eq 80}
			<td width="20%" class="dvtCellLabel{if $mandatory_field == '*'} mandatory_field_label{/if}" align=right>
				<font color="red">{$mandatory_field}</font>{$usefldlabel} {if $MASS_EDIT eq '1'}<input type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" class="small" >{/if}
			</td>
			<td width="30%" align=left class="dvtCellInfo">
				<input name="salesorder_name" readonly type="text" style="border:1px solid #bababa;" value="{$fldvalue}"><input name="{$fldname}" type="hidden" value="{$secondvalue}">&nbsp;<img src="{'select.gif'|@vtiger_imageurl:$THEME}" alt="{$APP.LBL_SELECT}" title="{$APP.LBL_SELECT}" onclick='selectSalesOrder();' align="absmiddle" style='cursor:hand;cursor:pointer'>&nbsp;<input type="image" tabindex="{$vt_tab}" src="{'clear_field.gif'|@vtiger_imageurl:$THEME}" alt="{$APP.LBL_CLEAR}" title="{$APP.LBL_CLEAR}" onClick="this.form.salesorder_id.value=''; this.form.salesorder_name.value='';return false;" align="absmiddle" style='cursor:hand;cursor:pointer'>
			</td>

		{elseif $uitype eq 78}
			<td width="20%" class="dvtCellLabel{if $mandatory_field == '*'} mandatory_field_label{/if}" align=right>
				<font color="red">{$mandatory_field}</font>{$usefldlabel} {if $MASS_EDIT eq '1'}<input type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" class="small">{/if}
			</td>
			<td width="30%" align=left class="dvtCellInfo">
				<input name="quote_name" readonly type="text" style="border:1px solid #bababa;" value="{$fldvalue}"><input name="{$fldname}" type="hidden" value="{$secondvalue}" >&nbsp;<img src="{'select.gif'|@vtiger_imageurl:$THEME}" alt="{$APP.LBL_SELECT}" title="{$APP.LBL_SELECT}" onclick='selectQuote()' align="absmiddle" style='cursor:hand;cursor:pointer' >&nbsp;<input type="image" tabindex="{$vt_tab}" src="{'clear_field.gif'|@vtiger_imageurl:$THEME}" alt="{$APP.LBL_CLEAR}" title="{$APP.LBL_CLEAR}" onClick="this.form.quote_id.value=''; this.form.quote_name.value='';return false;" align="absmiddle" style='cursor:hand;cursor:pointer'>
			</td>

		{elseif $uitype eq 76}
            <!-- Field: UI type 76 -->
            <div class="slds-col slds-size_1-of-2 slds-grid">
                <div class="slds-form-element slds-p-horizontal_small">
                    <label class="slds-form-element__label">
                    	{if $mandatory_field == '*'}<abbr class="slds-required" title="required">* </abbr>{/if}{$usefldlabel}
                	</label>
                    <div class="slds-form-element__control">
                    	{if $MASS_EDIT eq '1'}
                    	{* We're mass editing, so include the checkbox *}
                        <div class="slds-grid">
                            <div class="slds-col slds-size_1-of-12 slds-m-right_small">
                                <div class="slds-checkbox_add-button">
                                    <input class="slds-assistive-text" type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" />
                                    <label for="{$fldname}_mass_edit_check" class="slds-checkbox_faux">
                                        <span class="slds-assistive-text">{$usefldlabel}</span>
                                    </label>
                                </div>
                            </div>
                            <div class="slds-col slds-grid slds-size_11-of-12">
                                <div class="slds-col slds-size_10-of-12 slds-p-left--none slds-p-right_xxx-small">
                                    <input name="potential_name" readonly="readonly" class="slds-input" value="{$fldvalue}" style="background-color: #ffffff; border: 1px solid rgb(221, 219, 218);" />
                                    <input name="{$fldname}" type="hidden" value="{$secondvalue}">
                                </div>
                                <div class="slds-col slds-size_2-of-12 slds-p-horizontal_none">
                                    <div class="slds-button-group">
                                        <button type="button" class="slds-button slds-button_icon slds-button_icon-border" title="{$APP.LBL_SELECT}" onclick="selectPotential()">
                                            <svg class="slds-button__icon" aria-hidden="true">
                                                <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#add"></use>
                                            </svg>
                                            <span class="slds-assistive-text">{$APP.LBL_SELECT}</span>
                                        </button>
                                        <button type="button" class="slds-button slds-button_icon slds-button_icon-border" title="{$APP.LBL_CLEAR}" onClick="this.form.potential_id.value=''; this.form.potential_name.value='';return false;">
                                            <svg class="slds-button__icon" aria-hidden="true">
                                                <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#delete"></use>
                                            </svg>
                                            <span class="slds-assistive-text">{$APP.LBL_CLEAR}</span> {* TO-DO: Translate *}
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        {else}
                        {* No mass-edit, normal mode *}
                        <div class="slds-grid">
                            <div class="slds-col slds-size_10-of-12 slds-p-left--none slds-p-right_xxx-small">
                                <input name="potential_name" readonly="readonly" class="slds-input" value="{$fldvalue}" style="background-color: #ffffff; border: 1px solid rgb(221, 219, 218);" />
                                <input name="{$fldname}" type="hidden" value="{$secondvalue}">
                            </div>
                            <div class="slds-col slds-size_2-of-12 slds-p-horizontal_none">
                                <div class="slds-button-group">
                                    <button type="button" class="slds-button slds-button_icon slds-button_icon-border" title="{$APP.LBL_SELECT}" onclick="selectPotential()">
                                        <svg class="slds-button__icon" aria-hidden="true">
                                            <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#add"></use>
                                        </svg>
                                        <span class="slds-assistive-text">{$APP.LBL_SELECT}</span>
                                    </button>
                                    <button type="button" class="slds-button slds-button_icon slds-button_icon-border" title="{$APP.LBL_CLEAR}" onClick="this.form.potential_id.value=''; this.form.potential_name.value='';return false;">
                                        <svg class="slds-button__icon" aria-hidden="true">
                                            <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#delete"></use>
                                        </svg>
                                        <span class="slds-assistive-text">{$APP.LBL_CLEAR}</span> {* TO-DO: Translate *}
                                    </button>
                                </div>
                            </div>
                        </div>                        
                        {/if}
                    </div>
                </div>
            </div>
            <!-- // Field: UI type 76 -->

		{elseif $uitype eq 71 || $uitype eq 72}
            <!-- Field: UI type 71 / 72 -->
            <div class="slds-col slds-size_1-of-2 slds-grid">
                <div class="slds-form-element slds-p-horizontal_small">
                    <label class="slds-form-element__label">
                    	{if $mandatory_field == '*'}<abbr class="slds-required" title="required">* </abbr>{/if}{$usefldlabel}
                	</label>
                    <div class="slds-form-element__control">
                        <div class="slds-grid">                    	
	                	{if $MASS_EDIT eq '1'}
	            		{* Mass edit mode, so include the checkbox *}
                            <div class="slds-col slds-size_1-of-12 slds-m-right_small">
                                <div class="slds-checkbox_add-button">
                                    <input class="slds-assistive-text" type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" />
                                    <label for="{$fldname}_mass_edit_check" class="slds-checkbox_faux">
                                        <span class="slds-assistive-text">{$usefldlabel}</span>
                                    </label>
                                </div>
                            </div>
                            <div class="slds-col slds-size_11-of-12">
                        {else}
                        	<div class="slds-col slds-grid slds-size_12-of-12">
                        {/if}
                        	{if $fldname eq "unit_price" && $MASS_EDIT != 1}
                        		<div class="slds-col slds-size_10-of-12">
                                	<input type="text" tabindex="{$vt_tab}" name="{$fldname}" id="{$fldname}" value="{$fldvalue}" class="slds-input" onBlur="updateUnitPrice('unit_price', '{$BASE_CURRENCY}');"/>
                                </div>
                                <div class="slds-col slds-size_2-of-12">
                                	<button type="button" class="slds-button slds-button_neutral" onclick="updateUnitPrice('unit_price', '{$BASE_CURRENCY}'); toggleShowHide('currency_class','multiple_currencies');">{$APP.LBL_MORE_CURRENCIES}</button>
                                </div>
								<div id="currency_class" class="multiCurrencyEditUI">
									<input type="hidden" name="base_currency" id="base_currency" value="{$BASE_CURRENCY}" />
									<input type="hidden" name="base_conversion_rate" id="base_currency" value="{$BASE_CURRENCY}" />
									<table width="100%" height="100%" class="small" cellpadding="5">
									<tr class="detailedViewHeader">
										<th colspan="4">
											<b>{'LBL_PRODUCT_PRICES'|@getTranslatedString:'Products'}</b>
										</th>
										<th align="right">
											<img border="0" style="cursor: pointer;" onclick="toggleShowHide('multiple_currencies','currency_class');" src="{'close.gif'|@vtiger_imageurl:$THEME}"/>
										</th>
									</tr>
									<tr class="detailedViewHeader">
										<th>{$APP.LBL_CURRENCY}</th>
										<th>{$APP.LBL_PRICE}</th>
										<th>{$APP.LBL_CONVERSION_RATE}</th>
										<th>{$APP.LBL_RESET_PRICE}</th>
										<th>{$APP.LBL_BASE_CURRENCY}</th>
									</tr>
									{foreach item=price key=count from=$PRICE_DETAILS}
										<tr>
											{if $price.check_value eq 1 || $price.is_basecurrency eq 1}
												{assign var=check_value value="checked"}
												{assign var=disable_value value=""}
											{else}
												{assign var=check_value value=""}
												{assign var=disable_value value="disabled=true"}
											{/if}

											{if $price.is_basecurrency eq 1}
												{assign var=base_cur_check value="checked"}
											{else}
												{assign var=base_cur_check value=""}
											{/if}

											{if $price.curname eq $BASE_CURRENCY}
												{assign var=call_js_update_func value="updateUnitPrice('$BASE_CURRENCY', 'unit_price');"}
											{else}
												{assign var=call_js_update_func value=""}
											{/if}

											<td align="right" class="dvtCellLabel">
												{$price.currencylabel|@getTranslatedCurrencyString} ({$price.currencysymbol})
												<input type="checkbox" name="cur_{$price.curid}_check" id="cur_{$price.curid}_check" class="small" onclick="fnenableDisable(this,'{$price.curid}'); updateCurrencyValue(this,'{$price.curname}','{$BASE_CURRENCY}','{$price.conversionrate}');" {$check_value}>
											</td>
											<td class="dvtCellInfo" align="left">
												<input {$disable_value} type="text" size="10" class="small" name="{$price.curname}" id="{$price.curname}" value="{$price.curvalue}" onBlur="{$call_js_update_func} fnpriceValidation('{$price.curname}');">
											</td>
											<td class="dvtCellInfo" align="left">
												<input disabled=true type="text" size="10" class="small" name="cur_conv_rate{$price.curid}" value="{$price.conversionrate}">
											</td>
											<td class="dvtCellInfo" align="center">
												<input {$disable_value} type="button" class="crmbutton small edit" id="cur_reset{$price.curid}"  onclick="updateCurrencyValue(this,'{$price.curname}','{$BASE_CURRENCY}','{$price.conversionrate}');" value="{$APP.LBL_RESET}"/>
											</td>
											<td class="dvtCellInfo">
												<input {$disable_value} type="radio" class="detailedViewTextBox" id="base_currency{$price.curid}" name="base_currency_input" value="{$price.curname}" {$base_cur_check} onchange="updateBaseCurrencyValue()" />
											</td>
										</tr>
									{/foreach}
									</table>
								</div>                                
                            </div>
                            {else}
                        		<div class="slds-col slds-size_12-of-12 slds-p-horizontal_none">
                                	<input type="text" tabindex="{$vt_tab}" name="{$fldname}" id="{$fldname}" value="{$fldvalue}" class="slds-input" />
                                </div>
                            </div>                            
                            {/if}
                        </div>
                    </div>
                </div>
            </div>
            <!-- // Field: UI type 71 / 72 -->		

		{elseif $uitype eq 56}
			<!-- Field: UI type 56 -->
	        <div class="slds-col slds-size_1-of-2 slds-grid">
	            <div class="slds-form-element slds-p-horizontal_small">
                    <label class="slds-form-element__label">
                    	{if $mandatory_field == '*'}<abbr class="slds-required" title="required">* </abbr>{/if}{$usefldlabel}
                	</label>
	                <div class="slds-form-element__control">
		                {if $MASS_EDIT == '1'}
		                {* Mass-editing, include the checkbox *}	                	
	                    <div class="slds-grid">
	                        <div class="slds-col slds-size_1-of-12 slds-m-right_small">
	                            <div class="slds-checkbox_add-button">
	                                <input class="slds-assistive-text" type="checkbox" id="add-checkbox-2" value="add-checkbox-2" />
	                                <label for="add-checkbox-2" class="slds-checkbox_faux">
	                                    <span class="slds-assistive-text">Edit website</span>
	                                </label>
	                            </div>
	                        </div>
	                        <div class="slds-col slds-size_11-of-12">
	                    {/if}
	                            <label class="slds-checkbox_toggle">
								<!-- For Portal Information we need a hidden field existing_portal with the current portal value -->
								{if $fldname eq 'portal'}
									<td width="30%" align=left class="dvtCellInfo">
										<input type="hidden" name="existing_portal" value="{$fldvalue}">
										<input aria-describedby="{$fldname}" name="{$fldname}" id="{$fldname}" type="checkbox" tabindex="{$vt_tab}" {if $fldvalue eq 1}checked{/if}>
									</td>
								{else}
									{if $fldvalue eq 1}
										<td width="30%" align=left class="dvtCellInfo">
											<input aria-describedby="{$fldname}" name="{$fldname}" id="{$fldname}" type="checkbox" tabindex="{$vt_tab}" checked>
										</td>
									{elseif $fldname eq 'filestatus'&& $MODE eq 'create'}
										<td width="30%" align=left class="dvtCellInfo">
											<input aria-describedby="{$fldname}" name="{$fldname}" id="{$fldname}" type="checkbox" tabindex="{$vt_tab}" checked>
										</td>
									{else}
										<td width="30%" align=left class="dvtCellInfo">
											<input aria-describedby="{$fldname}" name="{$fldname}" id="{$fldname}" tabindex="{$vt_tab}" type="checkbox">
										</td>
									{/if}
								{/if}	                            	
	                                <span id="{$fldname}" class="slds-checkbox_faux_container" aria-live="assertive">
	                                    <span class="slds-checkbox_faux"></span>
	                                    <span class="slds-checkbox_on">Yes</span> {* TO-DO: translate *}
	                                    <span class="slds-checkbox_off">No</span> {* TO-DO: translate *}
	                                </span>
	                            </label>
		                {if $MASS_EDIT == '1'}
		                {* Mass-editing, close the two extra divs *}	                            
	                        </div>
	                    </div>
	                    {/if}
	                </div>
	            </div>
	        </div>			
			<!-- // Field: UI type 56 -->
		{elseif $uitype eq 23 || $uitype eq 5 || $uitype eq 6}
            <!-- Field: UI type 5 / 6 / 23 -->
            {* Setup some field logic *}
			{foreach key=date_value item=time_value from=$fldvalue}
				{assign var=date_val value="$date_value"}
				{assign var=time_val value="$time_value"}
			{/foreach}
			{foreach key=date_format item=date_str from=$secondvalue}
				{assign var=dateFormat value="$date_format"}
				{assign var=dateStr value="$date_str"}
			{/foreach}	
            <div class="slds-col slds-size_1-of-2 slds-grid">
                <div class="slds-form-element slds-p-horizontal_small">
                    <label class="slds-form-element__label">
                    	{if $mandatory_field == '*'}<abbr class="slds-required" title="required">* </abbr>{/if}{$usefldlabel}&nbsp;<em>({$dateStr})</em>
                	</label>
                    <div class="slds-form-element__control">
                    	{if $MASS_EDIT eq '1'}
                    	{* We're mass editing, so include the checkbox *}
                        <div class="slds-grid">
                            <div class="slds-col slds-size_1-of-12 slds-m-right_small">
                                <div class="slds-checkbox_add-button">
                                    <input class="slds-assistive-text" type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" />
                                    <label for="{$fldname}_mass_edit_check" class="slds-checkbox_faux">
                                        <span class="slds-assistive-text">{$usefldlabel}</span>
                                    </label>
                                </div>
                            </div>
                            <div class="slds-col slds-grid slds-size_11-of-12">
                                <div class="slds-col slds-size_10-of-12 slds-p-left--none slds-p-right_xxx-small">
									<input name="{$fldname}" tabindex="{$vt_tab}" id="jscal_field_{$fldname}" class="slds-input" value="{$date_val}" />
                                </div>
                                <div class="slds-col slds-size_2-of-12 slds-p-horizontal_none">
                                    <button type="button" class="slds-button slds-button_icon slds-button_icon-border" title="{$APP.LBL_SELECT}" id="jscal_trigger_{$fldname}">
                                        <svg class="slds-button__icon" aria-hidden="true">
                                            <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#event"></use>
                                        </svg>
                                        <span class="slds-assistive-text">{$APP.LBL_SELECT}</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                        {else}
                        {* No mass-edit, normal mode *}
                        <div class="slds-grid">
                            <div class="slds-col slds-size_10-of-12 slds-p-left--none slds-p-right_xxx-small">
                                <input name="{$fldname}" tabindex="{$vt_tab}" id="jscal_field_{$fldname}" class="slds-input" value="{$date_val}" />
                            </div>
                            <div class="slds-col slds-size_2-of-12 slds-p-horizontal_none">
                                <button type="button" class="slds-button slds-button_icon slds-button_icon-border" title="{$APP.LBL_SELECT}" id="jscal_trigger_{$fldname}">
                                    <svg class="slds-button__icon" aria-hidden="true">
                                        <use xlink:href="include/LD/assets/icons/utility-sprite/svg/symbols.svg#event"></use>
                                    </svg>
                                    <span class="slds-assistive-text">{$APP.LBL_SELECT}</span>
                                </button>
                            </div>
                        </div>                        
                        {/if}
                    </div>
                </div>

				<script type="text/javascript" id='massedit_calendar_{$fldname}'>
					Calendar.setup ({ldelim}
						inputField : "jscal_field_{$fldname}", ifFormat : "{$dateFormat}", showsTime : false, button : "jscal_trigger_{$fldname}", singleClick : true, step : 1
					{rdelim})
				</script>                
            </div>
            <!-- // Field: UI type 5 / 6 / 23 -->		

		{elseif $uitype eq 50}
			<td width="20%" class="dvtCellLabel{if $mandatory_field == '*'} mandatory_field_label{/if}" align=right>
				<font color="red">{$mandatory_field}</font>{$usefldlabel} {if $MASS_EDIT eq '1'}<input type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" class="small" >{/if}
			</td>
			<td width="30%" align=left class="dvtCellInfo">
				{foreach key=date_value item=date12_value from=$fldvalue}
					{assign var=date_val value="$date_value"}
					{assign var=date12_val value="$date12_value"}
				{/foreach}
				{foreach key=user_format item=date_format from=$thirdvalue}
					{assign var=userFormat value="$user_format"}
					{assign var=fieldFormat value="$date_format"}
				{/foreach}
				<input name="{$fldname}" tabindex="{$vt_tab}" id="jscal_field_{$fldname}" type="text" style="border:1px solid #bababa;" size="16" maxlength="16" value="{$date12_val}">
				<input name="timefmt_{$fldname}" id="inputtimefmt_{$fldname}" type="hidden" value="{$fieldFormat}">
				<img src="{'btnL3Calendar.gif'|@vtiger_imageurl:$THEME}" id="jscal_trigger_{$fldname}" style="vertical-align:middle">

				{foreach key=date_format item=date_str from=$secondvalue}
					{assign var=dateFormat value="$date_format"}
					{assign var=dateStr value="$date_str"}
				{/foreach}

				<br><font size=1><em old="(yyyy-mm-dd)">({$dateStr})&nbsp;<span id="timefmt_{$fldname}">{if $userFormat neq "24"}{$fieldFormat}{/if}</span></em></font>

				<script type="text/javascript" id='massedit_calendar_{$fldname}'>
					Calendar.setup ({ldelim}
						inputField : "jscal_field_{$fldname}", ifFormat : "{$dateFormat}", inputTimeFormat : "{$fieldFormat}",
						{if $userFormat neq "24"}displayArea : "timefmt_{$fldname}", daFormat : "%p",{/if}
						showsTime : true, timeFormat : "{$userFormat}",
						button : "jscal_trigger_{$fldname}", singleClick : true, step : 1
					{rdelim});
				</script>
			</td>

		{elseif $uitype eq 63}
			<td width="20%" class="dvtCellLabel{if $mandatory_field == '*'} mandatory_field_label{/if}" align=right>
				<font color="red">{$mandatory_field}</font>{$usefldlabel} {if $MASS_EDIT eq '1'}<input type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" class="small" >{/if}
			</td>
			<td width="30%" align=left class="dvtCellInfo">
				<input name="{$fldname}" type="text" size="2" value="{$fldvalue}" tabindex="{$vt_tab}" >&nbsp;
				<select name="duration_minutes" tabindex="{$vt_tab}" class="small">
					{foreach key=labelval item=selectval from=$secondvalue}
						<option value="{$labelval}" {$selectval}>{$labelval}</option>
					{/foreach}
				</select>

		{elseif $uitype eq 66 || $uitype eq 62}
			<td width="20%" class="dvtCellLabel{if $mandatory_field == '*'} mandatory_field_label{/if}" align=right>
				<font color="red">{$mandatory_field}</font>
				{if $fromlink eq 'qcreate'}
					<select class="small" name="parent_type" onChange='document.QcEditView.parent_name.value=""; document.QcEditView.parent_id.value=""'>
				{else}
					<select class="small" name="parent_type" onChange='document.EditView.parent_name.value=""; document.EditView.parent_id.value=""'>
				{/if}
					{section name=combo loop=$fldlabel}
						<option value="{$fldlabel_combo[combo]}" {$fldlabel_sel[combo]}>{$fldlabel[combo]} </option>
					{/section}
				</select>
				{if $MASS_EDIT eq '1'}<input type="checkbox" name="parent_id_mass_edit_check" id="{$fldname}_mass_edit_check" class="small" >{/if}
			</td>
			<td width="30%" align=left class="dvtCellInfo">
				<input name="{$fldname}" type="hidden" value="{$secondvalue}">
				<input name="parent_name" readonly id = "parentid" type="text" style="border:1px solid #bababa;" value="{$fldvalue}">
				&nbsp;
				{if $fromlink eq 'qcreate'}
					<img src="{'select.gif'|@vtiger_imageurl:$THEME}" tabindex="{$vt_tab}" alt="{$APP.LBL_SELECT}" title="{$APP.LBL_SELECT}" onclick='return window.open("index.php?module="+ document.QcEditView.parent_type.value +"&action=Popup&html=Popup_picker&form=HelpDeskEditView&fromlink={$fromlink}","test","width=640,height=602,resizable=0,scrollbars=0,top=150,left=200");' align="absmiddle" style='cursor:hand;cursor:pointer'>&nbsp;<input type="image" src="{'clear_field.gif'|@vtiger_imageurl:$THEME}" alt="{$APP.LBL_CLEAR}" title="{$APP.LBL_CLEAR}" onClick="this.form.parent_id.value=''; this.form.parent_name.value=''; return false;" align="absmiddle" style='cursor:hand;cursor:pointer'>
				{else}
					<img src="{'select.gif'|@vtiger_imageurl:$THEME}" tabindex="{$vt_tab}" alt="{$APP.LBL_SELECT}" title="{$APP.LBL_SELECT}" onclick='return window.open("index.php?module="+ document.EditView.parent_type.value +"&action=Popup&html=Popup_picker&form=HelpDeskEditView&fromlink={$fromlink}","test","width=640,height=602,resizable=0,scrollbars=0,top=150,left=200");' align="absmiddle" style='cursor:hand;cursor:pointer'>&nbsp;<input type="image" src="{'clear_field.gif'|@vtiger_imageurl:$THEME}" alt="{$APP.LBL_CLEAR}" title="{$APP.LBL_CLEAR}" onClick="this.form.parent_id.value=''; this.form.parent_name.value=''; return false;" align="absmiddle" style='cursor:hand;cursor:pointer'>
				{/if}
			</td>

		{elseif $uitype eq 357}
			<td width="20%" class="dvtCellLabel" align=right>To:&nbsp;</td>
			<td width="90%" colspan="3">
				<input name="{$fldname}" type="hidden" value="{$secondvalue}">
				<textarea readonly name="parent_name" cols="70" rows="2">{$fldvalue}</textarea>&nbsp;
				<select name="parent_type" class="small">
					{foreach key=labelval item=selectval from=$fldlabel}
						<option value="{$labelval}" {$selectval}>{$labelval}</option>
					{/foreach}
				</select>
				&nbsp;
				{if $fromlink eq 'qcreate'}
					<img tabindex="{$vt_tab}" src="{'select.gif'|@vtiger_imageurl:$THEME}" alt="{$APP.LBL_SELECT}" title="{$APP.LBL_SELECT}" onclick='return window.open("index.php?module="+ document.QcEditView.parent_type.value +"&action=Popup&html=Popup_picker&form=HelpDeskEditView&fromlink={$fromlink}","test","width=640,height=602,resizable=0,scrollbars=0,top=150,left=200");' align="absmiddle" style='cursor:hand;cursor:pointer'>&nbsp;<input type="image" src="{'clear_field.gif'|@vtiger_imageurl:$THEME}" alt="{$APP.LBL_CLEAR}" title="{$APP.LBL_CLEAR}" onClick="this.form.parent_id.value=''; this.form.parent_name.value=''; return false;" align="absmiddle" style='cursor:hand;cursor:pointer'>
				{else}
					<img tabindex="{$vt_tab}" src="{'select.gif'|@vtiger_imageurl:$THEME}" alt="{$APP.LBL_SELECT}" title="{$APP.LBL_SELECT}" onclick='return window.open("index.php?module="+ document.EditView.parent_type.value +"&action=Popup&html=Popup_picker&form=HelpDeskEditView&fromlink={$fromlink}","test","width=640,height=602,resizable=0,scrollbars=0,top=150,left=200");' align="absmiddle" style='cursor:hand;cursor:pointer'>&nbsp;<input type="image" src="{'clear_field.gif'|@vtiger_imageurl:$THEME}" alt="{$APP.LBL_CLEAR}" title="{$APP.LBL_CLEAR}" onClick="this.form.parent_id.value=''; this.form.parent_name.value=''; return false;" align="absmiddle" style='cursor:hand;cursor:pointer'>
				{/if}
			</td>
		   <tr style="height:25px">
			<td width="20%" class="dvtCellLabel" align=right>CC:&nbsp;</td>
			<td width="30%" align=left class="dvtCellInfo">
				<input name="ccmail" type="text" class=detailedViewTextBox onFocus="this.className='detailedViewTextBoxOn'" onBlur="this.className='detailedViewTextBox'"  value="">
			</td>
			<td width="20%" class="dvtCellLabel" align=right>BCC:&nbsp;</td>
			<td width="30%" align=left class="dvtCellInfo">
				<input name="bccmail" type="text" class=detailedViewTextBox onFocus="this.className='detailedViewTextBoxOn'" onBlur="this.className='detailedViewTextBox'"  value="">
			</td>
		   </tr>

		{elseif $uitype eq 55 || $uitype eq 255}
            <!-- Field: UI type 55 / 255 -->
            <div class="slds-col slds-size_1-of-2 slds-grid">
                <div class="slds-form-element slds-p-horizontal_small">
                    <label class="slds-form-element__label">
                    	{if $fldvalue != ''}{$APP.Salutation}<br>{/if}
                    	{if $mandatory_field == '*' || $uitype == 255}<abbr class="slds-required" title="required">* </abbr>{/if}{$usefldlabel}                	
                	</label>
                    <div class="slds-form-element__control">
                    	{if $MASS_EDIT eq '1'}
                    	{* We're mass editing, so include the checkbox *}
                        <div class="slds-grid">
                            <div class="slds-col slds-size_1-of-12 slds-m-right_small">
                                <div class="slds-checkbox_add-button">
                                    <input class="slds-assistive-text" type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" />
                                    <label for="{$fldname}_mass_edit_check" class="slds-checkbox_faux">
                                        <span class="slds-assistive-text">{$usefldlabel}</span>
                                    </label>
                                </div>
                            </div>
                            <div class="slds-col slds-grid slds-size_11-of-12">
                    	{else}
                    		<div class="slds-grid">
                    	{/if}
								<div class="slds-col slds-grid slds-p-horizontal_none">
									{if $fldvalue neq ''}
									<div class="slds-col slds-size_2-of-12 slds-p-horizontal_none">
		                                <div class="slds-checkbox_add-button">
		                                    <input class="slds-assistive-text" type="checkbox" name="salutationtype_mass_edit_check" id="salutationtype_mass_edit_check" />
		                                    <label for="salutation_mass_edit_check" class="slds-checkbox_faux">
		                                        <span class="slds-assistive-text">{$APP.Salutation}</span>
		                                    </label>
		                                </div>
									</div>
									<div class="slds-col slds-size_4-of-12 slds-p-right_xxx-small slds-p-left_none">
										<div class="slds-select_container">
											<select class="slds-select" name="salutationtype">
												{foreach item=arr from=$fldvalue}
												<option value="{$arr[1]}" {$arr[2]}>
												{$arr[0]}
												</option>
												{/foreach}
											</select>
										</div>										
									</div>
									{/if}
									<div class="slds-col slds-size_{if $fldvalue neq ''}6{else}12{/if}-of-12 slds-p-horizontal_none">
									{if (isset($maindata['extendedfieldinfo']) && isset($maindata['extendedfieldinfo']['searchfields']))}
										{assign var="autocomp" value=$maindata['extendedfieldinfo'] }
										<div style="position: relative;">
										<input
											type="text"
											name="{$fldname}"
											id="{$fldname}"
											tabindex="{$vt_tab}"
											value="{$secondvalue}"
											tabindex="{$vt_tab}"
											autocomplete="off"
											class="autocomplete-input slds-input"
											data-autocomp='{$maindata["extendedfieldinfo"]|@json_encode}' />
											<div id="listbox-unique-id" role="listbox" class="">
												<ul class="slds-listbox slds-listbox_vertical slds-dropdown slds-dropdown_fluid relation-autocomplete__target" style="opacity: 0; width: 100%; list-style-type: none; width: 90%; left: 0; transform: translateX(0); max-width: none;" role="presentation"></ul>
											</div>
										</div>
									{else}
										<input type="text" name="{$fldname}" id="{$fldname}" tabindex="{$vt_tab}" class="slds-input" value= "{$secondvalue}" >
									{/if}										
									</div>
								</div>
                            </div>
                        {if $MASS_EDIT eq '1'}
                        {* Close an extra div when doing mass-edit *}
                        </div>
                        {/if}
                    </div>
                </div>
            </div>
            <!-- // Field: UI type 55 / 255 -->		

		{elseif $uitype eq '69m'}
			<td width="20%" class="dvtCellLabel{if $mandatory_field == '*'} mandatory_field_label{/if}" align=right>
				<font color="red">{$mandatory_field}</font>{$usefldlabel}
				{if $MASS_EDIT eq '1'}
					<input type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" class="small"  >
				{/if}
			</td>
			<td colspan="1" width="30%" align=left class="dvtCellInfo">
				{if $MODULE eq 'Products'}
					<input name="del_file_list" type="hidden" value="">
					<div id="files_list" style="border: 1px solid grey; width: 500px; padding: 5px; background: rgb(255, 255, 255) none repeat scroll 0%; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; font-size: x-small">
						<span id="limitmsg" style= "color:red;"> {'LBL_MAX_SIZE'|@getTranslatedString:$MODULE} {$UPLOADSIZE}{'LBL_FILESIZEIN_MB'|@getTranslatedString:$MODULE}, {$APP.Files_Maximum}{$Product_Maximum_Number_Images}</span>
						<input id="my_file_element" type="file" name="file_1" tabindex="{$vt_tab}"  onchange="validateFilename(this)"/>
						<!--input type="hidden" name="file_1_hidden" value=""/-->
						{assign var=image_count value=0}
						{if isset($maindata[3].0.name) && $maindata[3].0.name neq '' && $DUPLICATE neq 'true'}
							{foreach name=image_loop key=num item=image_details from=$maindata[3]}
							<div align="center">
								<img src="{$image_details.path}{$image_details.name}" height="50">&nbsp;&nbsp;[{$image_details.orgname}]<input id="file_{$num}" value="{'LBL_DELETE_BUTTON'|@getTranslatedString}" type="button" class="crmbutton small delete" onclick='this.parentNode.parentNode.removeChild(this.parentNode);delRowEmt("{$image_details.orgname}")'>
							</div>
							{assign var=image_count value=$smarty.foreach.image_loop.iteration}
							{/foreach}
						{/if}
					</div>

					<script>
						{*<!-- Create an instance of the multiSelector class, pass it the output target and the max number of files -->*}
						var multi_selector = new MultiSelector( document.getElementById( 'files_list' ), {$Product_Maximum_Number_Images} );
						multi_selector.count = {$image_count};
						{*<!-- Pass in the file element -->*}
						multi_selector.addElement( document.getElementById( 'my_file_element' ) );
					</script>
				{/if}
			</td>
		{elseif $uitype eq 69}
			<td width="20%" class="dvtCellLabel{if $mandatory_field == '*'} mandatory_field_label{/if}" align=right>
				<font color="red">{$mandatory_field}</font>{$usefldlabel}
				{if $MASS_EDIT eq '1'}
					<input type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" class="small"  >
				{/if}
			</td>
			<td colspan="1" width="30%" align=left class="dvtCellInfo">
				<div style="display: flex;flex-direction: row; width:100%">
				<div width="80%">
				<span id="limitmsg" style= "color:red;"> {'LBL_MAX_SIZE'|@getTranslatedString:$MODULE} {$UPLOADSIZE}{'LBL_FILESIZEIN_MB'|@getTranslatedString:$MODULE}<br /></span>
				{if isset($maindata[3].0.name) && $maindata[3].0.name != ''}
					{assign var=imagevalueexists value=true}
				{else}
					{assign var=imagevalueexists value=false}
				{/if}
				<input name="{$fldname}" id="{$fldname}" type="file" value="{if $imagevalueexists}{$maindata[3].0.name}{/if}" tabindex="{$vt_tab}" onchange="validateFilename(this);" />
				<input name="{$fldname}_hidden" id="{$fldname}_hidden" type="hidden" value="{if $imagevalueexists}{$maindata[3].0.name}{/if}" />
				{if $imagevalueexists}
					<div id="{$fldname}_replaceimage">[{$maindata[3].0.orgname}] <input id="{$fldname}_attach" value="{'LBL_DELETE_BUTTON'|@getTranslatedString}" type="button" class="crmbutton small delete" onclick='delimage({if !empty($ID)}{$ID}{else}0{/if},"{$fldname}","{$maindata[3].0.orgname}");'></div>
				{/if}
				<div id="displaySize"></div>
				</div>
				<div style="width:50px;height:50px;overflow: hidden;">
					<canvas style="border:1px solid grey;" id="{$fldname}_canvas" tabindex="{$vt_tab}1}"></canvas>
					<input name="{$fldname}_canvas_image" id="{$fldname}_canvas_image" type="hidden" value="" />
					<input name="{$fldname}_canvas_image_set" id="{$fldname}_canvas_image_set" type="hidden" value="0" />
					<script>var {$fldname}_CLIPBOARD = new CLIPBOARD_CLASS("{$fldname}_canvas", true);</script>
				</div>
				</div>
			</td>

		{elseif $uitype eq 61}
			<td width="20%" class="dvtCellLabel{if $mandatory_field == '*'} mandatory_field_label{/if}" align=right>
				<font color="red">{$mandatory_field}</font>{$usefldlabel}
				{if $MASS_EDIT eq '1'}
					<input type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" class="small"  disabled >
				{/if}
			</td>

			<td colspan="1" width="30%" align=left class="dvtCellInfo">
				<input name="{$fldname}"  type="file" value="{$secondvalue}" tabindex="{$vt_tab}" onchange="validateFilename(this)"/>
				<input type="hidden" name="{$fldname}_hidden" value="{$secondvalue}"/>
				<input type="hidden" name="id" value=""/>{$fldvalue}
			</td>
		{elseif $uitype eq 156}
			<td width="20%" class="dvtCellLabel{if $mandatory_field == '*'} mandatory_field_label{/if}" align=right>
				<font color="red">{$mandatory_field}</font>{$usefldlabel} {if $MASS_EDIT eq '1'}<input type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" class="small" >{/if}
			</td>
				{if $fldvalue eq 'on'}
					<td width="30%" align=left class="dvtCellInfo">
						{if ($secondvalue eq 1 && isset($smarty.request.record) && $CURRENT_USERID != $smarty.request.record) || ($MODE == 'create')}
							<input name="{$fldname}" tabindex="{$vt_tab}" type="checkbox" checked>
						{else}
							<input name="{$fldname}" type="hidden" value="on">
							<input name="{$fldname}" disabled tabindex="{$vt_tab}" type="checkbox" checked>
						{/if}
					</td>
				{else}
					<td width="30%" align=left class="dvtCellInfo">
						{if ($secondvalue eq 1 && isset($smarty.request.record) && $CURRENT_USERID != $smarty.request.record) || ($MODE == 'create')}
							<input name="{$fldname}" tabindex="{$vt_tab}" type="checkbox">
						{else}
							<input name="{$fldname}" disabled tabindex="{$vt_tab}" type="checkbox">
						{/if}
					</td>
				{/if}
		{elseif $uitype eq 98}<!-- Role Selection Popup -->
			<td width="20%" class="dvtCellLabel{if $mandatory_field == '*'} mandatory_field_label{/if}" align=right>
				<font color="red">{$mandatory_field}</font>{$usefldlabel} {if $MASS_EDIT eq '1'}<input type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" class="small" >{/if}
			</td>
			<td width="30%" align=left class="dvtCellInfo">
			{if $thirdvalue eq 1}
				<input name="role_name" id="role_name" readonly class="txtBox" tabindex="{$vt_tab}" value="{$secondvalue}" type="text">&nbsp;
				<a href="javascript:openPopup();"><img src="{'select.gif'|@vtiger_imageurl:$THEME}" align="absmiddle" border="0"></a>
			{else}
				<input name="role_name" id="role_name" tabindex="{$vt_tab}" class="txtBox" readonly value="{$secondvalue}" type="text">&nbsp;
			{/if}
			<input name="user_role" id="user_role" value="{$fldvalue}" type="hidden">
			</td>
		{elseif $uitype eq 115}<!-- for Status field Disabled for nonadmin -->
			<td width="20%" class="dvtCellLabel{if $mandatory_field == '*'} mandatory_field_label{/if}" align=right>
				<font color="red">{$mandatory_field}</font>{$usefldlabel} {if $MASS_EDIT eq '1'}<input type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" class="small" >{/if}
			</td>
			<td width="30%" align=left class="dvtCellInfo">
				{if $secondvalue eq 1 && isset($smarty.request.record) && $CURRENT_USERID != $smarty.request.record}
					<select id="user_status" name="{$fldname}" tabindex="{$vt_tab}" class="small">
				{else}
					<select id="user_status" disabled name="{$fldname}" class="small">
				{/if}
				{foreach item=arr from=$fldvalue}
					<option value="{$arr[1]}" {$arr[2]} >{$arr[0]}</option>
				{/foreach}
					</select>
			</td>
		{elseif $uitype eq 105}
			<td width="20%" class="dvtCellLabel{if $mandatory_field == '*'} mandatory_field_label{/if}" align=right>
				<font color="red">{$mandatory_field}</font>{$usefldlabel} {if $MASS_EDIT eq '1'}<input type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" class="small" >{/if}
			</td>
			<td width="30%" align=left class="dvtCellInfo">
				{if $MODE eq 'edit' && $IMAGENAME neq ''}
					<input name="{$fldname}" type="file" value="{$maindata[3].0.name}" tabindex="{$vt_tab}" onchange="validateFilename(this);" /><div id="replaceimage">[{$IMAGENAME}]&nbsp;<a href="javascript:;" onClick="delUserImage({$ID})">Del</a></div>
					<br>{'LBL_IMG_FORMATS'|@getTranslatedString:$MODULE}
					<input name="{$fldname}_hidden"  type="hidden" value="{$maindata[3].0.name}" />
				{else}
					<input name="{$fldname}" type="file" value="" tabindex="{$vt_tab}" onchange="validateFilename(this);" /><br>{'LBL_IMG_FORMATS'|@getTranslatedString:$MODULE}
					<input name="{$fldname}_hidden"  type="hidden" value="" />
				{/if}
					<div id="displaySize"></div>
					<input type="hidden" name="id" value=""/>
					{if isset($maindata[3].0.name) }
					{$maindata[3].0.name}
					{/if}
			</td>
			{elseif $uitype eq 103}
			<td width="20%" class="dvtCellLabel{if $mandatory_field == '*'} mandatory_field_label{/if}" align=right>
				<font color="red">{$mandatory_field}</font>{$usefldlabel} {if $MASS_EDIT eq '1'}<input type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" class="small" >{/if}
			</td>
			<td width="30%" colspan="3" align=left class="dvtCellInfo">
				<input type="text" name="{$fldname}" value="{$fldvalue}" tabindex="{$vt_tab}" class=detailedViewTextBox onFocus="this.className='detailedViewTextBoxOn'" onBlur="this.className='detailedViewTextBox'">
			</td>
			{elseif $uitype eq 101}<!-- for reportsto field USERS POPUP -->
				<td width="20%" class="dvtCellLabel{if $mandatory_field == '*'} mandatory_field_label{/if}" align=right>
					<font color="red">{$mandatory_field}</font>{$usefldlabel} {if $MASS_EDIT eq '1'}<input type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" class="small" >{/if}
				</td>
				<td width="30%" align=left class="dvtCellInfo">
					<input id="{$fldname}_display" name="{$fldname}_display" readonly type="text" style="border:1px solid #bababa;" value="{$fldvalue}" class="small" />&nbsp;
					<input id="{$fldname}" name="{$fldname}" type="hidden" value="{$secondvalue}" id="{$fldname}" />
					&nbsp;<input title="{$APP.LBL_CHANGE_TITLE}" accessKey="C" type="button" class="small" value='{$APP.LBL_CHANGE}' name="btn1" onclick='return window.open("index.php?module=Users&action=Popup&html=Popup_picker&form=vtlibPopupView&form_submit=false&fromlink={$fromlink}&recordid={if isset($ID)}{$ID}{/if}&forfield={$fldname}","test","width=640,height=603,resizable=0,scrollbars=0");'>
					&nbsp;<input type="image" src="{'clear_field.gif'|@vtiger_imageurl:$THEME}" alt="{$APP.LBL_CLEAR}" title="{$APP.LBL_CLEAR}" onClick="this.form.{$fldname}.value=''; this.form.{$fldname}_display.value=''; return false;" align="absmiddle" style='cursor:hand;cursor:pointer'>
				</td>
			{elseif $uitype eq 117}<!-- for currency in users details-->
			<td width="20%" class="dvtCellLabel{if $mandatory_field == '*'} mandatory_field_label{/if}" align=right>
				<font color="red">{$mandatory_field}</font>{$usefldlabel} {if $MASS_EDIT eq '1'}<input type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" class="small" >{/if}
			</td>
			<td width="30%" align=left class="dvtCellInfo">
			   {if $secondvalue eq 1 || $uitype eq 117}
				<select name="{$fldname}" tabindex="{$vt_tab}" class="small">
			   {else}
				<select disabled name="{$fldname}" tabindex="{$vt_tab}" class="small">
			   {/if}
				{assign var="curr_stat" value=""}
				{foreach item=arr key=uivalueid from=$fldvalue}
					{foreach key=sel_value item=value from=$arr}
						<option value="{$uivalueid}" {$value}>{$sel_value|@getTranslatedCurrencyString}</option>
						<!-- code added to pass Currency field value, if Disabled for nonadmin -->
						{if $value eq 'selected' && $secondvalue neq 1}
							{assign var="curr_stat" value="$uivalueid"}
						{/if}
						<!--code ends -->
					{/foreach}
				{/foreach}
			   </select>
			<!-- code added to pass Currency field value, if Disabled for nonadmin -->
			{if $curr_stat neq '' && $uitype neq 117}
				<input name="{$fldname}" type="hidden" value="{$curr_stat}">
			{/if}
			<!--code ends -->
			</td>
			{elseif $uitype eq 106}
			<td width=20% class="dvtCellLabel{if $mandatory_field == '*'} mandatory_field_label{/if}" align=right>
				<font color="red">{$mandatory_field}</font>{$usefldlabel} {if $MASS_EDIT eq '1'}<input type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" class="small" >{/if}
			</td>
			<td width=30% align=left class="dvtCellInfo">
				{if $MODE eq 'edit'}
				<input type="text" readonly name="{$fldname}" value="{$fldvalue}" tabindex="{$vt_tab}" class=detailedViewTextBox onFocus="this.className='detailedViewTextBoxOn'" onBlur="this.className='detailedViewTextBox'">
				{else}
				<input type="text" name="{$fldname}" value="{$fldvalue}" tabindex="{$vt_tab}" class=detailedViewTextBox onFocus="this.className='detailedViewTextBoxOn'" onBlur="this.className='detailedViewTextBox'">
				{/if}
			</td>
			{elseif $uitype eq 99}
				{if $MODE eq 'create'}
				<td width=20% class="dvtCellLabel{if $mandatory_field == '*'} mandatory_field_label{/if}" align=right>
					<font color="red">{$mandatory_field}</font>{$usefldlabel} {if $MASS_EDIT eq '1'}<input type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" class="small" >{/if}
				</td>
				<td width=30% align=left class="dvtCellInfo">
					<input type="password" name="{$fldname}" tabindex="{$vt_tab}" value="{$fldvalue}" class=detailedViewTextBox onFocus="this.className='detailedViewTextBoxOn'" onBlur="this.className='detailedViewTextBox'">
				</td>
				{/if}
		{elseif $uitype eq 30}
			<td width="20%" class="dvtCellLabel{if $mandatory_field == '*'} mandatory_field_label{/if}" align=right>
				<font color="red">{$mandatory_field}</font>{$usefldlabel} {if $MASS_EDIT eq '1'}<input type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" class="small" >{/if}
			</td>
			<td colspan="3" width="30%" align=left class="dvtCellInfo">
				{assign var=check value=$secondvalue[0]}
				{assign var=yes_val value=$secondvalue[1]}
				{assign var=no_val value=$secondvalue[2]}

				<input type="radio" name="set_reminder" tabindex="{$vt_tab}" value="Yes" {$check}>&nbsp;{$yes_val}&nbsp;
				<input type="radio" name="set_reminder" value="No">&nbsp;{$no_val}&nbsp;

				{foreach item=val_arr from=$fldvalue}
					{assign var=start value=$val_arr[0]}
					{assign var=end value=$val_arr[1]}
					{assign var=sendname value=$val_arr[2]}
					{assign var=disp_text value=$val_arr[3]}
					{assign var=sel_val value=$val_arr[4]}
					<select name="{$sendname}" class="small">
						{section name=reminder start=$start max=$end loop=$end step=1 }
							{if $smarty.section.reminder.index eq $sel_val}
								{assign var=sel_value value="SELECTED"}
							{else}
								{assign var=sel_value value=""}
							{/if}
							<OPTION VALUE="{$smarty.section.reminder.index}" "{$sel_value}">{$smarty.section.reminder.index}</OPTION>
						{/section}
					</select>
					&nbsp;{$disp_text}
				{/foreach}
			</td>
		{elseif $uitype eq 26}
		<td width="20%" class="dvtCellLabel{if $mandatory_field == '*'} mandatory_field_label{/if}" align=right>
		<font color="red">{$mandatory_field}</font>{$fldlabel}
		{if $MASS_EDIT eq '1'}<input type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" class="small" >{/if}
		</td>
		<td width="30%" align=left class="dvtCellInfo">
			<select name="{$fldname}" tabindex="{$vt_tab}" class="small">
				{foreach item=v key=k from=$fldvalue}
				<option value="{$k}">{$v}</option>
				{/foreach}
			</select>
		</td>
		{elseif $uitype eq 27}
		<td width="20%" class="dvtCellLabel{if $mandatory_field == '*'} mandatory_field_label{/if}" align="right" >
			<font color="red">{$mandatory_field}</font>{$fldlabel_other}&nbsp;
			{if $MASS_EDIT eq '1'}<input type="checkbox" name="{$fldname}" id="{$fldname}_mass_edit_check" class="small" >{/if}
        </td>
        <td width="30%" align=left class="dvtCellInfo">
			<select class="small" name="{$fldname}" onchange="changeDldType((this.value=='I')? 'file': 'text');">
				{section name=combo loop=$fldlabel}
					<option value="{$fldlabel_combo[combo]}" {$fldlabel_sel[combo]} >{$fldlabel[combo]} </option>
				{/section}
			</select>
			<script>
				function vtiger_{$fldname}Init(){ldelim}
					var d = document.getElementsByName('{$fldname}')[0];
					var type = (d.value=='I')? 'file': 'text';

					changeDldType(type, true);
				{rdelim}
				if(typeof window.onload =='function'){ldelim}
					var oldOnLoad = window.onload;
					document.body.onload = function(){ldelim}
						vtiger_{$fldname}Init();
						oldOnLoad();
					{rdelim}
				{rdelim}else{ldelim}
					window.onload = function(){ldelim}
						vtiger_{$fldname}Init();
					{rdelim}
				{rdelim}

			</script>
		</td>
		{elseif $uitype eq 28}
		<td width="20%" class="dvtCellLabel{if $mandatory_field == '*'} mandatory_field_label{/if}" align=right>
			<font color="red">{$mandatory_field}</font>{$usefldlabel}
			{if $MASS_EDIT eq '1'}
				<input type="checkbox" name="{$fldname}_mass_edit_check" id="{$fldname}_mass_edit_check" class="small"  disabled >
			{/if}
		</td>

		<td colspan="1" width="30%" align="left" class="dvtCellInfo">
		<script type="text/javascript">
			function changeDldType(type, onInit){ldelim}
				var fieldname = '{$fldname}';
				if(!onInit){ldelim}
					var dh = getObj('{$fldname}_hidden');
					if(dh) dh.value = '';
				{rdelim}

				var v1 = document.getElementById(fieldname+'_E__');
				var v2 = document.getElementById(fieldname+'_I__');
				var msg = document.getElementById('limitmsg');

				var text = v1.type =="text"? v1: v2;
				var file = v1.type =="file"? v1: v2;
				var filename = document.getElementById(fieldname+'_value');
				{literal}
				if(type == 'file'){
					// Avoid sending two form parameters with same key to server
					file.name = fieldname;
					text.name = '_' + fieldname;

					file.style.display = '';
					text.style.display = 'none';
					text.value = '';
					filename.style.display = '';
					msg.style.display = '';
				}else{
					// Avoid sending two form parameters with same key to server
					text.name = fieldname;
					file.name = '_' + fieldname;

					file.style.display = 'none';
					text.style.display = '';
					file.value = '';
					filename.style.display = 'none';
					filename.innerHTML="";
					msg.style.display = 'none';
				}
				{/literal}
			{rdelim}
		</script>
		<div>
			<input name="{$fldname}" id="{$fldname}_I__" type="file" value="{$secondvalue}" tabindex="{$vt_tab}" onchange="validateFilename(this);validateFileSize(this,'{$UPLOAD_MAXSIZE}');" style="display: none;"/>
			<input type="hidden" name="{$fldname}_hidden" value="{$secondvalue}"/>
			<input type="hidden" name="id" value=""/>
			<input type="text" id="{$fldname}_E__" name="{$fldname}" class="detailedViewTextBox" onFocus="this.className='detailedViewTextBoxOn'" onBlur="this.className='detailedViewTextBox'" value="{$secondvalue}" /><br>
			<div id="displaySize"></div>
			<span id="{$fldname}_value" style="display:none;">
			{if $secondvalue neq ''}
				[{$secondvalue}]
			{/if}
			</span>
		</div>
		<span id="limitmsg" style= "color:red; display:none;"> {'LBL_MAX_SIZE'|@getTranslatedString:$MODULE} {$UPLOADSIZE}{'LBL_FILESIZEIN_MB'|@getTranslatedString:$MODULE}</span>
		</td>

		{elseif $uitype eq 83} <!-- Handle the Tax in Inventory -->
            <!-- Field: UI type 83 -->
            <div class="slds-col slds-size_1-of-2 slds-grid">
            	<div class="slds-form slds-form_stacked slds-size_12-of-12" role="list">
	            	{foreach item=tax key=count from=$TAX_DETAILS}
					{if $tax.check_value eq 1}
						{assign var=check_value value="checked"}
					{else}
						{assign var=check_value value=""}
					{/if}	            	
	            	<div class="slds-form slds-form_horizontal slds-p-bottom_xx-small">
	                    <label class="slds-form-element__label">
	                    	{if $mandatory_field == '*'}<abbr class="slds-required" title="required">* </abbr>{/if}{$tax.taxlabel} {$APP.COVERED_PERCENTAGE}
	                	</label>
	                    <div class="slds-form-element__control">
	                        <div class="slds-grid">                    	
	                            <div class="slds-col slds-size_1-of-12 slds-m-right_small">
	                                <div class="slds-checkbox_add-button">
	                                    <input class="slds-assistive-text" type="checkbox" name="{$tax.check_name}" id="{$tax.check_name}" onclick="fnshowHide(this,'{$tax.taxname}')" {$check_value} />
	                                    <label for="{$tax.check_name}" class="slds-checkbox_faux">
	                                        <span class="slds-assistive-text">{$tax.taxlabel}</span>
	                                    </label>
	                                </div>
	                            </div>
	                            <div class="slds-col slds-size_11-of-12">
	                                <input type="text" name="{$tax.taxname}" id="{$tax.taxname}" value="{$tax.percentage}" class="detailedViewTextBox slds-input{if $check_value == 'checked'} slds-show{else} slds-hide{/if}" onBlur="fntaxValidation('{$tax.taxname}')" />
	                            </div>
	                        </div>
	                    </div>
		            </div>
	                {/foreach}
			    </div>
            </div>
            <!-- // Field: UI type 83 -->		

		{else}
			{* just show field on screen *}
			<td width=20% class="dvtCellLabel" align=right>{$fldlabel}</td>
			<td width=30% align=left class="dvtCellInfo">
				{if $fldname neq ''}<input type="hidden" name="{$fldname}" id="{$fldname}" value="{$fldvalue.fieldsavevalue}">{/if}{if isset($fldvalue.fieldshowvalue)}{$fldvalue.fieldshowvalue}{/if}
			</td>
		{/if}
