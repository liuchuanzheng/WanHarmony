/**
 * @desc：工具类
 */

//1-判断是否为空字符串
export const isEmpty = (data: string | [] | number | object) => {
  if (data == undefined || data == null) {
    return true;
  }
  if (typeof data === 'string') {
    return data.trim() === '';
  }
  if (typeof data === 'number') {
    return false;
  }
  if (Array.isArray(data)) {
    return data.length <= 0;
  }
  if (typeof data === 'object') {
    return Object.keys(data).length <= 0;
  }
  return false;
};

//2-格式化字符串
const formatHtml = (html: string) => {
  let data = ''
  if (!isEmpty(html)) {
    let regSymbol = RegExp("&.*;")
    let regHtml = RegExp(/<[^>]*>/g);
    data = html.replace(regSymbol, '').replace(regHtml, '')
  }
  return data
}
