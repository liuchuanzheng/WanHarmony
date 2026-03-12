import { hilog } from "@kit.PerformanceAnalysisKit";
import { preferences } from '@kit.ArkData';
import { common } from "@kit.AbilityKit";

/**
 * Cookie管理器
 */
class CookieManager {
  private cookies: Map<string, string> = new Map();
  private preferencesKey = 'net_cookies';

  constructor() {
    this.loadCookiesFromStorage();
  }

  // 从本地存储加载cookie
  private async loadCookiesFromStorage(): Promise<void> {
    try {
      const context = getContext(this) as common.UIAbilityContext;
      const prefs = await preferences.getPreferences(context, 'cookie_storage');
      const storedCookies = await prefs.get(this.preferencesKey, '{}') as string;
      hilog.info(0x0000, 'CookieManager', `从存储加载Cookie: ${storedCookies}`);
      const cookieObj: Record<string, string> = JSON.parse(storedCookies);
      let entries = Object.entries(cookieObj);
      entries.forEach((item: [string, string]) => {
        this.cookies.set(item[0], item[1]);
      });

      hilog.info(0x0000, 'CookieManager', `从存储加载Cookie数量: ${this.cookies.size}`);
    } catch (error) {
      hilog.error(0x0000, 'CookieManager', `加载Cookie失败: ${error}`);
    }
  }

  // 保存cookie到本地存储
  private async saveCookiesToStorage(): Promise<void> {
    try {
      const cookieObj: Record<string, string> = {};
      this.cookies.forEach((value, name) => {
        cookieObj[name] = value;
      });

      const context = getContext(this) as common.UIAbilityContext;
      const prefs = await preferences.getPreferences(context, 'cookie_storage');
      await prefs.put(this.preferencesKey, JSON.stringify(cookieObj));
      await prefs.flush();

      hilog.info(0x0000, 'CookieManager', `保存Cookie到存储: ${this.cookies.size}个`);
    } catch (error) {
      hilog.error(0x0000, 'CookieManager', `保存Cookie失败: ${error}`);
    }
  }

  // 从响应头中提取并保存cookie
  async saveCookiesFromResponse(headers: object): Promise<void> {
    const cookieHeader: string | string[] = headers['set-cookie'] || headers['Set-Cookie'];
    let hasNewCookie = false;

    if (cookieHeader) {
      const cookies = (Array.isArray(cookieHeader) ? cookieHeader : [cookieHeader]) as string[];
      cookies.forEach(cookie => {
        const cookieParts = cookie.split(';')[0].split('=');
        if (cookieParts.length >= 2) {
          const name = cookieParts[0].trim();
          const value = cookieParts.slice(1).join('=').trim();

          // 检查是否是新的cookie或值有变化
          if (!this.cookies.has(name) || this.cookies.get(name) !== value) {
            this.cookies.set(name, value);
            hasNewCookie = true;
            hilog.info(0x0000, 'CookieManager', `保存Cookie: ${name}=${value}`);
          }
        }
      });

      // 如果有新的cookie，保存到本地存储
      if (hasNewCookie) {
        await this.saveCookiesToStorage();
      }
    }
  }

  // 获取cookie请求头
  getCookieHeader(): string {
    if (this.cookies.size === 0) {
      return '';
    }

    const cookieStrings: string[] = [];
    this.cookies.forEach((value, name) => {
      cookieStrings.push(`${name}=${value}`);
    });
    let cookieStringFinal = cookieStrings.join('; ')
    hilog.info(0x0000, 'CookieManager', `获取Cookie请求头: ${cookieStringFinal}`);
    return cookieStringFinal;
  }

  // 清除所有cookie
  async clearCookies(): Promise<void> {
    this.cookies.clear();
    hilog.info(0x0000, 'CookieManager', '清除所有Cookie');

    // 同时清除本地存储的cookie
    try {
      const context = getContext(this) as common.UIAbilityContext;
      const prefs = await preferences.getPreferences(context, 'cookie_storage');
      await prefs.delete(this.preferencesKey);
      await prefs.flush();
      hilog.info(0x0000, 'CookieManager', '清除存储中的Cookie');
    } catch (error) {
      hilog.error(0x0000, 'CookieManager', `清除存储Cookie失败: ${error}`);
    }
  }
}

export const cookieManager = new CookieManager();