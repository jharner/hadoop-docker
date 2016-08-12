import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FSDataInputStream;
import org.apache.hadoop.fs.FSDataOutputStream;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;


/**
 * Simple Driver to read/write to hdfs
 * @author ashrith
 *
 */
public class HadoopConnectTest {
  public HadoopConnectTest() {

  }

  public static void main(String[] args) {

	if (args.length < 1 || !args[0].startsWith("hdfs://")) {
	  System.out.println("must supply hdfs url");
	  System.exit(1);
	}


	try {
		Configuration conf = new Configuration();
		conf.set("fs.default.name", args[0]);
		FileSystem fs  = FileSystem.get(conf);
		Path p = new Path("/");
		if (!fs.exists(p)) {
			System.err.println("failed to find root");
			System.exit(1);
		}
		System.out.println("got a fs object from " + args[0]);
	} catch (Exception e) {
		System.err.println("hadoop test failed exception:" + e);
		e.printStackTrace();
		System.exit(1);
	}

	System.err.println("hadoop available");
  }
}
