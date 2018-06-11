/**
 * Created by zhouyi on 2018/3/28.
 */
(function($) {
    'use strict';


    var _COMMAND = 'cubeditor';
    $.widget("youi.cubeditor",$.youi.abstractWidget,$.extend({},{

        options:{
            //cancel:'.clipboard-value'
        },

        /**
         * 组件初始化
         * @private
         */
        _initWidget:function(){
            this.contentElem = this.element.find('>.cubeditor-content');
        },

        /**
         * 绑定事件
         * @private
         */
        _initAction:function () {
            var actions = {},
                commandActionName = 'click [data-command='+_COMMAND+']';

            actions[commandActionName] = function (event) {
                var elem = $(event.currentTarget),
                    commandOptions = $.extend({ctrlKey:event.ctrlKey},elem.data());
                this.execCommand(event.currentTarget,commandOptions);
            }

            this._on(actions);
        },

        loadCube:function (indicatorId,areaId) {
            $.youi.ajaxUtils.ajax({
                url:this.options.queryByIndicatorAndAreaUrl,
                data:'timeExpression=all&indicatorId='+indicatorId+'&areaId='+areaId,
                success:this._proxy('_parseCube',indicatorId,areaId)
            });
        },

        saveIndicatorData:function (dom,commandOptions) {
            var datas = [];
            $(dom).parents('tr:first').find('input[data-attr-id]').each(function () {
                datas.push({
                    dataId:$(this).data('id'),
                    indicatorAttrId:$(this).data('attrId'),
                    indicatorId:commandOptions.indicatorId,
                    areaId:commandOptions.areaId,
                    periodId:commandOptions.periodId,
                    dataValue:$(this).val()
                });
            });
            $.youi.messageUtils.confirm('确认保存数据？',this._proxy('_doSaveIndicatorData',datas));
        },

        _doSaveIndicatorData:function (datas) {
            $.youi.ajaxUtils.ajax({
                url:this.options.saveMdatasUrl,
                data:$.youi.recordUtils.recordToAjaxParamStr({datas:datas}),
                success:function(result){

                }
            });
        },

        /**
         *
         * @param result
         * @private
         */
        _parseCube:function (result,indicatorId,areaId) {
            if(result&&result.record){
                //属性构造列
                var htmls = [],headers = ['数据时间'];

                var attrDimension,
                    periodDimension;
                $(result.record.dimensions).each(function () {
                    if(this.id=='A'){
                        attrDimension = this;
                    }else if(this.id=='P'){
                        periodDimension = this;
                    }
                });

                if(attrDimension){
                    //指标、
                    $(attrDimension.items).each(function () {
                        headers.push(this.text);
                    });
                }


                htmls.push('<table class="table" width="100%">');


                htmls.push('<thead>');
                $(headers).each(function (index) {
                    htmls.push('<td '+(index==0?' align="center"':'')+'>'+this+'</td>');
                });
                htmls.push('<td align="center">操作</td>');
                htmls.push('</thead>');

                if(periodDimension){
                    var periodItems = [].concat(periodDimension.items);

                    periodItems.sort(function(item1,item2) {
                        return item1.id>item2.id?-1:1;
                    });

                    $(periodItems).each(function () {
                        this.dimId = 'P';
                        var periodItem = this;

                        htmls.push('<tr>');

                        htmls.push('<td align="center">'+this.text+'</td>');

                        $(attrDimension.items).each(function () {
                            this.dimId = 'A';
                            var valueKey = _buildValueKey([{id:indicatorId,dimId:'I'},{id:areaId,dimId:'D'},periodItem,this]);
                            var value = result.record.datas[valueKey]?result.record.datas[valueKey].data.strValue:' ';
                            htmls.push('<td><input data-id="'+valueKey+'" data-attr-id="'+this.id+'" type="text" value="'+value+'"/></td>');
                        });

                        htmls.push('<td align="center" style="vertical-align:middle;"><span data-command="'+_COMMAND+'" data-period-id="'+periodItem.id+'" data-area-id="'+areaId+'" data-indicator-id="'+indicatorId+'" data-name="saveIndicatorData" class="youi-icon icon-save"></span></td>');

                        htmls.push('<tr>');
                    });
                }

                htmls.push('</table>');

                this.contentElem.html(htmls.join(''));
            }
        }

    }));

    function _buildValueKey(items){

        //排序
        items.sort(function(item1,item2){
            return item1.dimId>item2.dimId?1:-1;
        });

        var keys = [];
        $(items).each(function(){
            keys.push(this.dimId+'.'+this.id);
        });


        return keys.join('|');
    }
})(jQuery);