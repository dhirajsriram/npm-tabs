const { exec } = require('child_process');
exec("/npm-tabs.sh", (err, stdout, stderr) => {
  if (err) {
    console.error(err);
    return;
  }
  console.log(stdout);
});

