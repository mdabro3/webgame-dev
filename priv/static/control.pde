class Control {

	int TRANSLATE_X = 0;
	int TRANSLATE_Y = 0;
	int TRANSLATE_RATE = 7;
	double SCALE = 1.0;
	double SCALE_RATE = 0.1;
	boolean[] locked;
	boolean[] keyDown;
	int[] keyCodes = {};


	Control() {
		locked = new boolean[256];
		keyDown = new boolean[256];
		handleKey('W');
        	handleKey('A');
        	handleKey('S');
        	handleKey('D');
	}

	private void setIfTrue(int mark, int target) {
		if(!locked[target]) {
			if(mark==target) {
				keyDown[target] = true; 
			}
		}
	}

	private void unsetIfTrue(int mark, int target) {
		if(mark==target) {
			locked[target] = false;
			keyDown[target] = false; 
		}
	}

	protected void ignore(char key) {
		int keyCode = int(key);
		locked[keyCode] = true;
		keyDown[keyCode] = false; 
	}

	protected void handleKey(char key) {
		int keyCode = int(key);
		len = keyCodes.length;
		int[] _tmp = new int[len+1];
		arrayCopy(keyCodes,0,_tmp,0,len);
		_tmp[len] = keyCode;
		keyCodes = _tmp;
	}

	protected boolean isKeyDown(char key) {
		int keyCode = int(key);
		return keyDown[keyCode];
	}

	protected boolean noKeysDown() {
		for(boolean b: keyDown) { if(b) return false; }
		for(boolean b: locked) { if(b) return false; }
		return true;
	}

	void myKeyPressed(char key, int keyCode) {
		for(int i: keyCodes) {
			setIfTrue(keyCode, i); 
		}
	}

	void myKeyReleased(char key, int keyCode) {
		for(int i: keyCodes) {
			unsetIfTrue(keyCode, i); 
		}
	}

	void keyPressed() { myKeyPressed(key, keyCode); }
	void keyReleased() { myKeyReleased(key, keyCode); }

	void viewLoop() {
		if (keyPressed) {
			if (isKeyDown('W')) {
                        	TRANSLATE_Y += TRANSLATE_RATE;
                	}
                	if (isKeyDown('S')) {
                	        TRANSLATE_Y -= TRANSLATE_RATE;
                	}
                	if (isKeyDown('D')) {
                	        TRANSLATE_X += TRANSLATE_RATE;
                	}
                	if (isKeyDown('A')) {
                	        TRANSLATE_X -= TRANSLATE_RATE;
                	}
        	}
	}

	void scale_up() {
		SCALE += SCALE_RATE;
	}
	
	void scale_down() {
		SCALE -= SCALE_RATE;
	}		
}

