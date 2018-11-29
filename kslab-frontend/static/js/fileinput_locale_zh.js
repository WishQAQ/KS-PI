/*!
 * FileInput Spanish (Latin American) Translations
 *
 * This file must be loaded after 'fileinput.js'. Patterns in braces '{}', or
 * any HTML markup tags in the messages must not be converted or translated.
 *
 * @see http://github.com/kartik-v/bootstrap-fileinput
 *
 * NOTE: this file must be saved in UTF-8 encoding.
 */
(function ($) {
    "use strict";
    $.fn.fileinput.locales.es = {
      fileSingle: '单个文件',
      filePlural: '多个文件',
      browseLabel: '选择文件 &hellip;',
      removeLabel: '删除文件',
      removeTitle: '删除选中文件',
      cancelLabel: '取消',
      cancelTitle: '取消上传',
      uploadLabel: '上传',
      uploadTitle: '上传选中文件',
      msgSizeTooLarge: '文件"{name}" (<b>{size} KB</b>)超过了最大允许上传大小<b>{maxSize} KB</b>.请重试！',
      msgFilesTooLess: '你必须选择最少 <b>{n}</b> {files}来上传',
      msgFilesTooMany: '选择上传的文件数量<b>({n})</b>超过了允许的上限<b>{m}</b>.请重试！',
      msgFileNotFound: '文件 "{name}" 未找到!',
      msgFileSecured: '安全限制阻止读取文件"{name}".',
      msgFileNotReadable: '文件"{name}"是不可读的.',
      msgFilePreviewAborted: '文件"{name}"预览中止.',
      msgFilePreviewError: '读取文件"{name}"时发生错误.',
      msgInvalidFileType: '无效的文件类型"{name}". 只支持"{types}"类型的文件.',
      msgInvalidFileExtension: '无效的文件拓展名"{name}". 只支持 "{extensions}"的文件拓展名.',
      msgValidationError: '文件上传错误',
      msgLoading: '加载第{index}个文件 共{files} &hellip;',
      msgProgress: '加载第{index}个文件 共{files} - {name} - {percent}%完成.',
      msgSelected: '选中{n}个文件',
      msgFoldersNotAllowed: '只支持拖放文件! 跳过了{n}个文件夹.',
      dropZoneTitle: '拖放文件到这里 &hellip;'
    };

    $.extend($.fn.fileinput.defaults, $.fn.fileinput.locales.es);
})(window.jQuery);
