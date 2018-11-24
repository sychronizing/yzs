package cn.com.seo.base.utils;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLConnection;
import java.util.concurrent.TimeUnit;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;

public class HttpRequestUtil {
	
	/** ��־ */
	private static Logger log = Logger.getLogger(HttpRequestUtil.class);

	/**
	 * ��ָ��URL����GET����������
	 * ����������������Ӧ���� name1=value1&name2=value2 ����ʽ��
	 * @param url
	 *            ���������URL
	 * @return URL ������Զ����Դ����Ӧ���
	 */
	public static String sendGet(String url) {
		StringBuilder result = new StringBuilder();
		BufferedReader in = null;
		try {
			URL realUrl = new URL(url);
			// �򿪺�URL֮�������
			URLConnection connection = realUrl.openConnection();
			// ����ͨ�õ���������
		//	connection.setRequestProperty("accept", "*/*");
		//	connection.setRequestProperty("connection", "Keep-Alive");
		//	connection.setRequestProperty("user-agent","Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
		//	connection.setRequestProperty("Accept-Charset", "utf-8");
		//	connection.setRequestProperty("Content-Type",  "application/x-www-form-urlencoded");
			// ����ʵ�ʵ�����
			connection.connect();
			in = new BufferedReader(new InputStreamReader(
					connection.getInputStream(), "utf-8"));
			String line;
			while ((line = in.readLine()) != null) {
				result.append(line);
			}
		} catch (Exception e) {
//			System.out.println("����GET��������쳣��" + e);
			result = new StringBuilder("{\"resCode\":\"1\",\"errCode\":\"1001\",\"resData\":\"\"}");
			e.printStackTrace();
			log.error("Զ�̷���δ����", e);
		}
		// ʹ��finally�����ر�������
		finally {
			try {
				if (in != null) {
					in.close();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return result.toString();
	}

	/**
	 * ��ָ�� URL ����POST����������
	 * 
	 * @param url
	 *            ��������� URL
	 * @param param
	 *            ����������������Ӧ���� name1=value1&name2=value2 ����ʽ��
	 * @return ������Զ����Դ����Ӧ���
	 */
	public static String sendPost(String url, String param ,String key) {

		PrintWriter out = null;
		BufferedReader in = null;
		StringBuilder result = new StringBuilder();
	//	JSONObject jsStr = JSONObject.parseObject(param);
		try {
			URL realUrl = new URL(url);
			// �򿪺�URL֮�������
			URLConnection conn = realUrl.openConnection();
			// ����ͨ�õ���������
	//		conn.setRequestProperty("Content-Type", "application/json");
			conn.setRequestProperty("Content-Type",  "application/x-www-form-urlencoded");
			conn.setRequestProperty("Authorization", "APIKEY "+key);
			// ����POST�������������������
			conn.setDoOutput(true);
			conn.setDoInput(true);
			// ��ȡURLConnection�����Ӧ�������
			out = new PrintWriter(new OutputStreamWriter(conn.getOutputStream(), "utf-8"));
			// �����������
			out.print(param);
			// flush������Ļ���
			out.flush();
			// ����BufferedReader����������ȡURL����Ӧ
			in = new BufferedReader(new InputStreamReader(
					conn.getInputStream(), "utf-8"));
			String line;
			while ((line = in.readLine()) != null) {
				result.append(line);
			}
		} catch (Exception e) {
//			System.out.println("���� POST ��������쳣��" + e);
			result = new StringBuilder("{\"resCode\":\"1\",\"errCode\":\"1001\",\"resData\":\"\"}");
			e.printStackTrace();
			log.error("Զ�̷���δ����", e);
		}
		// ʹ��finally�����ر��������������
		finally {
			try {
				if (out != null) {
					out.close();
				}
				if (in != null) {
					in.close();
				}
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}

		return result.toString();
	}

	/**
	 * ��ָ�� URL ����POST����������
	 * 
	 * @param url
	 *            ��������� URL
	 * @param param
	 *            ����������������Ӧ���� name1=value1&name2=value2 ����ʽ��
	 * @return ������Զ����Դ����Ӧ���
	 */
	public static String sendFile(String url, String param,
			BufferedInputStream bInputStream) {

		BufferedOutputStream out = null;
		BufferedReader in = null;
		StringBuilder result = new StringBuilder();
		try {
			URL realUrl = new URL(url);
			// �򿪺�URL֮�������
			URLConnection conn = realUrl.openConnection();
			// ����ͨ�õ���������
			conn.setRequestProperty("accept", "*/*");
			conn.setRequestProperty("connection", "Keep-Alive");
			conn.setRequestProperty("user-agent",
					"Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
			conn.setRequestProperty("Accept-Charset", "UTF-8");
			conn.setRequestProperty("contentType", "multipart/form-data");
		

			// ����POST�������������������
			conn.setDoOutput(true);
			conn.setDoInput(true);
			// ���Ͳ���
			StringBuffer sb = new StringBuffer();
			sb = sb.append(param);
			byte[] paramData = sb.toString().getBytes();
//			System.out.println(paramData.length);
			
			out = new BufferedOutputStream(conn.getOutputStream());
			out.write(paramData);
			
			if (bInputStream != null) {
				byte[] data = new byte[2048];
				while (bInputStream.read(data) != -1) {
					out.write(data);
				}
			}
			
			out.flush();
			// flush������Ļ���
			// ����BufferedReader����������ȡURL����Ӧ
			in = new BufferedReader(
					new InputStreamReader(conn.getInputStream()));
			String line;
			while ((line = in.readLine()) != null) {
				result.append(line);
			}
		} catch (Exception e) {
//			System.out.println("���� POST ��������쳣��" + e);
			result = new StringBuilder("{\"resCode\":\"1\",\"errCode\":\"1001\",\"resData\":\"\"}");
			e.printStackTrace();
		}
		// ʹ��finally�����ر��������������
		finally {
			try {
				if (out != null) {
					out.close();
				}
				if (in != null) {
					in.close();
				}
				if (bInputStream != null) {
					bInputStream.close();
				}
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}

		return result.toString();
	}
}